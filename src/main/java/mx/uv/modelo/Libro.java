package mx.uv.modelo;

import java.io.Serializable;

public class Libro implements Serializable {

    private int id;
    private String titulo;
    private String autor;
    private String carrera;
    private String estado;        // intercambio, venta, donacion
    private double precio;
    private int idUsuario;
    private String nombreUsuario;          // una consulta dentro de la bd para saber quien lo publico
    private double calificacionPromedio;   // promedio de estrellas (viene de un AVG)
    private int totalCalificaciones;       // cuántas reseñas tiene

    public Libro() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getAutor() { return autor; }
    public void setAutor(String autor) { this.autor = autor; }

    public String getCarrera() { return carrera; }
    public void setCarrera(String carrera) { this.carrera = carrera; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getNombreUsuario() { return nombreUsuario; }
    public void setNombreUsuario(String nombreUsuario) { this.nombreUsuario = nombreUsuario; }

    public double getCalificacionPromedio() { return calificacionPromedio; }
    public void setCalificacionPromedio(double calificacionPromedio) { this.calificacionPromedio = calificacionPromedio; }

    public int getTotalCalificaciones() { return totalCalificaciones; }
    public void setTotalCalificaciones(int totalCalificaciones) { this.totalCalificaciones = totalCalificaciones; }
}