package mx.uv.controlador;

import mx.uv.datos.LibroDAO;
import mx.uv.modelo.Libro;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/inicio")
public class ServletInicio extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession sesion = req.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Libro> libros = new LibroDAO().listar();
        req.setAttribute("libros", libros);
        req.getRequestDispatcher("/inicio.jsp").forward(req, res);
    }
}