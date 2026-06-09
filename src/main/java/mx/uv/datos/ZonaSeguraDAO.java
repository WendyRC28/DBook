package mx.uv.datos;

import mx.uv.modelo.ZonaSegura;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ZonaSeguraDAO {

    // Devuelve todas las zonas activas ordenadas por nombre
    public List<ZonaSegura> listar() {
        List<ZonaSegura> lista = new ArrayList<>();
        String sql = "SELECT * FROM zona_segura WHERE activa = TRUE ORDER BY nombre";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = Conexion.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                ZonaSegura z = new ZonaSegura();
                z.setId(rs.getInt("id"));
                z.setNombre(rs.getString("nombre"));
                z.setDescripcion(rs.getString("descripcion"));
                z.setLatitud(rs.getDouble("latitud"));
                z.setLongitud(rs.getDouble("longitud"));
                z.setActiva(rs.getBoolean("activa"));
                lista.add(z);
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