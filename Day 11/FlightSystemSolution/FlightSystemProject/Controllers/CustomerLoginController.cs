using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlightSystemProject.Models;
using FlightSystemProject.Util;//i

namespace FlightSystemProject.Controllers
{
    public class CustomerLoginController : Controller
    {
        private FlightSystemDbContext context = new FlightSystemDbContext();//ii
        private SessionUtil util = new SessionUtil();
        // GET: CustomerLogin
        public ActionResult Index(string error="")
        {
            if (!error.Equals(String.Empty))
            {
                ModelState.AddModelError("", error);
            }
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(Customer formCustomer)
        {

            if (!ModelState.IsValid)
            {
                return View(formCustomer);
            }

            var oldCustomer = (from a in context.Customers
                            where a.Username.Equals(formCustomer.Username) && a.Password.Equals(formCustomer.Password)
                            select a).SingleOrDefault();
            if(oldCustomer == null)
            {
                ModelState.AddModelError("", "Invalid Username / Password");
                return View(formCustomer);
            }
            Session["App"] = "CustomerApp";
            Session["UserId"] = oldCustomer.CustomerId;
            Session["Username"] = oldCustomer.Username;
            return RedirectToAction("Index","Booking");
        }

        public ActionResult Logout()
        {
            var loginData = util.GetCustomerLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "CustomerLogin", new { error="Unauthorized Access" });
            }
            Session["App"] = null;
            Session["UserId"] = null;
            Session["Username"] = null;
            return RedirectToAction("Index");
        }

        public ActionResult Register()
        {
            var newCustomer = new Customer();
            newCustomer.Name = string.Empty;
            newCustomer.MobileNumber = string.Empty;
            newCustomer.Username = string.Empty;
            newCustomer.Password = string.Empty;
            return View(newCustomer);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(Customer formCustomer)
        {

            if (!ModelState.IsValid)
            {
                return View(formCustomer);
            }

            var newCustomer = new Customer();
            newCustomer.Name = formCustomer.Name;
            newCustomer.MobileNumber = formCustomer.MobileNumber;
            newCustomer.Username = formCustomer.Username;
            newCustomer.Password = formCustomer.Password;

            context.Customers.Add(newCustomer);
            context.SaveChanges();

            return RedirectToAction("Index", "CustomerLogin", new { error="Welcome To Ticket Booking App. Please Login to plan your trip."});
        }
    }
}