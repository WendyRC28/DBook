package mx.uv.controlador;

import mx.uv.datos.ZonaSeguraDAO;
import mx.uv.modelo.ZonaSegura;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/zonas")
public class ServletZonas extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Seguridad: si no hay sesión iniciada, al login
        HttpSession sesion = req.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Trae las zonas de la BD y las manda a la vista
        List<ZonaSegura> zonas = new ZonaSeguraDAO().listar();
        req.setAttribute("zonas", zonas);
        req.getRequestDispatcher("/zonas.jsp").forward(req, res);
    }
}