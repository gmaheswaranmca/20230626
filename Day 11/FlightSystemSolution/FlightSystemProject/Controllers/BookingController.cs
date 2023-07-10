using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlightSystemProject.Models;//i
using FlightSystemProject.ViewModels;//i
using FlightSystemProject.Util;//i
using System.Data.Entity;

namespace FlightSystemProject.Controllers
{
    public class BookingController : Controller
    {
        private FlightSystemDbContext context = new FlightSystemDbContext();//ii
        private SessionUtil util = new SessionUtil();
        // GET: Booking
        public ActionResult Index()//booking - search flight - pick flight
        {
            var loginData = util.GetCustomerLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "CustomerLogin", new { error = "Unauthorized Access" });
            }
            var newSearchFlight = new SearchFlight();
            newSearchFlight.Source = string.Empty;
            newSearchFlight.Destination = string.Empty;
            newSearchFlight.TravelDate = DateTime.Now;
            return View(newSearchFlight);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(SearchFlight formSearchFlight)
        {
            if (!ModelState.IsValid)
            {
                return View(formSearchFlight);
            }
            formSearchFlight.DoSearch(context);
            return View(formSearchFlight);
        }
        public ActionResult PassengersCount(int flightId)//number of passengers
        {
            var loginData = util.GetCustomerLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "CustomerLogin", new { error = "Unauthorized Access" });
            }
            var newFlight = (from f in context.Flights
                             where f.FlightId == flightId
                             select f).SingleOrDefault();
            if (newFlight == null)
            {
                return RedirectToAction("Index");
            }

            var newInitBooking = new InitBooking();
            newInitBooking.FlightId = newFlight.FlightId;
            newInitBooking.SelectedFlight = newFlight;
            newInitBooking.NumberOfPassengers = 1;
            return View(newInitBooking);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PassengersCount(InitBooking formInitBooking)//number of passengers
        {
            var loginData = util.GetCustomerLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "CustomerLogin", new { error = "Unauthorized Access" });
            }
            var newFlight = (from f in context.Flights
                             where f.FlightId == formInitBooking.FlightId
                             select f).SingleOrDefault();
            if (newFlight == null)
            {
                return RedirectToAction("Index");
            }

            return RedirectToAction("DoBooking", "Booking", new { flightId = formInitBooking.FlightId, numberOfPassengers = formInitBooking.NumberOfPassengers });
        }
        public ActionResult DoBooking(int flightId, int numberOfPassengers)//fill customer details
        {
            var loginData = util.GetCustomerLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "CustomerLogin", new { error = "Unauthorized Access" });
            }
            var newFlight = (from f in context.Flights
                             where f.FlightId == flightId
                             select f).SingleOrDefault();
            if (newFlight == null)
            {
                return RedirectToAction("Index");
            }
            var newFormBooking = new FormBooking();
            newFormBooking.FlightId = newFlight.FlightId;
            newFormBooking.NumberOfPassengers = numberOfPassengers;
            newFormBooking.SelectedFlight = newFlight;
            newFormBooking.passengers = new List<FormBookingPassenger>();
            for (var I = 0; I < numberOfPassengers; I++)
            {
                var passenger = new FormBookingPassenger();
                passenger.Sno = I + 1;
                passenger.PassengerName = string.Empty;
                passenger.Age = 0;
                passenger.IdCardDetails = string.Empty;
                //
                newFormBooking.passengers.Add(passenger);
            }
            return View(newFormBooking);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DoBooking(FormBooking formBooking)//filled customer details
        {
            var newFlight = (from f in context.Flights
                             where f.FlightId == formBooking.flightId
                             select f).SingleOrDefault();
            if (newFlight == null)
            {
                return RedirectToAction("Index");
            }
            formBooking.SelectedFlight = newFlight;

            Booking booking = new Booking();
            booking.CustomerId = (int)Session["UserId"];
            booking.FlightId = formBooking.flightId;
            booking.NumberOfPassengers = formBooking.NumberOfPassengers;
            booking.BillAmount = formBooking.NumberOfPassengers * newFlight.TicketFare;
            booking.BookingDate = DateTime.Now;
            booking.TravelDate = newFlight.TravelDate;

            var maxNoStr = (from b in context.Bookings
                            select b.BookingNumber).Max();
            long maxNo = 100200100;
            if (maxNoStr != null)
            {
                maxNo = long.Parse(maxNoStr);
            }
            booking.BookingNumber = string.Format("{0,9:D9}", (maxNo + 1));

            context.Bookings.Add(booking);
            context.SaveChanges();
            booking.BookingPassengers = new List<BookingPassenger>();

            if (formBooking.Sno != null)
            {
                for (int I = 0; I < formBooking.Sno.Length; I++)
                {
                    var passenger = new BookingPassenger();
                    passenger.SerialNumber = formBooking.Sno[I];
                    passenger.PassengerName = formBooking.PassengerName[I];
                    passenger.Age = formBooking.Age[I];
                    passenger.IdCardDetails = formBooking.IdCardDetails[I];
                    passenger.BookingId = booking.BookingId;
                    passenger.TicketNumber = booking.BookingNumber + string.Format("{0,2:D2}", passenger.SerialNumber);
                    booking.BookingPassengers.Add(passenger);
                }
            }
            context.SaveChanges();

            return RedirectToAction("Index");
        }
        public ActionResult PastBookings()//filter by fromDate toDate
        {
            var loginData = util.GetCustomerLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "CustomerLogin", new { error = "Unauthorized Access" });
            }
            var filterBookings = new FilterBooking();

            filterBookings.FromDate = DateTime.Now;
            filterBookings.ToDate = DateTime.Now;

            var bookings = (from b in context.Bookings
                            where DbFunctions.TruncateTime(b.BookingDate) >= filterBookings.FromDate.Date &&
                            DbFunctions.TruncateTime(b.BookingDate) <= filterBookings.ToDate.Date
                            orderby b.BookingDate descending
                            select b).ToList();
            filterBookings.bookings = bookings;
            return View(filterBookings);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PastBookings(FilterBooking filterBooking)//filter by fromDate toDate
        {
            return View();
        }
    }
}