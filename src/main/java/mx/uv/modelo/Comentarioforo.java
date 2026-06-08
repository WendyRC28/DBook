package mx.uv.modelo;

import java.io.Serializable;
import java.sql.Timestamp;

public class Comentarioforo implements Serializable {

    private int id;
    private String contenido;
    private Timestamp fecha;
    private int idUsuario;
    private int idEvento;

    // JOIN
    private String nombreUsuario;

    public Comentarioforo() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getContenido() { return contenido; }
    public void setContenido(String contenido) { this.contenido = contenido; }

    public Timestamp getFecha() { return fecha; }
    public void setFecha(Timestamp fecha) { this.fecha = fecha; }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public int getIdEvento() { return idEvento; }
    public void setIdEvento(int idEvento) { this.idEvento = idEvento; }

    public String getNombreUsuario() { return nombreUsuario; }
    public void setNombreUsuario(String nombreUsuario) { this.nombreUsuario = nombreUsuario; }
}