using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.UserDTOs
{

    public class GetAllUserResponseModel
    {
        public int TotalUser { get; set; }
        public List<ViewUserResponseModel> Users { get; set; }
    }


    public class ViewUserResponseModel
    {
        public string UserId { get; set; } = null!;

        public string Username { get; set; } = null!;

        public string Password { get; set; } = null!;

        public string? Fullname { get; set; }

        public string? Email { get; set; }

        public string? Gender { get; set; }

        public string? PhoneNumber { get; set; }

        public string? SubscriptionPlan { get; set; }

        public string? Role { get; set; }

        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }
    }
}
