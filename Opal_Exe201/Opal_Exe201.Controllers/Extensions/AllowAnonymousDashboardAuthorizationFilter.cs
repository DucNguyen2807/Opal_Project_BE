using Hangfire.Dashboard;

namespace Opal_Exe201.Controllers.Extensions
{
    public class AllowAnonymousDashboardAuthorizationFilter : IDashboardAuthorizationFilter
    {
        public bool Authorize(DashboardContext context)
        {
            return true;
        }
    }
}