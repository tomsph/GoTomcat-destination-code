<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%!
public String connectDbandRetrieveData(){
  // Read RDS connection information from the environment
  DataSource ds = null;  
  Connection conn = null;
  String appServer = "Initial Value";
  Statement stmt = null;

  String query = "select * from server_info";
    try {
      Context context = new InitialContext();
      Context envCtx = (Context) context.lookup("java:comp/env");
      ds =  (DataSource)envCtx.lookup("jdbc/address");
      conn = ds.getConnection();
      stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery(query);
      while (rs.next()) {
           appServer = rs.getString("app_server");
        }
    } catch (Exception ex ) {
      System.out.println("SQLException: " + ex.getMessage());
    } finally {
        //if (stmt != null) { stmt.close(); }
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        return appServer;
    }
}
%>
<% out.println(connectDbandRetrieveData()); %>