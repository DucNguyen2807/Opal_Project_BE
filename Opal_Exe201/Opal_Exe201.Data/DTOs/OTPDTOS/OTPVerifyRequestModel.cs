using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.OTPDTOS
{
    public class OTPVerifyRequestModel
    {
        [Required(ErrorMessage = "Please input your email")]
        [EmailAddress(ErrorMessage = "Invalid email format")]
        public string Email { get; set; } = null!;

        [Required(ErrorMessage = "Please input your OTP")]
        public string OTP { get; set; } = null!;
    }
}
