using Microsoft.EntityFrameworkCore;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;

namespace Opal_Exe201.Controllers.Extensions
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddUnitOfWork(this IServiceCollection services)
        {
            services.AddScoped<IUnitOfWork, UnitOfWork>();
            return services;
        }

        public static IServiceCollection AddDatabase(this IServiceCollection services)
        {
            services.AddDbContext<OpalExeContext>(options => options.UseSqlServer(GetConnectionString()));
            return services;
        }
        private static string GetConnectionString()
        {
            IConfigurationRoot config = new ConfigurationBuilder()
             .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json", true, true)
                    .Build();
            var strConn = config["ConnectionStrings:DefaultConnectionString"];

            return strConn;
        }
    }
}