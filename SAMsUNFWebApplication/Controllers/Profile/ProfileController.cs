using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SAMsUNFWebApplication.Models;
using MySql.Data.MySqlClient;
using System.Configuration;
using SAMsUNFWebApplication.Models.DataAccess;
using System.IO;
using Dapper;

namespace SAMsUNFWebApplication.Controllers.Profile
{
    public class ProfileController : Controller
    {
        [Authorize]
        // GET: School
        public ActionResult Index()
        {
            return View();
        }

        // GET: Student
        public async System.Threading.Tasks.Task<ActionResult> Profile()
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new ProfileRepository(connection).GetProfiles();
                //var result2 = await new SchoolRepository(connection).GetSchools();
                return View(result);
            }
        }

        public System.Web.Mvc.RedirectResult EditProfl(string ProfileID, string ProfileUserName, string ProfilePassword, string profilecontactselectlist)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new ProfileRepository(connection).EditProfl(ProfileID, ProfileUserName, ProfilePassword, profilecontactselectlist);
                if (result == "success")
                {
                    return Redirect("Profile/Profile/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    return Redirect("Profile/Profile/?error=invalidfile");
                }
            }
        }

        public System.Web.Mvc.RedirectResult AddProfl(string ProfileUserName, string ProfilePassword, string profilecontactselectlist)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new ProfileRepository(connection).AddProfl(ProfileUserName, ProfilePassword, profilecontactselectlist);
                if (result == "success")
                {
                    return Redirect("Profile/Profile/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    return Redirect("Profile/Profile/?error=invalidfile");
                }
            }
        }
    }
}