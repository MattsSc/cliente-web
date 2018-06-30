import com.google.gson.Gson;
import delegates.PedidoDelegate;
import dtos.PedidoDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Despacho")
public class Despacho extends HttpServlet {

    private static final long serialVersionUID = -9093721227692211601L;

    public Despacho() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer pedidoId = Integer.valueOf(req.getParameter("pedido"));
        req.getSession().setAttribute("pedido", pedidoId);
        PedidoDTO pedidoDTO = PedidoDelegate.getInstance().obtenerPedido(pedidoId);
        resp.setContentType("application/json");
        resp.getWriter().write(new Gson().toJson(pedidoDTO));
    }
}
