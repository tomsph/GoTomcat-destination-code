<%@ page import="java.sql.*" %>
<%!
public String connectDbandRetrieveData(){
  // Read RDS connection information from the environment
  String dbName = "tomsphere-1";
  String userName = "admin";
  String password = "PASSWORD1";
  String hostname = "tomsphere-1.cqo8jqnhzdyn.us-east-2.rds.amazonaws.com";
  String port = "1521";
  String jdbcUrl = "jdbc:oracle:thin:"+userName+"/"+password+"@//" + hostname + ":" +
    port + "/" + "orcl";
  
  // Load the JDBC driver
  try {
    System.out.println("Loading driver...");
    Class.forName("oracle.jdbc.OracleDriver");
    System.out.println("Driver loaded!");
  } catch (ClassNotFoundException e) {
    throw new RuntimeException("Cannot find the driver in the classpath!", e);
  }

  Connection conn = null;
  String appServer = "Initial Value";

  Statement stmt = null;
    String query = "select * from server_info";
    try {
        conn = DriverManager.getConnection(jdbcUrl);
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