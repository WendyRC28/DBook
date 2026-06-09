package mx.uv.controlador;

import mx.uv.datos.TransaccionDAO;
import mx.uv.modelo.Transaccion;
import mx.uv.modelo.Usuario;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/misSolicitudes")
public class ServletMisSolicitudes extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession sesion = req.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Usuario u = (Usuario) sesion.getAttribute("usuarioLogueado");
        TransaccionDAO dao = new TransaccionDAO();

        // Las que otros me enviaron a mí
        List<Transaccion> recibidas = dao.listarRecibidas(u.getId());
        // Las que yo envié a otros
        List<Transaccion> enviadas  = dao.listarEnviadas(u.getId());

        req.setAttribute("recibidas", recibidas);
        req.setAttribute("enviadas",  enviadas);
        req.getRequestDispatcher("/misSolicitudes.jsp").forward(req, res);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession sesion = req.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idStr  = req.getParameter("idTransaccion");
        String accion = req.getParameter("accion"); // "aceptar" o "rechazar"

        if (idStr != null && accion != null) {
            int id = Integer.parseInt(idStr);
            String nuevoEstado = "aceptar".equals(accion) ? "aceptada" : "rechazada";
            new TransaccionDAO().actualizarEstado(id, nuevoEstado);
        }

        //  recargar la página con el estado actualizado
        res.sendRedirect(req.getContextPath() + "/misSolicitudes");
    }
}