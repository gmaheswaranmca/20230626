using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FlightSystemProject.Models;
using FlightSystemProject.Util;//i

namespace FlightSystemProject.Controllers
{
    public class AdminLoginController : Controller
    {
        private FlightSystemDbContext context = new FlightSystemDbContext();//ii
        private SessionUtil util = new SessionUtil();
        // GET: AdminLogin
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
        public ActionResult Index(Admin formAdmin)
        {

            if (!ModelState.IsValid)
            {
                return View(formAdmin);
            }

            var oldAdmin = (from a in context.Admins
                            where a.Username.Equals(formAdmin.Username) && a.Password.Equals(formAdmin.Password)
                            select a).SingleOrDefault();
            if(oldAdmin == null)
            {
                ModelState.AddModelError("", "Invalid Username / Password");
                return View(formAdmin);
            }
            Session["App"] = "AdminApp";
            Session["UserId"] = oldAdmin.AdminId;
            Session["Username"] = oldAdmin.Username;
            return RedirectToAction("Index","FlightManagement");
        }

        public ActionResult Logout()
        {
            var loginData = util.GetAdminLoginData(Session);
            if (loginData == null)
            {
                return RedirectToAction("Index", "AdminLogin", new { error="Unauthorized Access" });
            }
            Session["App"] = null;
            Session["UserId"] = null;
            Session["Username"] = null;
            return RedirectToAction("Index");
        }
    }
}