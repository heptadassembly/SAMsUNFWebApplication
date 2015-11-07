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
    public class ExcelGenerator
    {
        public static Byte[] GenerateXLS(List<Student> datasource)
        {
            /* Call OpenOfficeXML need nuget package for epplus
               This can now be customize for each type of  excel export, also we can make a abstract calls for data dumps
               My want abastrct it out os multiple worksheets can be created.
            */
            using (ExcelPackage pck = new ExcelPackage())
            {
                //Create the worksheet 
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Students");

                //Set Header titles
                ws.Cells[1, 1].Value = "Student Id";
                ws.Cells[1, 2].Value = "First Name";
                ws.Cells[1, 3].Value = "Last Name";
                ws.Cells[1, 4].Value = "School Year";
                ws.Cells[1, 5].Value = "Home Room";
                ws.Cells[1, 6].Value = "Grade";
                ws.Cells[1, 7].Value = "Created By";
                ws.Cells[1, 8].Value = "Create Date";
                ws.Cells[1, 9].Value = "Last Updated By";
                ws.Cells[1, 10].Value = "Last Update Date";
                ws.Cells[1, 11].Value = "Deleted";

                //Get Data
                for (int i = 0; i < datasource.Count(); i++)
                {
                    ws.Cells[i + 2, 1].Value = datasource.ElementAt(i).student_id;
                    ws.Cells[i + 2, 2].Value = datasource.ElementAt(i).first_name;
                    ws.Cells[i + 2, 3].Value = datasource.ElementAt(i).last_name;
                    ws.Cells[i + 2, 4].Value = datasource.ElementAt(i).school_year_id;
                    ws.Cells[i + 2, 5].Value = datasource.ElementAt(i).homeroom_id;
                    ws.Cells[i + 2, 6].Value = datasource.ElementAt(i).grade_id;
                    ws.Cells[i + 2, 7].Value = datasource.ElementAt(i).create_contact_id;
                    ws.Cells[i + 2, 8].Value = datasource.ElementAt(i).create_dt;
                    ws.Cells[i + 2, 9].Value = datasource.ElementAt(i).last_update_contact_id;
                    ws.Cells[i + 2, 10].Value = datasource.ElementAt(i).last_update_dt;
                    ws.Cells[i + 2, 11].Value = datasource.ElementAt(i).is_deleted;

                }

                //Set Header style
                using (ExcelRange rng = ws.Cells[1,1,1,11])
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