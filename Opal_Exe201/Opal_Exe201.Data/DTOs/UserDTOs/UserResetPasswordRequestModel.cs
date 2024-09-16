using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.UserDTOs
{
    public class UserResetPasswordRequestModel
    {
        [Required(ErrorMessage = "Please input email")]
        [EmailAddress(ErrorMessage = "Invalid email format")]
        public string Email { get; set; } = null!;

        [Required(ErrorMessage = "Please input new password")]
        public string NewPassword { get; set; } = null!;

        [Required(ErrorMessage = "Please input confirm password")]
        public string ConfirmPassword { get; set; } = null!;
    }
}
