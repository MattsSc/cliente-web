import com.google.gson.Gson;
import delegates.CompraDelegate;
import dtos.ArticuloDTO;
import dtos.OrdenDeCompraDTO;
import dtos.ProveedorDTO;
import dtos.ProveedorPrecioDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/Compra")
public class Compra extends HttpServlet {


    private static final long serialVersionUID = 4882233637904494466L;

    public Compra() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action.equals("CREATE")){
            String articuloId = req.getParameter("product");
            String provId = req.getParameter("proveedor");
            if(articuloId.isEmpty() || provId.isEmpty()){
                req.setAttribute("errorForm","Seleccionar un articulo/proveedor para proceder!.");
            }else{
                List<ArticuloDTO> arts = (List<ArticuloDTO>)req.getSession().getAttribute("articulos");
                List<ProveedorDTO> provs = (List<ProveedorDTO>)req.getSession().getAttribute("proveedores");

                OrdenDeCompraDTO ordenDeCompraDTO = new OrdenDeCompraDTO(
                        arts.stream().filter(art -> art.getCodigo().equals(Integer.valueOf(articuloId))).findFirst().get(),
                        provs.stream().filter(prov -> prov.getId().equals(Integer.valueOf(provId))).findFirst().get()
                );

                CompraDelegate.getInstance().crearOrdenDeCompra(ordenDeCompraDTO);
            }
        }
        if(action.equals("UPDATE")){
            CompraDelegate.getInstance().asignarOrdenesDePedidoAOrdenesAbiertas();
        }
        ServletContext sc = getServletContext();
        RequestDispatcher rd = sc.getRequestDispatcher("/Compra.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String articuloId = req.getParameter("product");
        if(articuloId != null) {
            List<ProveedorPrecioDTO> proveedorPrecioDTOS = CompraDelegate.getInstance().obtenerUltimos3Proveedores(Integer.valueOf(articuloId));
            resp.setContentType("application/json");
            resp.getWriter().write(new Gson().toJson(proveedorPrecioDTOS));
        }else{
            List<OrdenDeCompraDTO> ordenes = CompraDelegate.getInstance().obtenerTodasLasOrdenes();
            resp.setContentType("application/json");
            resp.getWriter().write(new Gson().toJson(ordenes));
        }
    }
}
