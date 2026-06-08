package mx.uv.controlador;

import mx.uv.datos.ForoDAO;
import mx.uv.modelo.Foro;
import mx.uv.modelo.Libro;
import mx.uv.modelo.Usuario;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/foro")
public class ServletForo extends HttpServlet {

    // Muestra los foros disponibles
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession sesion = req.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        ForoDAO dao = new ForoDAO();
        List<Foro>  foros  = dao.listar();
        List<Libro> libros = dao.listarLibros();

        req.setAttribute("foros",  foros);
        req.setAttribute("libros", libros);
        req.getRequestDispatcher("/foro.jsp").forward(req, res);
    }

    // Crea un foro nuevo desde el formulario
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession sesion = req.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String nombre    = req.getParameter("nombre");
        String zona      = req.getParameter("zona");
        String idLibroStr = req.getParameter("idLibro");

        // Validación de campos obligatorios
        if (nombre == null || nombre.trim().isEmpty()
                || zona == null || zona.trim().isEmpty()
                || idLibroStr == null || idLibroStr.trim().isEmpty()) {

            ForoDAO dao = new ForoDAO();
            req.setAttribute("error",  "Todos los campos son obligatorios");
            req.setAttribute("foros",  dao.listar());
            req.setAttribute("libros", dao.listarLibros());
            req.getRequestDispatcher("/foro.jsp").forward(req, res);
            return;
        }

        // Construye el objeto Foro
        Foro f = new Foro();
        f.setNombre(nombre.trim());
        f.setZona(zona.trim());
        f.setIdLibro(Integer.parseInt(idLibroStr));

        // El usuario que crea el foro es el que está en sesión
        Usuario u = (Usuario) sesion.getAttribute("usuarioLogueado");
        f.setIdUsuario(u.getId());

        boolean ok = new ForoDAO().crear(f);

        if (ok) {
            res.sendRedirect(req.getContextPath() + "/foro");
        } else {
            ForoDAO dao = new ForoDAO();
            req.setAttribute("error",  "No se pudo crear el foro. Intenta de nuevo.");
            req.setAttribute("foros",  dao.listar());
            req.setAttribute("libros", dao.listarLibros());
            req.getRequestDispatcher("/foro.jsp").forward(req, res);
        }
    }
}