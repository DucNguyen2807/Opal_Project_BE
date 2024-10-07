using System.ComponentModel.DataAnnotations;

namespace Opal_Exe201.Data.Enums.SubscriptionEnums
{
    public class SubscriptionUpdateRequestModel
    {
        [Required(ErrorMessage = "Please input Subscription Name")]
        [StringLength(100, ErrorMessage = "Subscription Name cannot exceed 100 characters.")]
        public string SubName { get; set; } = null!;

        [Required(ErrorMessage = "Please input Duration")]
        [Range(1, 365, ErrorMessage = "Duration must be between 1 and 365 days.")]
        public int Duration { get; set; }

        [Required(ErrorMessage = "Please input price of coin pack")]
        [Range(1, 100000000, ErrorMessage = "Price must be between $1 and $100,000,000.")]
        [DataType(DataType.Currency, ErrorMessage = "Price must be a valid currency value.")]
        public decimal? Price { get; set; }

        [Required(ErrorMessage = "Please input Subscription Description")]
        [StringLength(500, ErrorMessage = "Subscription Description cannot exceed 500 characters.")]
        public string SubDescription { get; set; } = null!;
    }
}
