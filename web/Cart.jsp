<%@ page import="dtos.ItemPedidoDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% List<ItemPedidoDTO> itemPedidos = (List<ItemPedidoDTO>) request.getSession().getAttribute("itemsPedidos");%>
<html>
<body>
    <table class="table table-striped">
        <thead class="thead-dark">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Codigo</th>
            <th scope="col">Descripcion</th>
            <th scope="col">Cantidad</th>
            <th scope="col">Precio</th>
            <th scope="col">Accion</th>
        </tr>
        </thead>
        <tbody>
        <%for(int index = 0 ; index <  itemPedidos.size() ; index++){
            ItemPedidoDTO item = itemPedidos.get(index);%>
        <tr>
            <td><%= index+1%></td>
            <td><%= item.getArticulo().getCodigo() %></td>
            <td><%= item.getArticulo().getDescripcion() %></td>
            <td><%= item.getCantidad() %></td>
            <td><%= item.getArticulo().getPrecio() * item.getCantidad() %></td>
            <td>
                <form name="delete" class="text-center" action="CrearPedido" method="POST">
                    <input type="hidden" name= "delindex" value='<%= index %>'>
                    <input type="hidden" name="action" value="DELETE">
                    <button type="submit" class="btn btn-outline-danger"><i class="fas fa-trash-alt"></i></button>
                </form>
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
    <h1 class="card-title pricing-card-title text-muted" style="width: 25%; margin: 0 auto;">Total: <small>$ ${total}</small></h1>
    <form name="checkout" action="CrearPedido" method="POST" style="width: 50%; margin: 25px auto;">
        <div class="form-row">
            <div class="col-7">
                <input type="text" class="form-control" placeholder="Domicilo de Entrega" name="domicilio-entrega">
            </div>
            <div class="col">
                <input type="hidden" name="action" value="CHECKOUT">
                <button type="submit" class="btn btn-success">Comprar!</button>
            </div>
        </div>
    </form>



    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/font-awesome-all.css">
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.bundle.min.js'></script>
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/font-awesome-all.js'></script>
</body>
</html>
