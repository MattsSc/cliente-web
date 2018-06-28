<%@ page import="dtos.ItemPedidoDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% List<ItemPedidoDTO> itemPedidos = (List<ItemPedidoDTO>) request.getSession().getAttribute("itemsPedidos");%>
<html>
<head>
    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.js'></script>
</head>
<body>
    <table class="table">
        <thead class="thead-dark">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Codigo</th>
            <th scope="col">Descripcion</th>
            <th scope="col">Cantidad</th>
            <th scope="col">Accion</th>
        </tr>
        </thead>
        <tbody>
        <%for(int index = 0 ; index <  itemPedidos.size() ; index++){
            ItemPedidoDTO item = itemPedidos.get(index);%>
        <tr>
            <td><%= index+1%></td>
            <td><% out.print(item.getArticulo().getCodigo()); %></td>
            <td><% out.print(item.getArticulo().getDescripcion()); %></td>
            <td><% out.print(item.getCantidad());%></td>
            <td>
                <form name="delete" action="CrearPedido" method="POST">
                    <input type="hidden" name= "delindex" value='<%= index %>'>
                    <input type="hidden" name="action" value="DELETE">
                    <button type="submit" class="btn btn-danger">Eliminar</button>
                </form>
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
    <form  name="checkout" action="CrearPedido" method="POST">
        <div class="control-group">
            <label class="control-label" for="domicilio-entrega">Domicilio entrega</label>
            <div class="controls">
                <input type="text" id="domicilio-entrega" name="domicilio-entrega" value="" class="span3 required">
            </div>
        </div>
        <input type="hidden" name="action" value="CHECKOUT">
        <button type="submit" class="btn btn-success">Finalizar</button>
    </form>
</body>
</html>
