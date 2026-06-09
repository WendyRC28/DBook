package mx.uv.datos;

import mx.uv.modelo.Evento;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventoDAO {

    // Lista todos los foros (compatile con foros viejos y nuevos)
    public List<Evento> listar() {
        List<Evento> lista = new ArrayList<>();
        String sql =
                "SELECT e.id, e.nombre, e.zona, e.tipo, e.id_usuario, " +
                        "       COALESCE(l.titulo,  e.nombre)                         AS titulo_libro, " +
                        "       COALESCE(l.autor,   SPLIT_PART(e.zona,'||',1))        AS autor_libro, " +
                        "       COALESCE(l.carrera, SPLIT_PART(e.zona,'||',2))        AS carrera_libro, " +
                        "       u.nombre AS nombre_usuario " +
                        "FROM evento e " +
                        "LEFT JOIN libro   l ON e.id_libro   = l.id " +
                        "JOIN      usuario u ON e.id_usuario = u.id " +
                        "ORDER BY e.id DESC";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Evento ev = new Evento();
                ev.setId(rs.getInt("id"));
                ev.setNombre(rs.getString("nombre"));
                ev.setZona(rs.getString("zona"));
                ev.setTituloLibro(rs.getString("titulo_libro"));
                ev.setAutorLibro(rs.getString("autor_libro"));
                ev.setCarreraLibro(rs.getString("carrera_libro"));
                ev.setNombreUsuario(rs.getString("nombre_usuario"));
                lista.add(ev);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { Conexion.close(rs); Conexion.close(ps); Conexion.close(conn); }
        return lista;
    }

    // Crea un foro con texto libre devuelve el id nuevo
    public int crear(Evento ev) {

        String sql = "INSERT INTO evento (nombre, tipo, zona, id_usuario) " +
                "VALUES (?, 'foro', ?, ?) RETURNING id";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, ev.getNombre());
            ps.setString(2, ev.getZona());
            ps.setInt(3, ev.getIdUsuario());
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { Conexion.close(rs); Conexion.close(ps); Conexion.close(conn); }
        return -1;
    }
}