package mx.uv.datos;

import mx.uv.modelo.Usuario;
import java.sql.*;

public class UsuarioDAO {


    // Inserta un usuario nuevo en la BD
    public boolean registrar(Usuario u) {
        String sql = "INSERT INTO usuario (nombre, correo_uv, contrasena, rol) " +
                "VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getCorreoUv());
            ps.setString(3, u.getContrasena()); // por ahora manjeamos solo  texto plano
            ps.setString(4, u.getRol());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            Conexion.close(ps);
            Conexion.close(conn);
        }
    }


    // para el login Busca un usuario por correo y contraseña
    // Si existe lo regresa, si no regresa null
    public Usuario login(String correo, String contrasena) {
        String sql = "SELECT * FROM usuario WHERE correo_uv = ? AND contrasena = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, contrasena);
            rs = ps.executeQuery();
            if (rs.next()) {
                // Si encontró al usuario lo muetsra
                return new Usuario(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("correo_uv"),
                        rs.getString("contrasena"),
                        rs.getString("rol"),
                        rs.getBoolean("activo")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Conexion.close(rs);
            Conexion.close(ps);
            Conexion.close(conn);
        }
        return null; // si no encontro retorna null
    }
}