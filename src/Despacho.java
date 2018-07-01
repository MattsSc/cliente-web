import com.google.gson.Gson;
import delegates.PedidoDelegate;
import dtos.ItemAProcesarDTO;
import dtos.PedidoDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/Despacho")
public class Despacho extends HttpServlet {

    private static final long serialVersionUID = -9093721227692211601L;

    public Despacho() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action.equals("UPDATE")){
            Integer pedidoId = (Integer) req.getSession().getAttribute("pedido");
           List<ItemAProcesarDTO> itemAProcesarDTOList = PedidoDelegate.getInstance().despacharPedido(pedidoId,req.getParameter("factura"));
            req.getSession().setAttribute("itemsProc", itemAProcesarDTOList);
            req.getRequestDispatcher("/Despacho.jsp").forward(req, resp);
        }
        if(action.equals("COMPLETE")){
            Integer pedidoId = (Integer) req.getSession().getAttribute("pedido");
            DateFormat sourceFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date date = sourceFormat.parse(req.getParameter("fechaEntrega"));
                PedidoDelegate.getInstance().completarPedido(pedidoId,date);
                req.getRequestDispatcher("/Despacho.jsp").forward(req, resp);
            } catch (ParseException e) {
                resp.getWriter().write("alert('Hubo un error intente mas tarde');");
            }
        }
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
