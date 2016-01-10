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
    public class SchoolYearRepository
    {
        private MySqlConnection _openConnection;

        public SchoolYearRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<SchoolYear>> GetSchoolYear()
        {
            // Read the user by their username in the database. 
            IEnumerable<SchoolYear> result = await this._openConnection.QueryAsync<SchoolYear>(@" SELECT * FROM samsjacksonville.school_year");
            return result;
        }
    }
}