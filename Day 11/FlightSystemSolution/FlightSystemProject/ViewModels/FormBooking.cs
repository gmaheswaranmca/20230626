using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FlightSystemProject.Models;
using System.ComponentModel.DataAnnotations;
namespace FlightSystemProject.ViewModels
{
    public class FormBooking
    {
        public FormBooking()
        {
            SelectedFlight = new Flight();
        }
        public int flightId;
        public int FlightId
        {
            get => flightId; set
            {
                flightId = value;
            }
        }
        
        public int NumberOfPassengers { get; set; }

        private Flight selectedFlight;
        public Flight SelectedFlight { get => selectedFlight; set => selectedFlight = value; }

        public List<FormBookingPassenger> passengers = new List<FormBookingPassenger>();

        public int[] Sno { get; set; }
        public string[] PassengerName { get; set; }
        public int[] Age { get; set; }
        public string[] IdCardDetails { get; set; }
    }
}