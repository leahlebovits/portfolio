using PortfolioBizObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portfolio
{
    public static class AppUtility
    {
        private const string sectionlistkey = "key_sectionlist";
        public static List<bizDevSection> DevSectionList()
        {
            List<bizDevSection> lst = null;
            if (HttpContext.Current.Session[sectionlistkey]!= null)
            {
                lst = (List<bizDevSection>)HttpContext.Current.Session[sectionlistkey];
            }
            else
            {
                lst = new List<bizDevSection>();
                bizDevSection d = new bizDevSection();
                lst = d.GetListOfAll(false);

                HttpContext.Current.Session[sectionlistkey] = lst;
            }

            return lst;

        }
        public static string SetSQLCSS(string Sql, bool UseStyles)
        {
            string s = Sql;
            string styles = "<style>.sql {color: blue;}.sqlgrey {color: grey;}.sqlred { color: red;}.sqlpink {color: hotpink; }.sqlgreen {color: green;}</style>";

            if (UseStyles == true) { s = styles + s; }

            s = s.Replace(Environment.NewLine, "<br/> ");
            s = s.Replace("sys.databases", "<span class=\"sqlgreen\">sys.databases</span>");
            s = s.Replace("if ", "<span class=\"sql\">if </span>");
            s = s.Replace("select", "<span class=\"sql\">select</span>");
            s = s.Replace("from", "<span class=\"sql\">from</span>");
            s = s.Replace("where", "<span class=\"sql\">where</span>");
            s = s.Replace("begin", "<span class=\"sql\">begin</span>");
            s = s.Replace("end", "<span class=\"sql\">end</span>");
            s = s.Replace("use ", "<span class=\"sql\">use </span>");
            s = s.Replace(" int", "<span class=\"sql\"> int</span>");
            s = s.Replace("varchar", "<span class=\"sql\">varchar</span>");
            s = s.Replace("create database", "<span class=\"sql\">create database</span>");
            s = s.Replace("create table", "<span class=\"sql\">create table</span>");
            s = s.Replace("primary key", "<span class=\"sql\">primary key</span>");
            s = s.Replace("identity", "<span class=\"sql\">identity</span>");
            s = s.Replace("foreign key references", "<span class=\"sql\">foreign key references</span>");
            s = s.Replace("datetime", "<span class=\"sql\">datetime</span>");
            s = s.Replace("date ", "<span class=\"sql\">date </span>");
            s = s.Replace(" go", "<span class=\"sql\"> go</span>");
            s = s.Replace("constraint", "<span class=\"sql\">constraint</span>");
            s = s.Replace(" unique", "<span class=\"sql\"> unique</span>");
            s = s.Replace("check", "<span class=\"sql\">check</span>");
            s = s.Replace(" as ", "<span class=\"sql\"> as </span>");
            s = s.Replace("bit ", "<span class=\"sql\">bit </span>");
            s = s.Replace("default ", "<span class=\"sql\">default </span>");
            s = s.Replace(" char", "<span class=\"sql\"> char</span>");
            s = s.Replace("decimal", "<span class=\"sql\">decimal</span>");
            s = s.Replace("identifier ", "<span class=\"sql\">identifier </span>");
            s = s.Replace("money ", "<span class=\"sql\">money </span>");
            s = s.Replace("dec", "<span class=\"sql\">dec</span>");
            s = s.Replace(".name", "<span class=\"sql\">.name</span>");
            s = s.Replace("null", " <span class=\"sqlgrey\">null</span>");
            s = s.Replace("not ", "<span class=\"sqlgrey\">not </span>");
            s = s.Replace("exists", "<span class=\"sqlgrey\">exists</span>");
            s = s.Replace("(", "<span class=\"sqlgrey\">(</span>");
            s = s.Replace(")", "<span class=\"sqlgrey\">)</span>");
            s = s.Replace("<>", "<span class=\"sqlgrey\"><></span>");
            s = s.Replace(">=", "<span class=\"sqlgrey\">>=</span>");
            s = s.Replace("<=", "<span class=\"sqlgrey\"><=</span>");
            s = s.Replace(" = ", "<span class=\"sqlgrey\"> = </span>");
            s = s.Replace(" > ", "<span class=\"sqlgrey\"> > </span>");
            s = s.Replace(" < ", "<span class=\"sqlgrey\"> < </span>");
            s = s.Replace(",", "<span class=\"sqlgrey\">,</span>");
            s = s.Replace("+", "<span class=\"sqlgrey\">+</span>");
            s = s.Replace("newid", "<span class=\"sqlpink\">newid</span>");
            s = s.Replace("getdate", "<span class=\"sqlpink\">getdate</span>");
            s = s.Replace("convert", "<span class=\"sqlpink\">convert</span>");
            s = s.Replace("'", "<span class=\"sqlred\">'</span>");

            return s;
        }
        public static string AddStyleToCode(string value)
        {

            value = value.Replace(Environment.NewLine, "<br/>");
            value = value.Replace("  ", " &nbsp;&nbsp; ");

            value = value.Replace(((char)9).ToString(), "&nbsp&nbsp&nbsp&nbsp");
            value = value.Replace("public void", "<hr/> public void");
            value = value.Replace("public string", "<hr/> public void");
            value = value.Replace("public DataTable", "<hr/> public void");

            DoAddStyle(ref value, "public");
            DoAddStyle(ref value, "string");
            DoAddStyle(ref value, "int");
            DoAddStyle(ref value, "get");
            DoAddStyle(ref value, "set");
            DoAddStyle(ref value, "DataTable");
            DoAddStyle(ref value, "string");
            DoAddStyle(ref value, "return");


            value = "<style>.keyword{color:blue} </style>" + value;
            return value;
        }

        private static void DoAddStyle(ref string wholevalue, string targetvalue, string cssclass = "keyword", bool withspacebeforeafter = true)
        {

            if (withspacebeforeafter == true)
            {
                targetvalue = " " + targetvalue + " ";
            }
            wholevalue = wholevalue.Replace(targetvalue, "<span class='" + cssclass + "'>" + targetvalue + "</span>");

        }
    }
}