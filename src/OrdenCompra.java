import com.google.gson.Gson;
import delegates.CompraDelegate;
import delegates.PedidoDelegate;
import dtos.OrdenDeCompraDTO;
import utils.SessionVars;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
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

@WebServlet("/OrdenCompra")
public class OrdenCompra extends HttpServlet {
    private static final long serialVersionUID = 8628483810720258028L;

    public OrdenCompra() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action.equals("CLOSE")){
            Integer ocId = Integer.valueOf(req.getParameter("ocId"));
            Float precio = Float.valueOf(req.getParameter("precio"));
            DateFormat sourceFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date fechaVenc = sourceFormat.parse(req.getParameter("fechaVenc"));
                CompraDelegate.getInstance().cerrarOrdenDeCompra(ocId,precio,fechaVenc);
                req.getRequestDispatcher("/Despacho.jsp").forward(req, resp);
            } catch (ParseException e) {
                resp.getWriter().write("alert('Hubo un error intente mas tarde');");
            }

        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.removeAttribute(SessionVars.ERROR_MESSAGE.toString());
        Integer orderId = Integer.valueOf(req.getParameter("orderOc"));
            OrdenDeCompraDTO oc = CompraDelegate.getInstance().obtenerOc(orderId);
            resp.setContentType("application/json");
            resp.getWriter().write(new Gson().toJson(oc));
    }
}
