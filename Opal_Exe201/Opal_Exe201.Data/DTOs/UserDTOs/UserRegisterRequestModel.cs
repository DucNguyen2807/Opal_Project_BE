using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.UserDTOs
{
    public class UserRegisterRequestModel
    {
        [Required(ErrorMessage = "Please input Username")]
        public string Username { get; set; } = null!;

        [Required(ErrorMessage = "Please input Password")]
        [PasswordPropertyText]
        public string Password { get; set; } = null!;

    }
}
