package mx.uv.datos;

import mx.uv.modelo.Libro;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LibroDAO {

    // libro, puntuacion y quien lo publicó
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
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
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
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Conexion.close(rs);
            Conexion.close(ps);
            Conexion.close(conn);
        }
        return lista;
    }
}