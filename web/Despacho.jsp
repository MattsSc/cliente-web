<%@ page import="dtos.PedidoDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="delegates.PedidoDelegate" %><%--
  Created by IntelliJ IDEA.
  User: matias.scandroglio
  Date: 30/06/2018
  Time: 02:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<%
    List<PedidoDTO> pedidoDTOS = PedidoDelegate.getInstance().listarPedidos("DESPACHABLE");
%>
<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">TP ADO - Grupo 2</a>
    <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
            <a class="nav-link" href="/">Salir</a>
        </li>
    </ul>
</nav>

<div class="container-fluid" style="margin-left: 125px; margin-top: 100px;">
    <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#" id="dashboardBtn">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                            Pedidos <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="ordersBtn">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-file"><path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"></path><polyline points="13 2 13 9 20 9"></polyline></svg>
                            Stock
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>


    <div class="container" style="width: 1440px;">
        <div class="row">
            <div class="col-md-4 order-md-2 mb-4">
                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span id="tituloArt" class="text-muted">Articulos</span>
                </h4>
                <ul class="list-group mb-3" id="listArticulos">
                </ul>
                <form id="formDispatch" action="Despacho" method="POST" style="display: none;">
                    <input type="hidden" name="action" value="UPDATE">
                    <button class="btn btn-info" type="submit">Despachar</button>
                </form>
            </div>
            <div class="col-md-8 order-md-1">
                <h4 class="mb-3">Lista de Pedidos</h4>
                <table class="table table-striped table-sm" id="pedidoList">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Fecha Solicitud</th>
                            <th>Estado</th>
                            <th>Cliente</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for(int index = 0 ; index <  pedidoDTOS.size() ; index++){
                            PedidoDTO pedido = pedidoDTOS.get(index);%>
                    <tr class="clickable-row" id="<%= pedido.getId()%>">
                        <td><%= pedido.getId()  %></td>
                        <td><%= pedido.getFechaSolicitudOrden() %></td>
                        <td><%= pedido.getEstado() %></td>
                        <td><%= pedido.getCliente().getNombre() + " " + pedido.getCliente().getApellido() %></td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/compra.css">
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.bundle.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/Chart.bundle.min.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/feather-logo.js'></script>

    <script>
        $('#pedidoList').on('click', '.clickable-row', function(event) {
            $('#listArticulos li').remove();
            $('#tituloArt span').html("Articulos");
            $(this).addClass('active').siblings().removeClass('active');
            $("#formDispatch").hide();
            $("#formDispatch button").html("Despachar");
            $.ajax({
                type: "GET",
                url: "/Despacho",
                data:"pedido=" + getRow(),
                success: function(pedido){
                    $('#tituloArt').prepend("Pedido " + getRow() + " - ");
                    $("#formDispatch button").append(" Pedido " + getRow());
                    $("#formDispatch").show();
                    pedido.items.forEach(item => $("#listArticulos").append('<li class="list-group-item d-flex justify-content-between lh-condensed"><div><h6 class="my-0">' + item.articulo.descripcion + '</h6><small class="text-muted">' + item.articulo.presentacion  +'</small></div><span class="text-muted">'+  item.cantidad  +'</span></li>'));}});
        });

        function getRow() {
            return $('table > tbody > tr.active').get(0).id;
        }

    </script>

</body>
</html>
