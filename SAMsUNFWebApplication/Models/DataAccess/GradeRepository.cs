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
    public class GradeRepository
    {
        private MySqlConnection _openConnection;

        public GradeRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<Grade>> GetGrades()
        {
            // Read the user by their username in the database. 
            IEnumerable<Grade> result = await this._openConnection.QueryAsync<Grade>(@" SELECT * FROM vw_grade where grade_id > 0");
            return result;
        }
    }
}