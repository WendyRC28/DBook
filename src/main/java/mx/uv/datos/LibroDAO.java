package mx.uv.datos;

import mx.uv.modelo.Libro;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LibroDAO {

    public List<Libro> listar() {
        List<Libro> lista = new ArrayList<>();
        String sql =
                "SELECT l.id, l.titulo, l.autor, l.carrera, l.estado, l.precio, l.id_usuario, " +
                        "       u.nombre AS nombre_usuario, " +
                        "       COALESCE(AVG(c.puntuacion), 0) AS promedio, " +
                        "       COUNT(c.id) AS total " +
                        "FROM libro l " +
                        "JOIN usuario u ON l.id_usuario = u.id " +
                        "LEFT JOIN calificacion c ON c.id_libro = l.id " +
                        "GROUP BY l.id, u.id " +
                        "ORDER BY l.fecha_publicacion DESC";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Libro l = new Libro();
                l.setId(rs.getInt("id"));
                l.setTitulo(rs.getString("titulo"));
                l.setAutor(rs.getString("autor"));
                l.setCarrera(rs.getString("carrera"));
                l.setEstado(rs.getString("estado"));
                l.setPrecio(rs.getDouble("precio"));
                l.setIdUsuario(rs.getInt("id_usuario"));
                l.setNombreUsuario(rs.getString("nombre_usuario"));
                l.setCalificacionPromedio(rs.getDouble("promedio"));
                l.setTotalCalificaciones(rs.getInt("total"));
                lista.add(l);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { Conexion.close(rs); Conexion.close(ps); Conexion.close(conn); }
        return lista;
    }

    public boolean publicar(Libro l) {
        String sql = "INSERT INTO libro (titulo, autor, carrera, estado, precio, id_usuario) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, l.getTitulo());
            ps.setString(2, l.getAutor());
            ps.setString(3, l.getCarrera());
            ps.setString(4, l.getEstado());
            if ("venta".equals(l.getEstado()) && l.getPrecio() > 0) {
                ps.setDouble(5, l.getPrecio());
            } else {
                ps.setNull(5, java.sql.Types.NUMERIC);
            }
            ps.setInt(6, l.getIdUsuario());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) { e.printStackTrace(); return false; }
        finally { Conexion.close(ps); Conexion.close(conn); }
    }

    public Libro buscarPorId(int id) {
        String sql = "SELECT id, titulo, autor, carrera, estado, precio, id_usuario FROM libro WHERE id = ?";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Libro l = new Libro();
                l.setId(rs.getInt("id"));
                l.setTitulo(rs.getString("titulo"));
                l.setAutor(rs.getString("autor"));
                l.setCarrera(rs.getString("carrera"));
                l.setEstado(rs.getString("estado"));
                l.setPrecio(rs.getDouble("precio"));
                l.setIdUsuario(rs.getInt("id_usuario"));
                return l;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { Conexion.close(rs); Conexion.close(ps); Conexion.close(conn); }
        return null;
    }
}