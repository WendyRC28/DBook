package mx.uv.modelo;

import java.io.Serializable;

public class Evento implements Serializable {

    private int id;
    private String nombre;
    private String tipo;
    private String zona;
    private int idUsuario;

    // Campos del JOIN
    private String tituloLibro;
    private String carreraLibro;
    private String autorLibro;
    private String nombreUsuario;

    public Evento() {}

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

    public String getTituloLibro() { return tituloLibro; }
    public void setTituloLibro(String v) { this.tituloLibro = v; }

    public String getCarreraLibro() { return carreraLibro; }
    public void setCarreraLibro(String v) { this.carreraLibro = v; }

    public String getAutorLibro() { return autorLibro; }
    public void setAutorLibro(String v) { this.autorLibro = v; }

    public String getNombreUsuario() { return nombreUsuario; }
    public void setNombreUsuario(String v) { this.nombreUsuario = v; }
}