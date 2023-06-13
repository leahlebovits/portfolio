using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using cpuframework;
using System.Data;

namespace PortfolioBizObjects
{
    public class bizDevSection : bizObject
    {
        public enum FieldEnum { iDevSectionId, vchDevSectionCode, vchDevSectionDesc, vchDevSectionMiniBlurb, vchDevSectionBlurb, vchDevTechUsed }
        public bizDevSection() : base("DevSection", true, false, false)
        {

        }
        public string DevSectionId
        {
            get { return this.GetFieldValueAsString(FieldEnum.iDevSectionId.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.iDevSectionId.ToString(), value); }
        }
        public string DevSectionCode
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchDevSectionCode.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchDevSectionCode.ToString(), value); }
        }
        public string DevSectionDesc
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchDevSectionDesc.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchDevSectionDesc.ToString(), value); }
        }
        public string DevSectionMiniBlurb
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchDevSectionMiniBlurb.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchDevSectionMiniBlurb.ToString(), value); }
        }
        public string DevSectionBlurb
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchDevSectionBlurb.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchDevSectionBlurb.ToString(), value); }
        }
        public string DevTechUsed
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchDevTechUsed.ToString()); }
            set { this.SetFieldValueAsString(FieldEnum.vchDevTechUsed.ToString(), value); }
        } 
        public List<bizDevSection> GetListOfAll(bool bIncludeBlank = false)
        {
            List<bizDevSection> lst = new List<bizDevSection>();
            DataTable dt = this.LoadList(bIncludeBlank);
            foreach (DataRow r in dt.Rows)
            {
                DataTable newtable = dt.Clone();
                newtable.ImportRow(r);
                bizDevSection newobj = new bizDevSection();
                newobj.TableObject = newtable;
                lst.Add(newobj);
            }
            return lst;
        }
           

        public List<bizDevSubSection> DevSubSections
        {
            get
            {
                bizDevSubSection s = new bizDevSubSection();
                return s.GetListBySectionId(this.PrimaryKeyValue);
            
             
            }
        }
    }
}
