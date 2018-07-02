import com.google.gson.Gson;
import delegates.ArticuloDelegate;
import dtos.MovimientoPorEliminacionDTO;
import dtos.UbicacionDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/Articulo")
public class Articulo extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MovimientoPorEliminacionDTO mov = new MovimientoPorEliminacionDTO(
                new Date(),
                req.getParameter("mot"),
                Integer.valueOf(req.getParameter("cantRota")),
                req.getParameter("encargado"),
                req.getParameter("destino"),
                req.getParameter("autorizador"),
                req.getParameter("ubicacionText")
        );
        ArticuloDelegate.getInstance().generarMovimientoPorRotura(Integer.valueOf(req.getParameter("loteIdRoto")), mov);
        req.getRequestDispatcher("/Despacho.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer articuloId = Integer.valueOf(req.getParameter("articulo"));
        List<UbicacionDTO> ubicaciones = ArticuloDelegate.getInstance().obtenerUbicaciones(articuloId);
        resp.setContentType("application/json");
        resp.getWriter().write(new Gson().toJson(ubicaciones));
    }
}
