using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlightSystemProject.ViewModels
{
    public class FormBookingPassenger
    {
        public int Sno { get; set; }
        public string PassengerName { get; set; } 
        public int Age { get; set; }
        public string IdCardDetails { get; set; }
    }
}