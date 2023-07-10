using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FlightSystemProject.Models;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
namespace FlightSystemProject.ViewModels
{
    public class SearchFlight
    {
        public SearchFlight()
        {
            this.SearchedFlights = new List<Flight>();
        }
        [Display(Name = "Source")]
        [Required(ErrorMessage = "Please Enter Source")]
        [StringLength(20, MinimumLength = 1, ErrorMessage = "Source should be minumum 1 letters wide")]
        public string Source { get; set; }

        [Display(Name = "Destination")]
        [Required(ErrorMessage = "Please Enter Destination")]
        [StringLength(20, MinimumLength = 1, ErrorMessage = "Destination should be minumum 1 letters wide")]
        public string Destination { get; set; }


        [Display(Name = "Travel Date")]
        [Required(ErrorMessage = "Please Enter Travel Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime TravelDate { get; set;  }

        public void DoSearch(FlightSystemDbContext context)
        {
            var allFlights = (from f in context.Flights
                              where f.Source.Equals(Source) &&
                                    f.Destination.Equals(Destination) &&
                                    DbFunctions.TruncateTime(f.TravelDate) == TravelDate.Date
                              select f).ToList();
            SearchedFlights = allFlights;
        }
        public List<Flight> SearchedFlights { get; set; }
    }
}