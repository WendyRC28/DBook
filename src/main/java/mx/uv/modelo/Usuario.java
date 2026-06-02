package mx.uv.modelo;

import java.io.Serializable;

public class Usuario implements Serializable {

    private int id;
    private String nombre;
    private String correoUv;   //
    private String contrasena;
    private String rol;        // 'alumno' o 'profesor'
    private boolean activo;

    // vacio necesario para crear objetos sin datos ?
    public Usuario() {}

    //  leer de la BD
    public Usuario(int id, String nombre, String correoUv,
                   String contrasena, String rol, boolean activo) {
        this.id = id;
        this.nombre = nombre;
        this.correoUv = correoUv;
        this.contrasena = contrasena;
        this.rol = rol;
        this.activo = activo;
    }

    // Getters y Setters modificaciones
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCorreoUv() { return correoUv; }
    public void setCorreoUv(String correoUv) { this.correoUv = correoUv; }

    public String getContrasena() { return contrasena; }
    public void setContrasena(String contrasena) { this.contrasena = contrasena; }

    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }

    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }

    @Override
    public String toString() {
        return "Usuario: " + id + " | " + nombre + " | " + correoUv + " | " + rol;
    }
}