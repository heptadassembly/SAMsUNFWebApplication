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
            IEnumerable<HomeRoom> result = await this._openConnection.QueryAsync<HomeRoom>(@" SELECT * FROM  samsjacksonville.vw_homeroom where homeroom_id > 0 order by  homeroom_name");
            return result;
        }
        public async Task<IEnumerable<HomeRoom>> GetHomeRoom(string homeroom_id)
        {
            IEnumerable<HomeRoom> result = await this._openConnection.QueryAsync<HomeRoom>(@" SELECT * FROM  samsjacksonville.homeroom where homeroom_id = " + homeroom_id + ";");
            return result;
        }

        public async Task<IEnumerable<HomeRoom>> GetSortedHomeRooms(string homeroom_id)
        {
            IEnumerable<HomeRoom> result = await this._openConnection.QueryAsync<HomeRoom>(@" SELECT * FROM  samsjacksonville.homeroom order by case when homeroom_id = " + homeroom_id + " then -2 else homeroom_id end;");
            return result;
        }

    }
}