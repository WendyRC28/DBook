package mx.uv.datos;

import org.apache.commons.dbcp2.BasicDataSource;
import javax.sql.DataSource;
import java.sql.*;

public class Conexion {

    private static final String URL    = "jdbc:postgresql://localhost:5432/Biblioteca_DBook";
    private static final String USUARIO = "postgres";
    private static final String CLAVE   = "1234";

    private static BasicDataSource ds;

    //duda ia?
    // Pool de conexiones: en lugar de abrir y cerrar la BD cada vez,
    // mantiene varias conexiones listas para usar (más eficiente)
    public static DataSource getDataSource() {
        if (ds == null) {
            ds = new BasicDataSource();
            ds.setUrl(URL);
            ds.setUsername(USUARIO);
            ds.setPassword(CLAVE);
            ds.setInitialSize(5);
            ds.setDriverClassName("org.postgresql.Driver");
        }
        return ds;
    }

    public static Connection getConnection() throws SQLException {
        return getDataSource().getConnection();
    }

    // Métodos
    public static void close(ResultSet rs) {
        try { if (rs != null) rs.close(); }
        catch (SQLException e) { e.printStackTrace(); }
    }

    public static void close(PreparedStatement ps) {
        try { if (ps != null) ps.close(); }
        catch (SQLException e) { e.printStackTrace(); }
    }

    public static void close(Connection conn) {
        try { if (conn != null) conn.close(); }
        catch (SQLException e) { e.printStackTrace(); }
    }
}