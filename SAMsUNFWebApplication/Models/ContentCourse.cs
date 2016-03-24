using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Models
{
    public class ContentCourse
    {
     public int  content_course_id { get; set; }
     public string name { get; set; }
    }

    public class ContentCourseCollection
    {
        public ContentCourse contentCourse { get; set; }
        public IEnumerable<ContentCourse> allContentCourses { get; set; }
        public IEnumerable<ContentCourse> singleContentCourse { get; set; }
        public SelectList contentcourseselectlist { get; set; }
    }
}