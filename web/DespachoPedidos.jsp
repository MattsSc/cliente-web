<%@ page import="dtos.PedidoDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="delegates.PedidoDelegate" %>
<%@ page import="dtos.ItemAProcesarDTO" %><%--
  Created by IntelliJ IDEA.
  User: matias.scandroglio
  Date: 30/06/2018
  Time: 19:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<%
    List<PedidoDTO> pedidoDTOS = PedidoDelegate.getInstance().listarPedidos("DESPACHABLE");
    List<ItemAProcesarDTO> items = (List<ItemAProcesarDTO>) request.getSession().getAttribute("itemsProc");
    if(items != null){%>
        <div id="modal" class="modal fade show" tabindex="-1" role="dialog" style="display:block;">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Retirar Deposito</h5>
                    </div>
                    <div class="modal-body">
                        <div class="list-group">
                            <% for(ItemAProcesarDTO item : items){%>
                            <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                                <div class="d-flex w-100 justify-content-between">
                                    <h5 class="mb-1"><%= item.getArticuloDescripcion() %></h5>
                                    <small><%= "Cantidad: " + item.getCantidad() %></small>
                                </div>
                                <p class="mb-1"><%="Ubicaciones: " +  item.getUbicaciones() %></p>
                            </a>
                            <%}%>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="hideModal()">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
<%request.getSession().setAttribute("itemsProc", null);
}%>


    <div class="container" style="width: 1440px;">
        <div class="row">
            <div class="col-md-4 order-md-2 mb-4">
                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span id="tituloArt" class="text-muted">Articulos</span>
                </h4>
                <ul class="list-group mb-3" id="listArticulos">
                </ul>
                <form id="formDispatch" action="Despacho" method="POST" style="display: none;">
                    <div class="col-md-4 mb-3">
                        <label for="factura">Factura</label>
                        <select class="custom-select d-block" style="width: 115px;" name="factura" id="factura" required="">
                            <option value="">Elije...</option>
                            <option value="A">Factura A</option>
                            <option value="B">Factura B</option>
                        </select>
                    </div>
                    <input type="hidden" name="action" value="UPDATE">
                    <button class="btn btn-info" type="submit">Despachar</button>
                </form>
            </div>
            <div class="col-md-8 order-md-1">
                <h4 class="mb-3">Lista de Pedidos</h4>
                <table class="table table-hover" id="pedidoList">
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


    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/compra.css">
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.bundle.js'></script>
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/Chart.bundle.min.js'></script>
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/feather-logo.js'></script>


<script>
    $('#pedidoList').on('click', '.clickable-row', function(event) {
        $('#listArticulos li').remove();
        $('#tituloArt').html("Articulos");
        $(this).addClass('table-primary').siblings().removeClass('table-primary');
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
        return $('table > tbody > tr.table-primary').get(0).id;
    }

    function hideModal() {
        $("#modal").hide();
    }

</script>

</body>
</html>
