using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.UserDTOs
{
    public class UserLoginRequestModel
    {

        [Required(ErrorMessage = "Please input your username")]
        public string Username { get; set; } = null!;

        [Required(ErrorMessage = "Please input your password")]
        public string Password { get; set; } = null!;
    }
}
