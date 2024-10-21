using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.UserDTOs
{
    public class UserLoginResponseModel
    {
        public UserInfo UserInfo { get; set; } = null!;
        public string token { get; set; } = null!;
    }

    public class UserInfo
    {
        public string UserId { get; set; } = null!;
        public string Username { get; set; } = null!;
        public string FullName { get; set; } = null!;
        public string Role {  get; set; } = null!;  
        public string Gender { get; set; } = null!;
        public string PhoneNumber { get; set; } = null!;
        public string SubscriptionPlan { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string Email { get; set; } = null!;
    }
}
