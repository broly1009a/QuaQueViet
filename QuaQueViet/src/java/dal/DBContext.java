package dal;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://fpt-sql-server.database.windows.net:1433;database=ShopYouAndMeVersionFinal2;user=hiepdevs@fpt-sql-server;password=Taovipko0@;encrypt=true;trustServerCertificate=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url);
    }
}

class Using {
    public static void main(String[] args) {
        try {
            new DBContext().getConnection();
            System.out.println("Kết nối thành công");
        } catch (Exception e) {
            System.out.println("Kết nối thất bại: " + e.getMessage());
        }
    }
}