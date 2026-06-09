package mx.uv.modelo;

import java.io.Serializable;

public class Transaccion implements Serializable {

    private int id;
    private String tipo;
    private String fecha;
    private String zonaEntrega;
    private String estado;
    private int idUsuario;
    private int idLibro;

    // Campos extra del JOIN (no son columnas de la tabla)
    private String tituloLibro;
    private String autorLibro;
    private String nombreSolicitante;

    public Transaccion() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getFecha() { return fecha; }
    public void setFecha(String fecha) { this.fecha = fecha; }

    public String getZonaEntrega() { return zonaEntrega; }
    public void setZonaEntrega(String zonaEntrega) { this.zonaEntrega = zonaEntrega; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public int getIdLibro() { return idLibro; }
    public void setIdLibro(int idLibro) { this.idLibro = idLibro; }

    public String getTituloLibro() { return tituloLibro; }
    public void setTituloLibro(String tituloLibro) { this.tituloLibro = tituloLibro; }

    public String getAutorLibro() { return autorLibro; }
    public void setAutorLibro(String autorLibro) { this.autorLibro = autorLibro; }

    public String getNombreSolicitante() { return nombreSolicitante; }
    public void setNombreSolicitante(String nombreSolicitante) { this.nombreSolicitante = nombreSolicitante; }
}