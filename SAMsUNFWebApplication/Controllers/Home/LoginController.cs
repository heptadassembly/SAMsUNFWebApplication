using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SAMsUNFWebApplication.Models;
using MySql.Data.MySqlClient;
using System.Configuration;
using SAMsUNFWebApplication.Models.DataAccess;
using System.Web.Security;

namespace SAMsUNFWebApplication.Controllers
{
    [AllowAnonymous]
    public class LoginController : Controller
    {
        [HttpGet]
        public ActionResult Login()
        {
            ViewBag.Title = "Login";
            ViewBag.ChangePassword = false;
            return View();
        }

        [HttpPost]
        public async System.Threading.Tasks.Task<ActionResult> Login(ProfileModel model, string actionRequest)
        {
            ViewBag.Title = "Logon";
            ViewBag.ChangePassword = false;

            if (actionRequest != null)
            {
                if (actionRequest == "Login")
                {
                    if (model.user_name == null || model.user_name.Length == 0 || model.password == null || model.password.Length == 0)
                    {
                        FormsAuthentication.SignOut();
                        Session["ProfileContactId"] = null;
                        Session["ProfileUserId"] = model.user_name;
                        ModelState.AddModelError(string.Empty, "UserId and Password are required.");
                    }
                    else
                    {
                        using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
                        {
                            await connection.OpenAsync();

                            model = await new UserRepository(connection).LoginValidation(model.user_name, model.password);


                        }
                        if (model == null)
                        {
                            FormsAuthentication.SignOut();
                            ModelState.AddModelError(string.Empty, "UserId or Password is invalid,please retry.");
                        }

                        else if (model != null && String.IsNullOrEmpty(model.secretanswer))
                        {
                            ModelState.AddModelError(string.Empty, "You must change your password and answer a security question.");
                            ViewBag.Title = "Change Password";
                            ViewBag.ChangePassword = true;
                        }
                        else
                        {
                            Session["ProfileContactId"] = model.contact_id.ToString();
                            Session["ProfileUser"] = model;
                            FormsAuthentication.SetAuthCookie(model.user_name, false);
                            Session["ProfileUserId"] = model.user_name;
                            return RedirectToAction("Dashboard", "Dashboard");
                        }
                    }
                }

                else if (actionRequest == "Cancel")
                {
                }
                else if (actionRequest == "Save")
                {
                    if (ValidateNewLoginAuthenication(model))
                    {
                        using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
                        {
                            await connection.OpenAsync();

                            bool success = await new UserRepository(connection).LoginUpdate(model.user_name, model.password, model.newsecretanswer);

                        }
                        FormsAuthentication.SignOut();
                        ModelState.AddModelError(string.Empty, "Your password has been saved, Please Log in.");
                        model = null;
                    }
                }
                else if (actionRequest == "Change Password")
                {
                    ViewBag.Title = "Change Password";
                    ViewBag.ChangePassword = true;

                }
            }
            return View(model);
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session["ProfileContactId"] = null;
            Session["ProfileUserId"] = null;
            Session["ProfileUser"] = null;


            return RedirectToAction("Index", "Home");
        }

        private bool ValidateNewLoginAuthenication(ProfileModel model)
        {
            bool successful = true;
            string errorMessage = null;
            if (string.IsNullOrEmpty(model.user_name)) { errorMessage += " Must enter a userid."; }

            if (string.IsNullOrEmpty(model.password) || string.IsNullOrEmpty(model.reenterpassword)) { errorMessage += " Must enter and re-enter Password."; }
            else if (string.Compare(model.password, model.reenterpassword, false) != 0) { errorMessage += " Password mismatch."; }

            if (string.IsNullOrEmpty(model.newsecretanswer))
            {
                errorMessage += " Must enter a Secret answer.";
            }
            else
            {
                ProfileModel currentmodel = null;
                using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
                { 

                    currentmodel = new UserRepository(connection).LoginGetbyUserId(model.user_name);
                }
                if(currentmodel != null)
                {
                    model.secretanswer = currentmodel.secretanswer;
                }

                if (!string.IsNullOrEmpty(model.secretanswer) && string.Compare(model.secretanswer, model.newsecretanswer, false) != 0)
                { errorMessage += " Secret Answer Mismatch."; }
            }

            if (errorMessage != null)
            {
                ViewBag.Title = "Change Password";
                ViewBag.ChangePassword = true;
                ModelState.AddModelError(string.Empty, errorMessage);
                successful = false;
            }
            return successful;
        }
    }
}