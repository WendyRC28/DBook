package mx.uv.modelo;

import java.io.Serializable;

public class Foro implements Serializable {

    private int id;
    private String nombre;
    private String tipo;           // 'foro'
    private String zona;
    private int idUsuario;
    private int idLibro;

    // Campos de JOIN (para mostrar en la vista)
    private String nombreUsuario;  // quién creó el foro
    private String tituloLibro;    // libro al que está asociado
    private String autorLibro;

    public Foro() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getZona() { return zona; }
    public void setZona(String zona) { this.zona = zona; }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public int getIdLibro() { return idLibro; }
    public void setIdLibro(int idLibro) { this.idLibro = idLibro; }

    public String getNombreUsuario() { return nombreUsuario; }
    public void setNombreUsuario(String nombreUsuario) { this.nombreUsuario = nombreUsuario; }

    public String getTituloLibro() { return tituloLibro; }
    public void setTituloLibro(String tituloLibro) { this.tituloLibro = tituloLibro; }

    public String getAutorLibro() { return autorLibro; }
    public void setAutorLibro(String autorLibro) { this.autorLibro = autorLibro; }
}