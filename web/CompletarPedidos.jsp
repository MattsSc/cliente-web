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
    List<PedidoDTO> pedidoDTOS = PedidoDelegate.getInstance().listarPedidos("DESPACHO");
%>

<div class="container" style="width: 1440px;">
    <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span id="cerrarPed" class="text-muted">Cerrar Pedido</span>
            </h4>
            <form id="formCompletar" action="Despacho" method="POST" style="display: none;">
                <div class="col-md-12">
                    <label for="fechaEntrega">Fecha Entrega</label>
                    <input id="fechaEntrega" type="date" value="" name="fechaEntrega">
                </div>
                <input type="hidden" name="action" value="COMPLETE">
                <button class="btn btn-info" type="submit" style="margin-top: 15px;margin-left: 30%;">Completar</button>
            </form>
        </div>
        <div class="col-md-8 order-md-1">
            <h4 class="mb-3">Lista de Pedidos</h4>
            <table class="table table-hover" id="pedidoCompList">
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
    $('#pedidoCompList').on('click', '.clickable-row', function(event) {
        $('#cerrarPed').html("Cerrar Pedido");
        $(this).addClass('table-primary').siblings().removeClass('table-primary');
        $("#formCompletar").hide();
        $("#formCompletar button").html("Completar");
        $.ajax({
            type: "GET",
            url: "/Despacho",
            data: "pedido=" + getRow(),
            success: function () {
                $('#cerrarPed').append(" " + getRow());
                $("#formCompletar").show();
            }
        });
    });

    function getRow() {
        return $('table > tbody > tr.table-primary').get(0).id;
    }

</script>

</body>
</html>
