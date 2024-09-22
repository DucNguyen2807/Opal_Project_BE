using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.UserDTOs
{
    public class UpdateByUserModel
    {
        [Required(ErrorMessage = "Fullname is required")]
        public string Fullname { get; set; } = null!;

        [Required(ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid email format")]
        public string Email { get; set; } = null!;

        [Required(ErrorMessage = "Phone number is required")]
        [RegularExpression(@"^0\d{9,11}$", ErrorMessage = "Phone number must start with 0 and be between 10 to 12 digits")]
        public string PhoneNumber { get; set; } = null!;


        [Required(ErrorMessage = "Gender is required")]
        public string Gender { get; set; } = null!;
    }
}
