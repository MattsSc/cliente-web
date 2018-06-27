import delegates.ArticuloDelegate;
import dtos.ArticuloDTO;
import dtos.ItemPedidoDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CrearPedido")
public class CrearPedido extends HttpServlet {
    private static final long serialVersionUID = -1686191207140317645L;

    public CrearPedido() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String action = req.getParameter("action");
        List<ItemPedidoDTO> itemsPedidos = (List<ItemPedidoDTO>) session.getAttribute("itemsPedidos");
        if(action.equals("ADD")){
            ItemPedidoDTO item = getItemPedido(req);
            if(itemsPedidos == null){
                itemsPedidos = new ArrayList();
                itemsPedidos.add(item);
            }else{
                boolean found = false;
                for(ItemPedidoDTO itemPedidoDTO: itemsPedidos){
                    if(itemPedidoDTO.getArticulo().getCodigo().equals(item.getArticulo().getCodigo())){
                        itemPedidoDTO.setCantidad(itemPedidoDTO.getCantidad() + item.getCantidad());
                        found = true;
                    }
                }
                if(!found){
                    itemsPedidos.add(item);
                }
            }
        }
        if(action.equals("DELETE")){
            itemsPedidos.remove(req.getParameter("delindex"));
        }
        session.setAttribute("itemsPedidos", itemsPedidos);
        String url="/CrearPedido.jsp";
        ServletContext sc = getServletContext();
        RequestDispatcher rd = sc.getRequestDispatcher(url);
        rd.forward(req, resp);
    }

    private ItemPedidoDTO getItemPedido(HttpServletRequest req) throws RemoteException {
        String codigo = req.getParameter("product");
        Integer cantidad = Integer.valueOf(req.getParameter("cant"));
        ArticuloDTO articuloDTO = ArticuloDelegate.getInstance().obtenerArticulo(Integer.valueOf(codigo));
        return new ItemPedidoDTO(
                cantidad,
                articuloDTO
        );
    }
}
