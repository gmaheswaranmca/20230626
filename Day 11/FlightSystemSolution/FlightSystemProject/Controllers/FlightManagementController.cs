using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlightSystemProject.Models;//i
using FlightSystemProject.Util;//i

namespace FlightSystemProject.Controllers
{
    public class FlightManagementController : Controller
    {
        
        private FlightSystemDbContext context = new FlightSystemDbContext();//ii
        private SessionUtil util = new SessionUtil();
        // GET: FlightManagement
        public ActionResult Index()//1
        {
            var loginData = util.GetAdminLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "AdminLogin", new { error = "Unauthorized Access" });
            }
            var allFlights = (from f in context.Flights
                              select f).ToList();//iii
            return View(allFlights);
        }
        public ActionResult Create()//2
        {
            var loginData = util.GetAdminLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "AdminLogin", new { error = "Unauthorized Access" });
            }
            var newFlight = new Flight();
            newFlight.FlightNumber = string.Empty;
            newFlight.AirlineName = string.Empty;
            newFlight.Source = string.Empty;
            newFlight.Destination = string.Empty;
            newFlight.TravelDate = DateTime.Now.Date;
            newFlight.NumberOfSeats = 0;
            newFlight.TicketFare = 0.0;

            return View(newFlight);
        }
        [HttpPost]
        [ValidateAntiForgeryToken] 
        public ActionResult Create(Flight formFlight)
        {
            
            if (!ModelState.IsValid)
            {
                return View(formFlight);
            }

            var newFlight = new Flight();
            newFlight.FlightNumber = formFlight.FlightNumber;
            newFlight.AirlineName = formFlight.AirlineName;
            newFlight.Source = formFlight.Source;
            newFlight.Destination = formFlight.Destination;
            newFlight.TravelDate = formFlight.TravelDate;
            newFlight.NumberOfSeats = formFlight.NumberOfSeats;
            newFlight.TicketFare = formFlight.TicketFare;

            context.Flights.Add(newFlight);
            context.SaveChanges();
            //return RedirectToAction("Index");  // Goto Index action of this controller  
            return RedirectToAction("Index","FlightManagement",new { }); // Goto Index of FlightManagement controller   
        }
        public ActionResult Edit(int id)
        {
            var loginData = util.GetAdminLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "AdminLogin", new { error = "Unauthorized Access" });
            }
            var oldFlight = (from f in context.Flights
                             where f.FlightId == id
                             select f).SingleOrDefault();
            if(oldFlight == null)
            {
                return HttpNotFound();
            }

            return View(oldFlight);
        }
        [HttpPost]
        [ValidateAntiForgeryToken] 
        public ActionResult Edit(Flight formFlight)
        {
            if (!ModelState.IsValid)
            {
                return View(formFlight);
            }

            var oldFlight = (from f in context.Flights
                             where f.FlightId == formFlight.FlightId
                             select f).SingleOrDefault();
            if(oldFlight == null)
            {
                return HttpNotFound();
            }
            oldFlight.FlightNumber = formFlight.FlightNumber;
            oldFlight.AirlineName = formFlight.AirlineName;
            oldFlight.Source = formFlight.Source;
            oldFlight.Destination = formFlight.Destination;
            oldFlight.TravelDate = formFlight.TravelDate;
            oldFlight.NumberOfSeats = formFlight.NumberOfSeats;
            oldFlight.TicketFare = formFlight.TicketFare;

            context.SaveChanges();

            return RedirectToAction("Index");
        }

        public ActionResult Delete(int id)
        {
            var loginData = util.GetAdminLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "AdminLogin", new { error = "Unauthorized Access" });
            }
            var oldFlight = (from f in context.Flights
                             where f.FlightId == id
                             select f).SingleOrDefault();
            if (oldFlight == null)
            {
                return HttpNotFound();
            }
            context.Flights.Remove(oldFlight);
            context.SaveChanges();

            return RedirectToAction("Index");
        }
    }
}