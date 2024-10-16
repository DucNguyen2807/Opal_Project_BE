using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.GenericRepository;
namespace Opal_Exe201.Data.Repositories.CustomizationRepositories
{
    public class CustomizationRepository : GenericRepository<Customization>, ICustomizationRepository
    {
        public CustomizationRepository(OpalExeContext context) : base(context)
        {
        }


    }
}
