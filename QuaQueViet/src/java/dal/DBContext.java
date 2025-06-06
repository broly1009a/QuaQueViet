package dal;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber
                + ";databaseName=" + dbName
                + ";encrypt=true;trustServerCertificate=true;";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection conn = DriverManager.getConnection(url, userID, password);
    System.out.println("Kết nối thành công tới database!");
    return conn;
    }

    private final String serverName = "mssql-198006-0.cloudclusters.net";
    private final String dbName = "ShopYouAndMeVersionFinal2";
    private final String portNumber = "10008";
    private final String instance = ""; // để trống
    private final String userID = "hiepdevs";
    private final String password = "Taovipko0@";
}

class Using {

    public static void main(String[] args) {
        try {
            new DBContext().getConnection();
            System.out.println("Ket noi thanh cong");
        } catch (Exception e) {
            System.out.println("Ket noi that bai" + e.getMessage());
        }
    }
}
