package mx.uv.controlador;

import mx.uv.datos.UsuarioDAO;
import mx.uv.modelo.Usuario;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/registro")
public class ServletRegistro extends HttpServlet {

    // Muestra el formulario
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/registro.jsp").forward(req, res);
    }

    // Al hacer clic en "Crear cuenta"
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String nombre     = req.getParameter("nombre");
        String correo     = req.getParameter("correo");
        String contrasena = req.getParameter("contrasena");
        String confirmar  = req.getParameter("confirmar");
        String rol        = req.getParameter("rol");

        // validar los campos obligatorios
        if (nombre == null || nombre.trim().isEmpty()
                || correo == null || correo.trim().isEmpty()
                || contrasena == null || contrasena.isEmpty()
                || rol == null || rol.trim().isEmpty()) {
            req.setAttribute("error", "Todos los campos son obligatorios");
            req.getRequestDispatcher("/registro.jsp").forward(req, res);
            return;
        }

        // validacion de correo
        if (!correo.endsWith("uv.mx")) {
            req.setAttribute("error", "Solo se permiten correos institucionales uv.mx");
            req.getRequestDispatcher("/registro.jsp").forward(req, res);
            return;
        }

        // si ambas contraseñas coinciden
        if (!contrasena.equals(confirmar)) {
            req.setAttribute("error", "Las contraseñas no coinciden");
            req.getRequestDispatcher("/registro.jsp").forward(req, res);
            return;
        }

        // roles  permitidos alumno o profesor
        if (!rol.equals("alumno") && !rol.equals("profesor")) {
            req.setAttribute("error", "Selecciona un rol válido");
            req.getRequestDispatcher("/registro.jsp").forward(req, res);
            return;
        }

        // objeto Usuario
        Usuario u = new Usuario();
        u.setNombre(nombre.trim());
        u.setCorreoUv(correo.trim());
        u.setContrasena(contrasena); // texto plano, igual que el login actual
        u.setRol(rol);

        // Insertar usuario en el dao
        boolean ok = new UsuarioDAO().registrar(u);

        if (ok) {
            // cuando una cuenta esta bien  creada
            req.setAttribute("exito", "Cuenta creada con éxito.");
            req.getRequestDispatcher("/registro.jsp").forward(req, res);
        } else {
            // registrar() devolvió false (p. ej. correo duplicado por el UNIQUE de la BD)
            req.setAttribute("error", "No se pudo registrar. El correo ya está en uso.");
            req.getRequestDispatcher("/registro.jsp").forward(req, res);
        }
    }
}