package mx.uv.controlador;

import mx.uv.datos.LibroDAO;
import mx.uv.datos.TransaccionDAO;
import mx.uv.datos.ZonaSeguraDAO;
import mx.uv.modelo.Libro;
import mx.uv.modelo.Transaccion;
import mx.uv.modelo.Usuario;
import mx.uv.modelo.ZonaSegura;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/transaccion")
public class ServletTransaccion extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession sesion = req.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idStr = req.getParameter("id");
        String tipo  = req.getParameter("tipo"); // "compra" o "intercambio"

        if (idStr == null || tipo == null) {
            res.sendRedirect(req.getContextPath() + "/inicio");
            return;
        }

        int idLibro = Integer.parseInt(idStr);
        Usuario u   = (Usuario) sesion.getAttribute("usuarioLogueado");

        // Carga el libro que se quiere comprar/intercambiar
        Libro libro = new LibroDAO().buscarPorId(idLibro);

        // Carga las zonas seguras para que el usuario elija
        List<ZonaSegura> zonas = new ZonaSeguraDAO().listar();

        // Si es intercambio, carga los libros propios del usuario para que ofrezca uno
        List<Libro> misLibros = new ArrayList<>();
        if ("intercambio".equals(tipo)) {
            misLibros = new LibroDAO().listarPorUsuario(u.getId());
        }

        req.setAttribute("libro",     libro);
        req.setAttribute("tipo",      tipo);
        req.setAttribute("zonas",     zonas);
        req.setAttribute("misLibros", misLibros);
        req.getRequestDispatcher("/transaccion.jsp").forward(req, res);
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

        Usuario u         = (Usuario) sesion.getAttribute("usuarioLogueado");
        String tipo       = req.getParameter("tipo");
        String idLibroStr = req.getParameter("idLibro");
        String zona       = req.getParameter("zona");

        if (zona == null || zona.trim().isEmpty() || idLibroStr == null) {
            res.sendRedirect(req.getContextPath() + "/inicio");
            return;
        }

        int idLibro = Integer.parseInt(idLibroStr);

        // Si es intercambio, agrega el libro ofrecido al registro de la zona
        String zonaEntrega = zona.trim();
        if ("intercambio".equals(tipo)) {
            String libroOfrecido = req.getParameter("libroOfrecido");
            if (libroOfrecido != null && !libroOfrecido.trim().isEmpty()) {
                // Guardamos en zona_entrega: "Nombre zona | Ofrece: Titulo libro"
                String registro = zona.trim() + " | Ofrece: " + libroOfrecido.trim();
                zonaEntrega = registro.length() > 150 ? registro.substring(0, 150) : registro;
            }
        }

        Transaccion tr = new Transaccion();
        tr.setTipo("intercambio".equals(tipo) ? "intercambio" : "compra");
        tr.setZonaEntrega(zonaEntrega);
        tr.setIdUsuario(u.getId());
        tr.setIdLibro(idLibro);

        boolean ok = new TransaccionDAO().registrar(tr);

        if (ok) {
            // PRG: redirect a inicio con mensaje de éxito
            res.sendRedirect(req.getContextPath() + "/inicio?msg=transaccion");
        } else {
            res.sendRedirect(req.getContextPath() + "/transaccion?id=" + idLibro + "&tipo=" + tipo + "&error=1");
        }
    }
}