using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PortfolioBizObjects;
using cpuframework;
using System.Data;
namespace Portfolio.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            List<bizDevSection> lst = AppUtility.DevSectionList();
            return View(lst);
        }
        public ActionResult DevSection(string DevSectionCode)
        {
            bizDevSection d = new bizDevSection();
            d.LoadByFieldName("vchDevSectionCode", DevSectionCode);
            return View(d);
        }

        public ActionResult DevSubSection(string id)
        {
            bizDevSubSection d = new bizDevSubSection();
            d.LoadByFieldName("vchDevSubSectionCode", id);
            return PartialView(d.DevSectionCode ,d);
        }
        public ActionResult RunSQL(string db, string sqlstatement)
        {
            try
            {
                DataTable dt = SQLUtility.GetDataTable(sqlstatement, db);
                return PartialView("QueryResults", dt);
            }
            catch (Exception ex)
            {
                return Content("<h1 class= 'text-danger'>" + ex.Message + "</h1>");
            }

        }
    }
}