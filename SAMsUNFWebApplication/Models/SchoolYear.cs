using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SAMsUNFWebApplication.Models
{
    public class SchoolYear
    {
        public int school_year_id { get; set; }
        public bool is_current { get; set; }
        public int last_update_contact_id { get; set; }
        public DateTime last_update_dt { get; set; }
        public DateTime create_dt { get; set; }
        public int create_contact_id { get; set; }
    }
}