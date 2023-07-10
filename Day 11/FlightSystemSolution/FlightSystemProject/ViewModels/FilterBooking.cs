using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using FlightSystemProject.Models;
namespace FlightSystemProject.ViewModels
{
    public class FilterBooking
    {
        [Display(Name = "From Date")]
        [Required(ErrorMessage = "Please Enter From Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime FromDate;

        [Display(Name = "To Date")]
        [Required(ErrorMessage = "Please Enter To Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime ToDate;

        public FilterBooking()
        {
            bookings = new List<Booking>();
        }
        public List<Booking> bookings { set; get; }
    }
}