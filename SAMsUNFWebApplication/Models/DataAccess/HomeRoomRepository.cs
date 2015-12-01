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
            IEnumerable<HomeRoom> result = await this._openConnection.QueryAsync<HomeRoom>(@" SELECT * FROM  vw_homeroom");
            return result;
        }

    }
}