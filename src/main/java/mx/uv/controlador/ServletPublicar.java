package mx.uv.controlador;

import mx.uv.datos.LibroDAO;
import mx.uv.modelo.Libro;
import mx.uv.modelo.Usuario;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/publicar")
public class ServletPublicar extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession sesion = req.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/publicar.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession sesion = req.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String titulo    = req.getParameter("titulo");
        String autor     = req.getParameter("autor");
        String carrera   = req.getParameter("carrera");
        String estado    = req.getParameter("estado");
        String precioStr = req.getParameter("precio");

        if (titulo == null || titulo.trim().isEmpty()
                || autor == null || autor.trim().isEmpty()
                || carrera == null || carrera.trim().isEmpty()
                || estado == null || estado.trim().isEmpty()) {
            req.setAttribute("error", "Todos los campos son obligatorios");
            req.getRequestDispatcher("/publicar.jsp").forward(req, res);
            return;
        }

        Libro libro = new Libro();
        libro.setTitulo(titulo.trim());
        libro.setAutor(autor.trim());
        libro.setCarrera(carrera.trim());
        libro.setEstado(estado);

        if ("venta".equals(estado) && precioStr != null && !precioStr.trim().isEmpty()) {
            try {
                libro.setPrecio(Double.parseDouble(precioStr.trim()));
            } catch (NumberFormatException e) {
                req.setAttribute("error", "El precio debe ser un número válido");
                req.getRequestDispatcher("/publicar.jsp").forward(req, res);
                return;
            }
        }

        Usuario u = (Usuario) sesion.getAttribute("usuarioLogueado");
        libro.setIdUsuario(u.getId());

        boolean ok = new LibroDAO().publicar(libro);
        if (ok) {
            res.sendRedirect(req.getContextPath() + "/inicio");
        } else {
            req.setAttribute("error", "No se pudo publicar el libro. Intenta de nuevo.");
            req.getRequestDispatcher("/publicar.jsp").forward(req, res);
        }
    }
}