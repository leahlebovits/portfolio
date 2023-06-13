update DevSubSection
set vchProgrammingCode = '
    public static class SQLUtility
    {
        static string connserver = "";
        static string conndb = "";
        static string connuser = "";
        static string connpassword = "";

    public static string GetConnectionString(string ServerName, string DatabaseName, string UserName, string Password)
    {
        string val = "";
        val = "Server = " + ServerName + ";Database = " + DatabaseName + " ;";
        if (UserName == "")
        {
            val = val + "Trusted_Connection=true;";
        }
        else
        {
            val = val + "User ID =" + UserName + ";Password=" + Password + ";";
        }
        return val;
    }
    public static void SetConnectionByConnectionString(string value)
    {
        SqlConnection c = new SqlConnection(value);
        connserver = c.DataSource;
        conndb = c.Database;
        if(value.ToLower().Contains("Trusted_Connection".ToLower()) == false)
        {
            connuser = GetValueFromKeyString(value, ";", "=", "User ID");
            connpassword = GetValueFromKeyString(value, ";", "=", "Password");
        }
        SetConnection(connserver, conndb, connuser, connpassword, true);
    }

    private static string GetValueFromKeyString(string KeyString, string SetSeparator, string KeyValueSeperator, string Key)
    {
        string s = "";

        List<string> lst = KeyString.Split(SetSeparator[0]).ToList();

        if (lst.Exists(x => x.ToLower().StartsWith(Key.ToLower())))
        {
            KeyString = lst.First(x => x.ToLower().StartsWith(Key.ToLower()) == true);
            lst = KeyString.Split(KeyValueSeperator[0]).ToList();

            if (lst.Count > 1)
            {
                s = lst[1];
            }
        }

        return s;

    }
    public static void SetConnection(string ServerName, string DatabaseName, string UserName, string Password, bool TryConnection = false)
    {
        connserver = ServerName;
        connuser = UserName;
        connpassword = Password;
        if (TryConnection == true)
        {
            SqlConnection conn = GetConnection();
            conn.Open();
        }
    }
    public static void SetConnection(string DatabaseName)
    {
        conndb = DatabaseName;
    }
    private static SqlConnection GetConnection()
    {
        SqlConnection conn = new SqlConnection();

        conn.ConnectionString = GetConnectionString(connserver, conndb, connuser, connpassword);
        return conn;
    }
    private static SqlConnection GetConnection(string DatabaseNameValue)
    {
        SqlConnection conn = new SqlConnection();

        conn.ConnectionString = GetConnectionString(connserver, DatabaseNameValue, connuser, connpassword);
        return conn;
    }

    public static void ExecuteAdapter(SqlDataAdapter AdapterObj, DataTable TableObj)
        
    {
        bool rowsupdated = TableObj.Select("", "", DataViewRowState.ModifiedCurrent).Count() > 0;
        bool rowsinserted = TableObj.Select("", "", DataViewRowState.Added).Count() > 0;
        bool rowsdeleted = TableObj.Select("", "", DataViewRowState.Deleted).Count() > 0;
        using (SqlConnection conn = GetConnection())
        {
            conn.Open();

            if (AdapterObj.UpdateCommand != null) 
            { 
              AdapterObj.UpdateCommand.Connection = conn;
              AdapterObj.InsertCommand.Connection = conn;
            }

            if (AdapterObj.DeleteCommand != null)
            {
                AdapterObj.DeleteCommand.Connection = conn;
            }

            try
            {
                AdapterObj.Update(TableObj);
                if(rowsdeleted == true && AdapterObj.DeleteCommand!= null)
                {
                    CheckSprocReturnValue(AdapterObj.DeleteCommand);
                }
                if (rowsupdated == true && AdapterObj.UpdateCommand != null)
                {
                    CheckSprocReturnValue(AdapterObj.UpdateCommand);
                }
                if (rowsinserted == true && AdapterObj.InsertCommand != null)
                {
                    CheckSprocReturnValue(AdapterObj.InsertCommand);
                }
            }

            catch(Exception ex)
            {
                ParseAndThrowException(ex);
            }
            finally
            {
                if (rowsdeleted == true)
                {
                    Debug.Print(GetSQL(AdapterObj.DeleteCommand));
                }
                if (rowsupdated == true)
                {
                    Debug.Print(GetSQL(AdapterObj.UpdateCommand));
                }
                if (rowsinserted == true)
                {
                    Debug.Print(GetSQL(AdapterObj.InsertCommand));
                }
            }
                      
        }
    }
    private static void ParseAndThrowException(Exception ex)
    {
        string constraintmsg = ExtractConstraintMessage(ex.Message, "ck_");

        if (constraintmsg == "")
        {
            constraintmsg = ExtractConstraintMessage(ex.Message, "f_");
        }
        if (constraintmsg == "")
        {
            constraintmsg = ExtractConstraintMessage(ex.Message, "u_");
        }
        if (constraintmsg == "")
        {
            constraintmsg = ExtractConstraintMessage(ex.Message, "c_");
        }
        if (constraintmsg != "")
        {
            throw new CPUException(constraintmsg);
        }
        else
        {
            throw ex;
        }
    }
    private static string ExtractConstraintMessage(string ExceptionMessage, string ConstraintPrefix)
    {
        string msg = "";
        int startpos = ExceptionMessage.IndexOf(ConstraintPrefix);
        if (startpos > -1)
        {
            startpos = startpos + ConstraintPrefix.Length;
        }

        int endpos = -1;

        if (startpos > -1)
        {
            endpos = ExceptionMessage.IndexOf("\"", startpos);
            if(endpos == -1)
            {
                endpos = ExceptionMessage.IndexOf("''", startpos);
            }
        }

        if (endpos > startpos)
        {
            msg = ExceptionMessage.Substring(startpos, endpos - startpos);
            msg = msg.Replace("_", "  because it has related records to ");
            msg = msg.Insert(0, "Cannot delete ");
        }
        return msg;
    }
    private static void CheckSprocReturnValue(SqlCommand commandobj)
    {
        int returnval = 0;
        string msg = "";
        foreach (SqlParameter p in commandobj.Parameters)
        {
            if(p.Direction == ParameterDirection.ReturnValue && p.Value != null)
            {
               returnval = (int)p.Value; 
            }
            if (p.ParameterName.ToLower() == "@vchmessage" && p.Value !=null)
            {
                msg = p.Value.ToString();
            }
        }
        if (returnval == 1 & msg != "")
        {
            throw new CPUException(msg);
        }
    }
    private static void SetupCommandParameterSources(SqlCommand CommandObj)
    {
        foreach (SqlParameter p in CommandObj.Parameters)
        {
            if (p.ParameterName != "@ReturnValue")

            {
                p.SourceColumn = p.ParameterName.Replace("@", "");
            }
        }
       
    }
    public static DataTable GetDataTable (SqlCommand CommandObj)
    {
        SqlDataAdapter a = new SqlDataAdapter();
        a.SelectCommand = CommandObj;
        return GetDataTable(a);
    }
    public static DataTable GetDataTable(SqlDataAdapter adapter, SqlConnection connobj = null)
    {
        DataTable dt = null;
        SqlCommand cmd = adapter.SelectCommand;
        if(connobj == null)
        {
            cmd.Connection = GetConnection();

        }
        else
        {
            cmd.Connection = connobj;
        }
        Debug.Print(GetSQL(cmd));

        using (SqlConnection conn = cmd.Connection)
        {
            try
            {
                cmd.Connection = conn;
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                CheckSprocReturnValue(cmd);
                dt = new DataTable();
                dt.Load(dr);
                SetTableAllowNulls(dt);
               
            }
            catch (Exception ex)
            {
                ParseAndThrowException(ex);
            }
            return dt;
        }

    }
    public static DataTable GetDataTable(string SqlStatement, string DatabaseNameValue = "")
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.Text;
        cmd.CommandText = SqlStatement;
        SqlDataAdapter a = new SqlDataAdapter();
        a.SelectCommand = cmd;
        SqlConnection conn = GetConnection(DatabaseNameValue);
        return GetDataTable(a, conn);
    }

    public static void ExecNonQuery(string SqlStatement)
    {
        Debug.Print(SqlStatement);
        using (SqlConnection conn = GetConnection())
        {
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.CommandText = SqlStatement;
            conn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    public static SqlDataAdapter GetSQLAdapter(string TableName, bool HasGet = true, bool HasUpdate = true, bool HasDelete = true)
    {
        SqlDataAdapter adapter = new SqlDataAdapter();
        if (HasGet == true) 
        { adapter.SelectCommand = SetupCommand(TableName, "Get"); }

        if (HasUpdate == true)
        { adapter.UpdateCommand = SetupCommand(TableName, "Update");
            adapter.InsertCommand = adapter.UpdateCommand;
        }

        if (HasDelete == true)
        { adapter.DeleteCommand = SetupCommand(TableName, "Delete"); }

        return adapter;
    }
    public static SqlCommand GetCommand (string SprocName)
    {
        SqlCommand cmd = new SqlCommand(SprocName);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Connection = GetConnection();

        using (cmd.Connection)
        {
            cmd.Connection.Open();
            SqlCommandBuilder.DeriveParameters(cmd);
            cmd.Connection.Close();
        }

        return cmd;
    }
    private static SqlCommand SetupCommand(string TableName, string Verb)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = TableName + Verb;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Connection = GetConnection();

        using (cmd.Connection)
        {
            cmd.Connection.Open();
            SqlCommandBuilder.DeriveParameters(cmd);
            cmd.Connection.Close();
        }

        SetupCommandParameterSources(cmd);

        return cmd;
    }
    private static void SetTableAllowNulls(DataTable TableObj)
    {
        
            foreach (DataColumn c in TableObj.Columns)
        {
            c.AllowDBNull = true;
            c.ReadOnly = false;
        }
              
        
    }
    public static string GetSQL(System.Data.SqlClient.SqlCommand cmd)
    {
        string sql = "";
        if (cmd != null)
        {
            if (cmd.Connection != null)
            {
                sql = System.Environment.NewLine + "--" + cmd.Connection.DataSource + System.Environment.NewLine + "use " + cmd.Connection.Database + Environment.NewLine + "go" + Environment.NewLine;
            }
            if (cmd.CommandType == CommandType.Text)
            { 
                sql = sql + cmd.CommandText;
            }
            else
            {
                sql = sql + "declare @iReturn int";
                foreach (System.Data.SqlClient.SqlParameter prm in cmd.Parameters)
                {
                    if (prm.Direction == ParameterDirection.Output | prm.Direction == ParameterDirection.InputOutput)
                    {
                        sql = sql + ", " + prm.ParameterName + " " + prm.SqlDbType.ToString();
                        switch (prm.SqlDbType)
                        {
                            case SqlDbType.VarChar:
                            case SqlDbType.Char:
                                sql = sql + "(" + prm.Size.ToString() + ")";
                                break;
                            case SqlDbType.Decimal:
                                sql = sql + "(" + prm.Precision.ToString() + "," + prm.Scale.ToString() + ")";
                                break;
                        }
                        sql = sql + " = " + GetSQLParamValue(prm);
                    }
                }

                sql = sql + Environment.NewLine;

                sql = sql + System.Environment.NewLine + "exec @iReturn = " + cmd.CommandText;
                foreach (System.Data.SqlClient.SqlParameter prm in cmd.Parameters)
                {
                    switch (prm.Direction)
                    {
                        case ParameterDirection.Input:
                            string sValue = GetSQLParamValue(prm);
                            sql = sql + System.Environment.NewLine + prm.ParameterName + " = " + sValue + ",";
                            break;
                        case ParameterDirection.InputOutput:
                        case ParameterDirection.Output:
                            sql = sql + System.Environment.NewLine + prm.ParameterName + " = " + prm.ParameterName + " output,";
                            break;

                    }
                }

                if (sql.EndsWith(","))
                {
                    sql = sql.Substring(0, sql.Length - 1);
                }
                sql = sql + Environment.NewLine + "select @iReturn";

                foreach (System.Data.SqlClient.SqlParameter prm in cmd.Parameters)
                {
                    if (prm.Direction == ParameterDirection.Output | prm.Direction == ParameterDirection.InputOutput)
                    {
                        sql = sql + ", " + prm.ParameterName;
                    }
                }
            }
        }
        return sql;
    }
    private static string GetSQLParamValue(SqlParameter ParamObj)
    {
        string val = "";

        if (ParamObj.Direction != ParameterDirection.ReturnValue)
        {
            val = "null";
            string sQuote = "";
            if (ParamObj.Value != null && ParamObj.Value != DBNull.Value) { val = ParamObj.Value.ToString(); }
            if (val != "null")
            {
                switch (ParamObj.DbType) { case System.Data.DbType.String: case System.Data.DbType.AnsiString: case System.Data.DbType.AnsiStringFixedLength: case System.Data.DbType.DateTime: sQuote = "''"; break; }
            }
            val = sQuote + val + sQuote;
        }

        return val;
    }
    }
'
where vchDevSubSectionCode = 'sqlutility'