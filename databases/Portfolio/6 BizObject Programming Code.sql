update DevSubSection
set vchProgrammingCode = '
 public class bizObject
    {
        DataTable _tbl;
        SqlDataAdapter _adapter;
        public bizObject(string TableNameValue, bool HasGet = true, bool HasUpdate = true, bool HasDelete = true)
        {
            TableName = TableNameValue;
            _adapter = SQLUtility.GetSQLAdapter(TableNameValue, HasGet, HasUpdate, HasDelete);
        }
        public SqlDataAdapter AdapterObject
        {
            get { return _adapter; }
        }
        public string TableName
        {
            get;
            private set;
        }
        public int PrimaryKeyValue
        {
            get
            {
                int val = this.GetFieldValueAsInt(this.PrimaryKeyFieldName);
 
              
                return val;
            }
            set
            {
                this.SetFieldValueAsInt(this.PrimaryKeyFieldName, value);
            }
        }
        public string PrimaryKeyFieldName
        {
            get { return "i" + this.TableName + "Id"; }
        }
        public DataTable TableObject
        {
            get { return _tbl; }
            protected set
            {
                _tbl = value;
            }
        }
        public DataTable Load(int IdValue)
        {
            _adapter.SelectCommand.Parameters["@" + this.PrimaryKeyFieldName].Value = IdValue;

            _tbl = SQLUtility.GetDataTable(_adapter);

            return _tbl;
        }
        public DataTable LoadByFieldName(string FieldName, int IdValue)
        {
            if (_adapter.SelectCommand.Parameters.Contains("@" + FieldName) == false)
            {
                throw new Exception("Parameter" + FieldName + "does not existfor sproc" + _adapter.SelectCommand.CommandText);
            }
        
            _adapter.SelectCommand.Parameters["@" + FieldName].Value = IdValue;

            _tbl = SQLUtility.GetDataTable(_adapter);

            return _tbl;
        }
        public DataTable LoadByFieldName(string FieldName, string StringValue)
        {
            if (_adapter.SelectCommand.Parameters.Contains("@" + FieldName) == false)
            {
                throw new Exception("Parameter" + FieldName + "does not existfor sproc" + _adapter.SelectCommand.CommandText);
            }

            _adapter.SelectCommand.Parameters["@" + FieldName].Value = StringValue;

            _tbl = SQLUtility.GetDataTable(_adapter);

            return _tbl;
        }
        public DataTable LoadList(bool IncludeBlank)
        {
            _adapter.SelectCommand.Parameters["@bAll"].Value = 1;
            _adapter.SelectCommand.Parameters["@bIncludeBlank"].Value = IncludeBlank; 
            DataTable t = SQLUtility.GetDataTable(_adapter);
            return t;
        }
        public DataTable LoadForeignKeyList(int IdValue, string TableNameValue)
        {
            _adapter.SelectCommand.Parameters["@i" + TableNameValue + "Id"].Value = IdValue;
            DataTable dt = SQLUtility.GetDataTable(_adapter);
            return dt;
        }
        public void CreateNew()
        {
            this.Load(0);
            foreach (DataColumn col in _tbl.Columns)
            {
                if (col.DataType == typeof(bool))
                {
                    col.DefaultValue = false;
                }
                else if (col.DataType == typeof(int) || col.DataType == typeof (Int16))
                {
                    col.AutoIncrement = false;
                    col.DefaultValue = 0;
                }
            }
            _tbl.Rows.Add();
        }
        public void Save()
        {
            SQLUtility.ExecuteAdapter(_adapter, _tbl);
        }
        public void Delete()
        {
            _tbl.Rows[0].Delete();
            SQLUtility.ExecuteAdapter(_adapter, _tbl);
        }
        protected int GetFieldValueAsInt(string FieldName)
        {
            int val = 0;

            if (IsFieldValidToRead(FieldName))
            {
                val = (int)this.TableObject.Rows[0][FieldName];
            }

            return val; ;
        }
        protected string GetFieldValueAsString(string FieldName)
        {
            string val = "";

            if (IsFieldValidToRead(FieldName))
            {
                val = (string)this.TableObject.Rows[0][FieldName];
            }

            return val;
        }
        protected bool GetFieldValueAsBool (string FieldName)
        {
            bool val = false;

            if (IsFieldValidToRead(FieldName) == true)
            {
                val = (bool)this.TableObject.Rows[0][FieldName];
            }

            return val;
        }
        protected decimal GetFieldValueAsDecimal(string FieldName)
        {
            decimal val = 0;

            if (IsFieldValidToRead(FieldName) == true)
            {
                val = (decimal)this.TableObject.Rows[0][FieldName];
            }

            return val;
        }
        protected DateTime? GetFieldValueAsDate(string FieldName)
      {
          DateTime? val = null;
      
          if (IsFieldValidToRead(FieldName) == true)
          {
              val = (DateTime?)this.TableObject.Rows[0][FieldName];
          }
      
          return val;
      }
        protected void SetFieldValueAsString(string FieldName, string value)
        {
            this.EnsureTableAndRowExist(FieldName);
            this.TableObject.Rows[0][FieldName] = value;
        }
        protected void SetFieldValueAsInt(string FieldName, int value)
        {
            this.EnsureTableAndRowExist(FieldName);
            this.TableObject.Rows[0][FieldName] = value;
        }
        protected void SetFieldValueAsBool(string FieldName, bool value)
        {
            this.EnsureTableAndRowExist(FieldName);
            this.TableObject.Rows[0][FieldName] = value;
        }
        protected void SetFieldValueAsDecimal(string FieldName, decimal value)
        {
            this.EnsureTableAndRowExist(FieldName);
            this.TableObject.Rows[0][FieldName] = value;
        }
        protected void SetFieldValueAsDate(string FieldName,  DateTime? value)
        {
            this.EnsureTableAndRowExist(FieldName);
            this.TableObject.Rows[0][FieldName] = value;
        }
        private void EnsureTableAndRowExist(string FieldName)
        {
            
            if (this.TableObject == null)
            {
                this.Load(0);
            }
            this.CheckFieldExists(FieldName);
            if (this.TableObject.Rows.Count == 0)
            {
                this.CreateNew();
            }
        }
        private bool IsFieldValidToRead(string FieldName)
        {
            bool b = false;
            if (this.TableObject != null && this.TableObject.Rows.Count > 0)
            {
                CheckFieldExists(FieldName);
                if (this.TableObject.Rows[0].IsNull(FieldName) == false)
                {
                    b = true;
                }
               
            }
            return b;
        }
        private void CheckFieldExists(string FieldName)
        {
            if (this.TableObject.Columns.Contains(FieldName) == false)
            {
                string msg = this.TableName;

                if (_adapter.SelectCommand != null) 
                { msg = _adapter.SelectCommand.CommandText; }

                msg = msg + " does not contain" + FieldName;

                throw new Exception(msg);
            }
        }
    }
'
where vchDevSubSectionCode = 'bizObject'