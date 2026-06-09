package mx.uv.controlador;

import mx.uv.datos.ComentarioForoDAO;
import mx.uv.datos.EventoDAO;
import mx.uv.datos.LibroDAO;
import mx.uv.modelo.ComentarioForo;
import mx.uv.modelo.Evento;
import mx.uv.modelo.Libro;
import mx.uv.modelo.Usuario;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/foro")
public class ServletForo extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession sesion = req.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Evento> foros = new EventoDAO().listar();
        List<ComentarioForo> comentarios = new ArrayList<>();
        int idSel = -1;

        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                idSel = Integer.parseInt(idParam);
                comentarios = new ComentarioForoDAO().listarPorEvento(idSel);
            } catch (NumberFormatException ignored) {}
        }

        req.setAttribute("foros",       foros);
        req.setAttribute("comentarios", comentarios);
        req.setAttribute("idSel",       idSel);
        req.getRequestDispatcher("/foro.jsp").forward(req, res);
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

        Usuario u     = (Usuario) sesion.getAttribute("usuarioLogueado");
        String accion = req.getParameter("accion");

        if ("crear".equals(accion)) {
            String nombreLibro = req.getParameter("nombreLibro");
            String autorLibro  = req.getParameter("autorLibro");
            String genero      = req.getParameter("genero");

            if (nombreLibro == null || nombreLibro.trim().isEmpty()) {
                res.sendRedirect(req.getContextPath() + "/foro?error=datos");
                return;
            }

            Evento ev = new Evento();
            ev.setNombre(nombreLibro.trim());
            // Guardamos autor y género en zona separados por ||
            ev.setZona((autorLibro != null ? autorLibro.trim() : "") +
                    "||" +
                    (genero != null ? genero.trim() : ""));
            ev.setIdUsuario(u.getId());

            int nuevoId = new EventoDAO().crear(ev);
            if (nuevoId > 0) {
                res.sendRedirect(req.getContextPath() + "/foro?id=" + nuevoId);
            } else {
                res.sendRedirect(req.getContextPath() + "/foro?error=crear");
            }

        } else if ("comentar".equals(accion)) {
            String contenido   = req.getParameter("contenido");
            String idEventoStr = req.getParameter("idEvento");

            if (contenido == null || contenido.trim().isEmpty() || idEventoStr == null) {
                res.sendRedirect(req.getContextPath() + "/foro");
                return;
            }

            int idEvento = Integer.parseInt(idEventoStr);
            ComentarioForo c = new ComentarioForo();
            c.setContenido(contenido.trim());
            c.setIdUsuario(u.getId());
            c.setIdEvento(idEvento);
            new ComentarioForoDAO().agregar(c);
            res.sendRedirect(req.getContextPath() + "/foro?id=" + idEvento);
        }
    }
}