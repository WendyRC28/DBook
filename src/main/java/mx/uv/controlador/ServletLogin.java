package mx.uv.controlador;

import mx.uv.datos.UsuarioDAO;
import mx.uv.modelo.Usuario;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class ServletLogin extends HttpServlet {

    // login
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, res);
    }

    // al hacer  clic en "Entrar"
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String correo     = req.getParameter("correo");
        String contrasena = req.getParameter("contrasena");

        // VALIDACIÓN  en terminacion para maestros, alumnos, egresados terminacion: uv.mx
        if (correo == null || !correo.endsWith("uv.mx")) {
            req.setAttribute("error", "Solo se permiten correos institucionales uv.mx");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
            return;
        }

        // VALIDACIÓN 2 usuario exista en la BD
        Usuario u = new UsuarioDAO().login(correo, contrasena);

        if (u == null) {
            req.setAttribute("error", "Correo o contraseña incorrectos");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
            return;
        }

        HttpSession sesion = req.getSession();
        sesion.setAttribute("usuarioLogueado", u);
        res.sendRedirect(req.getContextPath() + "/inicio");
    }
}