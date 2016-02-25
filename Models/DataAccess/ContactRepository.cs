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
    public class ContactRepository
    {

        private MySqlConnection _openConnection;


        public ContactRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<Contact>> GetContacts()
        {
            // Read the user by their username in the database. 
            IEnumerable<Contact> result = await this._openConnection.QueryAsync<Contact>(@" SELECT * FROM  vw_contact where contact_id > 0 order by last_name");
            return result;
        }

    }
}