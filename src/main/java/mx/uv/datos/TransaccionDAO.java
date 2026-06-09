package mx.uv.datos;

import mx.uv.modelo.Transaccion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransaccionDAO {

    public boolean registrar(Transaccion t) {
        String sql = "INSERT INTO transaccion (tipo, zona_entrega, estado, id_usuario, id_libro) " +
                "VALUES (?, ?, 'pendiente', ?, ?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, t.getTipo());
            ps.setString(2, t.getZonaEntrega());
            ps.setInt(3, t.getIdUsuario());
            ps.setInt(4, t.getIdLibro());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) { e.printStackTrace(); return false; }
        finally { Conexion.close(ps); Conexion.close(conn); }
    }

    // Solicitudes RECIBIDAS
    public List<Transaccion> listarRecibidas(int idUsuario) {
        List<Transaccion> lista = new ArrayList<>();
        String sql =
                "SELECT t.id, t.tipo, TO_CHAR(t.fecha,'DD/MM/YYYY') AS fecha, " +
                        "       t.zona_entrega, t.estado, t.id_usuario, t.id_libro, " +
                        "       l.titulo AS titulo_libro, l.autor AS autor_libro, " +
                        "       u.nombre AS nombre_solicitante " +
                        "FROM transaccion t " +
                        "JOIN libro   l ON t.id_libro   = l.id " +
                        "JOIN usuario u ON t.id_usuario = u.id " +
                        "WHERE l.id_usuario = ? " +
                        "ORDER BY t.fecha DESC";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();
            while (rs.next()) { lista.add(mapear(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { Conexion.close(rs); Conexion.close(ps); Conexion.close(conn); }
        return lista;
    }

    // Solicitudes ENVIADAS
    public List<Transaccion> listarEnviadas(int idUsuario) {
        List<Transaccion> lista = new ArrayList<>();
        String sql =
                "SELECT t.id, t.tipo, TO_CHAR(t.fecha,'DD/MM/YYYY') AS fecha, " +
                        "       t.zona_entrega, t.estado, t.id_usuario, t.id_libro, " +
                        "       l.titulo AS titulo_libro, l.autor AS autor_libro, " +
                        "       u.nombre AS nombre_solicitante " +
                        "FROM transaccion t " +
                        "JOIN libro   l ON t.id_libro   = l.id " +
                        "JOIN usuario u ON l.id_usuario = u.id " +
                        "WHERE t.id_usuario = ? " +
                        "ORDER BY t.fecha DESC";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();
            while (rs.next()) { lista.add(mapear(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { Conexion.close(rs); Conexion.close(ps); Conexion.close(conn); }
        return lista;
    }

    // Reutilizable: convierte una fila en la trasaccion
    private Transaccion mapear(ResultSet rs) throws SQLException {
        Transaccion t = new Transaccion();
        t.setId(rs.getInt("id"));
        t.setTipo(rs.getString("tipo"));
        t.setFecha(rs.getString("fecha"));
        t.setZonaEntrega(rs.getString("zona_entrega"));
        t.setEstado(rs.getString("estado"));
        t.setIdUsuario(rs.getInt("id_usuario"));
        t.setIdLibro(rs.getInt("id_libro"));
        t.setTituloLibro(rs.getString("titulo_libro"));
        t.setAutorLibro(rs.getString("autor_libro"));
        t.setNombreSolicitante(rs.getString("nombre_solicitante"));
        return t;
    }
    // Cambia el estado de una transacción
    public boolean actualizarEstado(int id, String nuevoEstado) {
        String sql = "UPDATE transaccion SET estado = ? WHERE id = ?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, nuevoEstado);
            ps.setInt(2, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) { e.printStackTrace(); return false; }
        finally { Conexion.close(ps); Conexion.close(conn); }
    }
}