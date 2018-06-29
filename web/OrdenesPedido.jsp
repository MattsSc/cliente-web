<%@ page import="java.util.List" %>
<%@ page import="delegates.PedidoDelegate" %>
<%@ page import="dtos.OrdenDePedidoDTO" %>
<%--
  Created by IntelliJ IDEA.
  User: matias.scandroglio
  Date: 29/06/2018
  Time: 14:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<%
    List<OrdenDePedidoDTO> ordenDePedidoDTOS = PedidoDelegate.getInstance().listarOrdenesDePedido();
%>
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4" style="left: 40px;">

    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Ordenes de Pedidos</h1>
    </div>

    <jsp:include page="GenerarOc.jsp"/>

    <h3>Ordenes de pedido Abiertas</h3>
    <div class="table-responsive">
        <table class="table table-striped table-sm">
            <thead>
            <tr>
                <th>Pedido</th>
                <th>Articulo</th>
                <th>Cantidad</th>
                <th>Orden de Compra</th>
            </tr>
            </thead>
            <tbody>
            <%
                for(int index = 0 ; index <  ordenDePedidoDTOS.size() ; index++){
                    OrdenDePedidoDTO op = ordenDePedidoDTOS.get(index);%>
            <tr>
                <td><%= op.getIdPedido()  %></td>
                <td><%= op.getArticulo().getDescripcion()  %></td>
                <td><%= op.getCantidad()  %></td>
                <td><%= op.getIdOrdenCompra() != null ? op.getIdOrdenCompra(): "SIN ASIGNAR"  %></td>
            </tr>
            <%}%>
            </tbody>
        </table>

        <canvas class="my-4 w-100 chartjs-render-monitor" id="ghost" width="2304" height="972" style="display: block; height: 486px; width: 1152px;"></canvas>
    </div>
</main>

<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/compra.css">
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.bundle.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/Chart.bundle.min.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/feather-logo.js'></script>

</body>
</html>
