using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SAMsUNFWebApplication.Models
{
    public class Profile
    {

        
        public int ProfileId { get; set; }
        public int FirstName { get; set; }
        public int MiddleName { get; set; }
        public int LastName { get; set; }
        public int UserID { get; set; }
        public int Password { get; set; }

    }
}