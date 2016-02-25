using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using SAMsUNFWebApplication.Models;
using System.Web;
using System.Configuration;

namespace SAMsUNFWebApplication.Models.DataAccess
{
    public class HomeRoomRepository
    {

        private MySqlConnection _openConnection;


        public HomeRoomRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<HomeRoom>> GetHomeRooms()
        {
            // Read the user by their username in the database. 
            IEnumerable<HomeRoom> result = await this._openConnection.QueryAsync<HomeRoom>(@" SELECT * FROM samsjacksonville.vw_homeroom");
            return result;
        }

        public async Task<IEnumerable<HomeRoom>> GetHomeRoom(string id)
        {
            IEnumerable<HomeRoom> result = await this._openConnection.QueryAsync<HomeRoom>(@" SELECT * FROM  samsjacksonville.homeroom where homeroom_id = " + id + ";");
            return result;
        }

        public async Task<IEnumerable<HomeRoom>> GetSortedHomeRooms(string homeroom_id)
        {
            IEnumerable<HomeRoom> result = await this._openConnection.QueryAsync<HomeRoom>(@" SELECT * FROM  samsjacksonville.homeroom order by case when homeroom_id = " + homeroom_id + " then -2 else homeroom_id end;");
            return result;
        }

        public string AddHomeRm(string HomeRoomClassRoom, string HomeRoomRoomNumber, string selectschoollist)
        {
            //To do Items
            //Get Current Logged on User and put into variable.
            //Get Current Date/Time and put into variable.
            //Get Current School Year Selection and put into variable.
            var queryString = @"INSERT INTO samsjacksonville.homeroom (homeroom_name, room_number, school_id, school_year_id) VALUES ('" + HomeRoomClassRoom + "','" + HomeRoomRoomNumber + "'," + selectschoollist + ", samsjacksonville.fn_getSchoolYear(1));";
            _openConnection.Execute(queryString);
            return "success";
        }

        public string AddHomeRoom(string HomeRoomClassRoom, string HomeRoomRoomNumber, string selectschoollist)
        {
            //To do Items
            //Get Current Logged on User and put into variable.
            //Get Current Date/Time and put into variable.
            //Get Current School Year Selection and put into variable.
            var queryString = @"INSERT INTO samsjacksonville.homeroom (homeroom_name, room_number, school_id, school_year_id) VALUES ('" + HomeRoomClassRoom + "','" + HomeRoomRoomNumber + "'," + selectschoollist + ", samsjacksonville.fn_getSchoolYear(1));";
            _openConnection.Execute(queryString);
            return "success";
        }

        public string EditHomeRm(string HomeRoomID, string HomeRoomClassRoom, string HomeRoomRoomNumber, string selectschoollist)
        {
            var queryString = @"Update samsjacksonville.homeroom set homeroom_name = '" + HomeRoomClassRoom + "', room_number = '" + HomeRoomRoomNumber + "', school_id = " + selectschoollist + " where homeroom_id = " + HomeRoomID + ";";
            _openConnection.Execute(queryString);
            return "success";
        }

    }
}