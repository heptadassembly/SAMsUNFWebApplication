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

namespace SAMsUNFWebApplication.Controllers.HomeRoom
{
    public class HomeRoomController : Controller
    {
        // GET: Student
        public async System.Threading.Tasks.Task<ActionResult> HomeRoom()
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new HomeRoomRepository(connection).GetHomeRooms();
                return View(result);
            }
        }

        public async System.Threading.Tasks.Task<ActionResult> GetHomeRoom(string id)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new HomeRoomRepository(connection).GetHomeRoom(id);
                return View(result);
            }
        }

        [HttpPost]
        public System.Web.Mvc.RedirectResult AddHomeRoom(string HomeRoomClassRoom, string HomeRoomRoomNumber, string schoolselectlist)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new HomeRoomRepository(connection).AddHomeRoom(HomeRoomClassRoom, HomeRoomRoomNumber, schoolselectlist);
                if (result == "success")
                {
                    return Redirect("HomeRoom/HomeRoom");
                }
                else
                {
                    return Redirect("HomeRoom/HomeRoom");
                }
            }
        }

        public System.Web.Mvc.RedirectResult AddHomeRm(string HomeRoomClassRoom, string HomeRoomRoomNumber, string schoolselectlist)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new HomeRoomRepository(connection).AddHomeRm(HomeRoomClassRoom, HomeRoomRoomNumber, schoolselectlist);
                if (result == "success")
                {
                    return Redirect("HomeRoom/HomeRoom");
                }
                else
                {
                    //do something else here.
                    return Redirect("HomeRoom/HomeRoom");
                }
            }
        }

        [HttpGet]
        public ActionResult AddHomeRoom()
        {
            return View("AddHomeRoom");
        }

        public System.Web.Mvc.RedirectResult EditHomeRm(string HomeRoomID, string HomeRoomClassRoom, string HomeRoomRoomNumber, string schoolselectlist)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new HomeRoomRepository(connection).EditHomeRm(HomeRoomID, HomeRoomClassRoom, HomeRoomRoomNumber, schoolselectlist);
                if (result == "success")
                {
                    return Redirect("HomeRoom/HomeRoom");
                }
                else
                {
                    //do something else here.
                    return Redirect("HomeRoom/HomeRoom");
                }
            }
        }

        [HttpGet]
        public ActionResult EditHomeRoom()
        {
            return View("EditHomeRoom");
        }
    }
}