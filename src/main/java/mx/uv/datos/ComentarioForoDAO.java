package mx.uv.datos;

import mx.uv.modelo.ComentarioForo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComentarioForoDAO {

    public List<ComentarioForo> listarPorEvento(int idEvento) {
        List<ComentarioForo> lista = new ArrayList<>();
        String sql =
                "SELECT c.id, c.contenido, " +
                        "       TO_CHAR(c.fecha,'DD/MM/YYYY HH24:MI') AS fecha, " +
                        "       c.id_usuario, c.id_evento, u.nombre AS nombre_usuario " +
                        "FROM comentario_foro c " +
                        "JOIN usuario u ON c.id_usuario = u.id " +
                        "WHERE c.id_evento = ? " +
                        "ORDER BY c.fecha ASC";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idEvento);
            rs = ps.executeQuery();
            while (rs.next()) {
                ComentarioForo c = new ComentarioForo();
                c.setId(rs.getInt("id"));
                c.setContenido(rs.getString("contenido"));
                c.setFecha(rs.getString("fecha"));
                c.setIdUsuario(rs.getInt("id_usuario"));
                c.setIdEvento(rs.getInt("id_evento"));
                c.setNombreUsuario(rs.getString("nombre_usuario"));
                lista.add(c);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { Conexion.close(rs); Conexion.close(ps); Conexion.close(conn); }
        return lista;
    }

    public boolean agregar(ComentarioForo c) {
        String sql = "INSERT INTO comentario_foro (contenido, id_usuario, id_evento) VALUES (?,?,?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, c.getContenido());
            ps.setInt(2, c.getIdUsuario());
            ps.setInt(3, c.getIdEvento());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) { e.printStackTrace(); return false; }
        finally { Conexion.close(ps); Conexion.close(conn); }
    }
}