using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Opal_Exe201.Controllers.Extensions;
using Opal_Exe201.Data.Mapper;
using Opal_Exe201.Service.Services.EmailServices;
using Opal_Exe201.Service.Services.EventServices;
using Opal_Exe201.Service.Services.NotificationServices;
using Opal_Exe201.Service.Services.OTPService;
using Opal_Exe201.Service.Services.PaymentServices;
using Opal_Exe201.Service.Services.SeedServices;
using Opal_Exe201.Service.Services.SubscriptionServices;
using Opal_Exe201.Service.Services.TaskServices;
using Opal_Exe201.Service.Services.UserServices;
using System.Text;
using static Opal_Exe201.Service.Services.FirebaseService.SendNotificationToFirebase;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDatabase();
builder.Services.AddUnitOfWork();

// Firebase Admin
FirebaseApp.Create(new AppOptions()
{
    Credential = GoogleCredential.FromFile("firebase_credentials.json"),
});

// Dependency Injection
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IEmailService, EmailService>();
builder.Services.AddScoped<IEventService, EventService>();
builder.Services.AddScoped<IOTPService, OTPService>();
builder.Services.AddScoped<ITaskService, TaskService>();
builder.Services.AddScoped<ISeedService, SeedService>();
builder.Services.AddScoped<IPaymentService, PaymentService>();
builder.Services.AddScoped<ISubscriptionService, SubscriptionService>();
builder.Services.AddScoped<IDeviceTokenService, DeviceTokenService>();
builder.Services.AddScoped<NotificationService>();
builder.Services.AddHostedService<NotificationBackgroundService>();
builder.Services.AddHttpClient();
builder.Services.AddScoped<IPayOSService, PayOSService>();

builder.Services.AddAutoMapper(typeof(MapperProfile).Assembly);

// Authentication
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
    });

// CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: "AllowAll", policy =>
    {
        policy
        .AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod();
    });
});

// Swagger
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

// Build and configure the HTTP request pipeline
var app = builder.Build();

//if (app.Environment.IsDevelopment())
//{
    app.UseSwagger();
    app.UseSwaggerUI();
//}

app.UseHttpsRedirection();
app.UseCors("AllowAll");
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers();
});

// Run the application
app.Run();
