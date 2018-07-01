import com.google.gson.Gson;
import delegates.PedidoDelegate;
import dtos.ClienteDTO;
import dtos.PedidoDTO;
import utils.SessionVars;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/Cliente")
public class Cliente extends HttpServlet {

    public Cliente() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getParameter("logout") != null){
            req.getSession().removeAttribute(SessionVars.CLIENTE.toString());
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        }else{
            ClienteDTO clienteDTO = (ClienteDTO) req.getSession().getAttribute(SessionVars.CLIENTE.toString());
            List<PedidoDTO> pedidoDTOS = PedidoDelegate.getInstance().obtenerPedidosPorCliente(clienteDTO.getDni());

            resp.setContentType("application/json");
            resp.getWriter().write(new Gson().toJson(pedidoDTOS));
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ClienteDTO clienteDTO = (ClienteDTO) req.getSession().getAttribute(SessionVars.CLIENTE.toString());
        List<PedidoDTO> pedidoDTOS = PedidoDelegate.getInstance().obtenerPedidosPorCliente(clienteDTO.getDni());
        resp.setContentType("application/json");
        resp.getWriter().write(new Gson().toJson(pedidoDTOS));
    }
}
