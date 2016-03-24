using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Models
{
    public class HomeRoom
    {
        public int homeroom_id { get; set;}
        public string school_name { get; set; }
        public string room_number { get; set;}
        public string homeroom_name { get; set; }
        public int school_id { get; set; }
    }

    public class HomeRoomCollection
    {
        public HomeRoom homeroom { get; set; }
        public IEnumerable<HomeRoom> allHomeRooms { get; set; }
        public IEnumerable<HomeRoom> singleHomeRoom { get; set; }
        public IEnumerable<School> singleSchool { get; set; }
        public IEnumerable<School> allSchools { get; set; }
        public SelectList schoolselectlist { get; set; }
    }
}