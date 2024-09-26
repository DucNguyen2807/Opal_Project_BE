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

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
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



//========================================== AUTHENTICATION =======================================

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer("Bearer", options =>
    {
        options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
        {
            ValidIssuer = "OpalUser",
            ValidAudience = "OpalUser",
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("j0ry6WqdAsqBWKOkBmgAx3Ded8WQSRr2yCC6IjgBgSZYId3VjFXHOU9efwmsEZMF")),
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateIssuerSigningKey = true,
            ValidateLifetime = true,
        };
    });

//=========================================== CORS ================================================

builder.Services.AddCors(options =>
{
    options.AddPolicy(name: "AllowAll",
                      policy =>
                      {
                          policy
                          //.WithOrigins("http://localhost:3000")
                          .AllowAnyOrigin()
                          .AllowAnyHeader()
                          .AllowAnyMethod();
                          //.AllowCredentials();
                      });
});

//================================================ SWAGGER ========================================

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

//===================================================================================================


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

//===================================================================================================


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowAll");

app.UseHangfireDashboard();
RecurringJob.AddOrUpdate<INotificationService>(service => service.NotifyUsersBeforeEvent(), Cron.Minutely);

app.UseAuthorization();

app.MapControllers();

app.Run();
