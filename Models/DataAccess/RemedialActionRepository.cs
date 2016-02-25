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
    public class RemedialActionRepository
    {

        private MySqlConnection _openConnection;


        public RemedialActionRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<RemedialAction>> GetRemedialActions()
        {
            IEnumerable<RemedialAction> result = await this._openConnection.QueryAsync<RemedialAction>(@" SELECT * FROM  vw_remedial_action where remedial_action_id > 0 order by name");
            return result;
        }

    }
}