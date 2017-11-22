<%@ page language="java" import="java.sql.*,com.microsoft.sqlserver.jdbc.*" %>

<HTML>
<HEAD> <TITLE> The JDBCQuery JSP  </TITLE> </HEAD>
<BODY BGCOLOR="white">

<% String searchCondition = request.getParameter("cond"); 
   if (searchCondition != null) { %>
      <H3> Search results for  <I> <%= searchCondition %> </I> </H3>
      <B> <%= runQuery(searchCondition) %> </B> <HR><BR>
<% }  %>
<B>Enter a search condition:</B>
<FORM METHOD="get"> 
<INPUT TYPE="text" NAME="cond" SIZE=30>
<INPUT TYPE="submit" VALUE="Ask Oracle">;
</FORM>
</BODY>
</HTML>

<%-- Declare and define the runQuery() method. --%>
<%! private String runQuery(String cond) throws SQLException {
     Connection conn = null; 
     Statement stmt = null; 
     ResultSet rset = null; 
     try {
        
		// Ensure the SQL Server driver class is available.
		    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		
        	

		String connectionString = "jdbc:sqlserver://madan-db-01.database.windows.net:1433" + ";" +
		"database=madandb-sql-free01" + ";" + "user=madandb@madan-db-01" + ";" +
		"password=srinivas@77" + ";" +
		"trustServerCertificate=false" + ";" +
		"encrypt=true" + ";" + 
		"hostNameInCertificate=*.database.windows.net" + ";" +
		"loginTimeout=30";

		
			conn = DriverManager.getConnection(connectionString);
        stmt = conn.createStatement();
        // dynamic query
       /* rset = stmt.executeQuery ("SELECT ename, sal FROM scott.emp "+ 
                           (cond.equals("") ? "" : "WHERE " + cond ));
	*/

	rset = stmt.executeQuery ("SELECT ename, sal FROM emp "+ 
                           (cond.equals("") ? "" : "WHERE " + cond ));
	
	
		
       return (formatResult(rset));
     } catch (SQLException e) { 
         return ("<P> SQL error: <PRE> " + e + " </PRE> </P>\n");
     } 
     catch(Exception e)
     {
    	 return ("<P> Exception error: <PRE> " + e + " </PRE> </P>\n");
     }
     finally {
         if (rset!= null) rset.close(); 
         if (stmt!= null) stmt.close();
         if (conn!= null) conn.close();
     }
  }
  private String formatResult(ResultSet rset) throws SQLException {
    StringBuffer sb = new StringBuffer();
    if (!rset.next())
      sb.append("<P> No matching rows.<P>\n");
    else {  sb.append("<UL>"); 
            do {  sb.append("<LI>" + rset.getString(1) + 
                            " earns $ " + rset.getInt(2) + ".</LI>\n");
            } while (rset.next());
           sb.append("</UL>"); 
    }
    return sb.toString();
  }
%>
