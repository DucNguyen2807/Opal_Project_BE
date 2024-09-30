using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Opal_Exe201.Controllers.Extensions;
using Opal_Exe201.Data.Mapper;
using Opal_Exe201.Service.Services.EmailServices;
using Opal_Exe201.Service.Services.EventServices;
using Opal_Exe201.Service.Services.OTPService;
using Opal_Exe201.Service.Services.TaskServices;
using Opal_Exe201.Service.Services.UserServices;
using Hangfire;
using System.Text;
using Opal_Exe201.Service.Services.NotificationServices;
using Microsoft.AspNetCore.SignalR;
using Opal_Exe201.Controllers.Hubs;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDatabase();
builder.Services.AddUnitOfWork();

//========================================== DependencyInjection =======================================
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IEmailService, EmailService>();
builder.Services.AddScoped<IEventService, EventService>();
builder.Services.AddScoped<IOTPService, OTPService>();
builder.Services.AddScoped<ITaskService, TaskService>();
builder.Services.AddScoped<INotificationService, NotificationService>();
builder.Services.AddAutoMapper(typeof(MapperProfile).Assembly);

//========================================== SignalR =======================================
builder.Services.AddSignalR();

//========================================== AUTHENTICATION =======================================
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidIssuer = "OpalUser",
            ValidAudience = "OpalUser",
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("j0ry6WqdAsqBWKOkBmgAx3Ded8WQSRr2yCC6IjgBgSZYId3VjFXHOU9efwmsEZMF")),
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateIssuerSigningKey = true,
            ValidateLifetime = true,
        };
        // Pass JWT tokens via query string for SignalR
        options.Events = new JwtBearerEvents
        {
            OnMessageReceived = context =>
            {
                var accessToken = context.Request.Query["access_token"];
                var path = context.HttpContext.Request.Path;

                if (!string.IsNullOrEmpty(accessToken) && path.StartsWithSegments("/notificationhub"))
                {
                    context.Token = accessToken;
                }
                return Task.CompletedTask;
            }
        };
    });

//=========================================== CORS ================================================
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: "AllowSpecificOrigin",
                      policy =>
                      {
                          policy.WithOrigins("https://10.0.2.2:7203")
                                .AllowAnyHeader()
                                .AllowAnyMethod()
                                .AllowCredentials();
                      });
});

//========================================== Swagger & Hangfire ===================================
builder.Services.AddSwaggerGen(options =>
{
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme()
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "JWT Authorization header using the Bearer scheme. \r\n\r\n Enter 'Bearer' [space] and then your token in the text input below.\r\n\r\nExample: \"Bearer 1safsfsdfdfd\"",
    });
    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new string[] {}
        }
    });
});

builder.Services.AddHangfire(config =>
{
    config.UseSqlServerStorage(builder.Configuration.GetConnectionString("DefaultConnectionString"));
    config.SetDataCompatibilityLevel(CompatibilityLevel.Version_170);
    config.UseSimpleAssemblyNameTypeSerializer();
    config.UseRecommendedSerializerSettings();
});

builder.Services.AddHangfireServer(options =>
{
    options.WorkerCount = 1;
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowSpecificOrigin");

app.UseRouting();

app.UseHangfireDashboard();
RecurringJob.AddOrUpdate<INotificationService>(service => service.NotifyUsersBeforeEvent(), Cron.Minutely);

app.UseAuthorization();

app.UseEndpoints(endpoints =>
{
    endpoints.MapHub<NotificationHub>("/notificationhub");
    endpoints.MapControllers();
});

app.Run();
