using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Models
{
    public class School
    {
        public int school_id { get; set; }
        public string name { get; set; }
    }

    public class SchoolCollection
    {
        public School school { get; set; }
        public IEnumerable<School> allSchools { get; set; }
        public IEnumerable<School> singleSchool { get; set; }
        public SelectList schoolselectlist { get; set; }
    }
}