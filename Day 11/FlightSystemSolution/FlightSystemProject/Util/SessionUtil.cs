using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlightSystemProject.Util
{
    public class SessionUtil
    {
        public dynamic GetAdminLoginData(HttpSessionStateBase Session)
        {
            if (Session["App"] == null || Session["Username"] == null)
            {
                return null;
            }

            var loginData = new
            {
                App = (string)Session["App"],
                UserId = (int)Session["UserId"],
                Username = (string)Session["Username"]
            };

            if (!loginData.App.Equals("AdminApp"))
            {
                return null;
            }
            return loginData;
        }
        public dynamic GetCustomerLoginData(HttpSessionStateBase Session)
        {
            if (Session["App"] == null || Session["Username"] == null)
            {
                return null;
            }

            var loginData = new
            {
                App = (string)Session["App"],
                UserId = (int)Session["UserId"],
                Username = (string)Session["Username"]
            };

            if (!loginData.App.Equals("CustomerApp"))
            {
                return null;
            }
            return loginData;
        }
    }
}