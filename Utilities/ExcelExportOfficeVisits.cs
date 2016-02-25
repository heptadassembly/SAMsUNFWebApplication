using OfficeOpenXml;
using OfficeOpenXml.Style;
using SAMsUNFWebApplication.Models;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Web;

namespace SAMsUNFWebApplication.Utilities
{
    public class OfficeVisitExcelGenerator
    {
        public static Byte[] GenerateXLS(List<OfficeVisit> datasource)
        {
            /* Call OpenOfficeXML need nuget package for epplus
               This can now be customize for each type of  excel export, also we can make a abstract calls for data dumps
               My want abastrct it out os multiple worksheets can be created.
            */
            using (ExcelPackage pck = new ExcelPackage())
            {
                //Create the worksheet 
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("OfficeVisits");
            
                //Set Header titles
                ws.Cells[1, 1].Value = "StudentId";
                ws.Cells[1, 2].Value = "Name";
                ws.Cells[1, 3].Value = "Visit";
                ws.Cells[1, 4].Value = "Date";
                ws.Cells[1, 5].Value = "School";
                ws.Cells[1, 6].Value = "Grade";
                ws.Cells[1, 7].Value = "Homeroom";
                ws.Cells[1, 8].Value = "Content";
                ws.Cells[1, 9].Value = "SentBy";
                ws.Cells[1, 10].Value = "Offenses";
                ws.Cells[1, 11].Value = "Arrived";
                ws.Cells[1, 12].Value = "HandledBy";
                ws.Cells[1, 13].Value = "Consequences";
                ws.Cells[1, 14].Value = "Comment";

                //Get Data
                for (int i = 0; i < datasource.Count(); i++)
                {
                    ws.Cells[i + 2, 1].Value = datasource.ElementAt(i).student_number;
                    ws.Cells[i + 2, 2].Value = datasource.ElementAt(i).student_name;
                    ws.Cells[i + 2, 3].Value = datasource.ElementAt(i).total_visits;
                    ws.Cells[i + 2, 4].Value = datasource.ElementAt(i).office_visit_dt.ToShortDateString();
                    ws.Cells[i + 2, 5].Value = datasource.ElementAt(i).school_name;
                    ws.Cells[i + 2, 6].Value = datasource.ElementAt(i).grade_value;
                    ws.Cells[i + 2, 7].Value = datasource.ElementAt(i).homeroom_name;
                    ws.Cells[i + 2, 8].Value = datasource.ElementAt(i).content_course_name;
                    ws.Cells[i + 2, 9].Value = datasource.ElementAt(i).sent_by_contact_name;
                    ws.Cells[i + 2, 10].Value = datasource.ElementAt(i).offenses;
                    ws.Cells[i + 2, 11].Value = datasource.ElementAt(i).arrival_dt.ToShortTimeString();
                    ws.Cells[i + 2, 12].Value = datasource.ElementAt(i).handled_by_contact_name;
                    ws.Cells[i + 2, 13].Value = datasource.ElementAt(i).consequences;
                    ws.Cells[i + 2, 14].Value = datasource.ElementAt(i).comments;

                }

                //Set Header style
                using (ExcelRange rng = ws.Cells[1,1,1,14])
                {
                    rng.AutoFilter = true;
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    rng.Style.Fill.BackgroundColor.SetColor(Color.Blue);
                    rng.Style.Font.Color.SetColor(Color.White);
                }

               
                return pck.GetAsByteArray();
            }
        }
    }
}