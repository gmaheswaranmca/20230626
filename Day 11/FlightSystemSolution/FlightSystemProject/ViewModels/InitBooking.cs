using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FlightSystemProject.Models;
using System.ComponentModel.DataAnnotations;

namespace FlightSystemProject.ViewModels
{
    public class InitBooking
    {
        public InitBooking()
        {
            SelectedFlight = new Flight();
        }
        private int flightId;
        private Flight selectedFlight;

        public int FlightId
        {
            get => flightId; set
            {
                flightId = value;
            }
        }

        [Display(Name = "Source")]
        [Required(ErrorMessage = "Please Enter Source")]
        [Range(1, 5, ErrorMessage = "Source should be minumum 1 letters wide")]
        public int NumberOfPassengers { get; set; }

        public Flight SelectedFlight { get => selectedFlight; set => selectedFlight = value; }
    }
}