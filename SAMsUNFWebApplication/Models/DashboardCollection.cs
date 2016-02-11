using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Models
{

    public class DashboardCollection
    {
        public IEnumerable<OfficeVisitsByTeacher> Teachers { get; set; }
        public IEnumerable<OfficeVisitsByHomeroom> Homerooms { get; set; }
        public IEnumerable<OfficeVisitsByOffenseType> OffenseTypes { get; set; }
        public IEnumerable<OfficeVisitsCountsByWeek> ByWeek { get; set; }
    }

    public class OfficeVisitsByTeacher
    {
        public string sent_by_contact_name { get; set; }
        public int total_visits { get; set; }
    }
    public class OfficeVisitsByHomeroom
    {
        public string school_name { get; set; }
        public string homeroom_name { get; set; }
        public string grade { get; set; }
        public int total_visits { get; set; }

    }
    public class OfficeVisitsByOffenseType
    {
        public string offense_type { get; set;}
        public int total_visits { get; set; }

    }

    public class OfficeVisitsCountsByWeek
    {
        public DateTime monday { get; set; }
        public int total_visits { get; set; }
        public string displayDate  { get
            {return monday.ToString("MM-dd-yy");}}

    }
}