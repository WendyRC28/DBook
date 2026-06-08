package mx.uv.datos;

import mx.uv.modelo.Comentarioforo;
import mx.uv.modelo.Foro;
import mx.uv.modelo.Libro;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ForoDAO {

    // Lista todos los foros con datos del usuario y libro asociado
    public List<Foro> listar() {
        List<Foro> lista = new ArrayList<>();
        String sql =
                "SELECT e.id, e.nombre, e.tipo, e.zona, e.id_usuario, e.id_libro, " +
                        "       u.nombre AS nombre_usuario, " +
                        "       l.titulo AS titulo_libro, l.autor AS autor_libro " +
                        "FROM evento e " +
                        "JOIN usuario u ON e.id_usuario = u.id " +
                        "JOIN libro  l ON e.id_libro  = l.id " +
                        "ORDER BY e.id DESC";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps   = conn.prepareStatement(sql);
            rs   = ps.executeQuery();
            while (rs.next()) {
                Foro f = new Foro();
                f.setId(rs.getInt("id"));
                f.setNombre(rs.getString("nombre"));
                f.setTipo(rs.getString("tipo"));
                f.setZona(rs.getString("zona"));
                f.setIdUsuario(rs.getInt("id_usuario"));
                f.setIdLibro(rs.getInt("id_libro"));
                f.setNombreUsuario(rs.getString("nombre_usuario"));
                f.setTituloLibro(rs.getString("titulo_libro"));
                f.setAutorLibro(rs.getString("autor_libro"));
                lista.add(f);
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

    // Lista los libros disponibles para asociar al crear un foro
    public List<Libro> listarLibros() {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT id, titulo, autor FROM libro ORDER BY titulo";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps   = conn.prepareStatement(sql);
            rs   = ps.executeQuery();
            while (rs.next()) {
                Libro l = new Libro();
                l.setId(rs.getInt("id"));
                l.setTitulo(rs.getString("titulo"));
                l.setAutor(rs.getString("autor"));
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

    // Crea un foro nuevo (zona siempre "En línea")
    public boolean crear(Foro f) {
        String sql = "INSERT INTO evento (nombre, tipo, zona, id_usuario, id_libro) " +
                "VALUES (?, 'foro', 'En línea', ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Conexion.getConnection();
            ps   = conn.prepareStatement(sql);
            ps.setString(1, f.getNombre());
            ps.setInt(2, f.getIdUsuario());
            ps.setInt(3, f.getIdLibro());
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

    // Guarda un comentario en un foro
    public boolean comentar(Comentarioforo c) {
        String sql = "INSERT INTO comentario_foro (contenido, id_usuario, id_evento) VALUES (?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = Conexion.getConnection();
            ps   = conn.prepareStatement(sql);
            ps.setString(1, c.getContenido());
            ps.setInt(2, c.getIdUsuario());
            ps.setInt(3, c.getIdEvento());
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

    // Lista los comentarios de un foro específico
    public List<Comentarioforo> listarComentarios(int idEvento) {
        List<Comentarioforo> lista = new ArrayList<>();
        String sql =
                "SELECT cf.id, cf.contenido, cf.fecha, cf.id_usuario, cf.id_evento, " +
                        "       u.nombre AS nombre_usuario " +
                        "FROM comentario_foro cf " +
                        "JOIN usuario u ON cf.id_usuario = u.id " +
                        "WHERE cf.id_evento = ? " +
                        "ORDER BY cf.fecha ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, idEvento);
            rs   = ps.executeQuery();
            while (rs.next()) {
                Comentarioforo c = new Comentarioforo();
                c.setId(rs.getInt("id"));
                c.setContenido(rs.getString("contenido"));
                c.setFecha(rs.getTimestamp("fecha"));
                c.setIdUsuario(rs.getInt("id_usuario"));
                c.setIdEvento(rs.getInt("id_evento"));
                c.setNombreUsuario(rs.getString("nombre_usuario"));
                lista.add(c);
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

    // Obtiene un foro por id (para la vista de detalle)
    public Foro obtenerPorId(int id) {
        String sql =
                "SELECT e.id, e.nombre, e.tipo, e.zona, e.id_usuario, e.id_libro, " +
                        "       u.nombre AS nombre_usuario, " +
                        "       l.titulo AS titulo_libro, l.autor AS autor_libro " +
                        "FROM evento e " +
                        "JOIN usuario u ON e.id_usuario = u.id " +
                        "JOIN libro  l ON e.id_libro  = l.id " +
                        "WHERE e.id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs   = ps.executeQuery();
            if (rs.next()) {
                Foro f = new Foro();
                f.setId(rs.getInt("id"));
                f.setNombre(rs.getString("nombre"));
                f.setTipo(rs.getString("tipo"));
                f.setZona(rs.getString("zona"));
                f.setIdUsuario(rs.getInt("id_usuario"));
                f.setIdLibro(rs.getInt("id_libro"));
                f.setNombreUsuario(rs.getString("nombre_usuario"));
                f.setTituloLibro(rs.getString("titulo_libro"));
                f.setAutorLibro(rs.getString("autor_libro"));
                return f;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Conexion.close(rs);
            Conexion.close(ps);
            Conexion.close(conn);
        }
        return null;
    }
}
