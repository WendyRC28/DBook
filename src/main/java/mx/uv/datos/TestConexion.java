package mx.uv.datos;

import java.sql.Connection;

public class TestConexion {
    public static void main(String[] args) {
        try {
            Connection conn = Conexion.getConnection();
            if (conn != null) {
                System.out.println("Conexión exitosa");
                conn.close();
            }
        } catch (Exception e) {
            System.out.println(" Error al conectar: " + e.getMessage());
        }
    }
}