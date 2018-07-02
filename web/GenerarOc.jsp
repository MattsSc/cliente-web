<%@ page import="delegates.ArticuloDelegate" %>
<%@ page import="dtos.ProveedorDTO" %>
<%@ page import="delegates.CompraDelegate" %>
<%@ page import="java.util.List" %>
<%@ page import="dtos.ArticuloDTO" %><%--
  Created by IntelliJ IDEA.
  User: matias.scandroglio
  Date: 29/06/2018
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body class="bg-light">
<%
    List<ArticuloDTO> articuloDTOS = ArticuloDelegate.getInstance().obtenerArticulosFaltantes();
    List<ProveedorDTO> proveedorDTOS = CompraDelegate.getInstance().obtenerProveedores();
    request.getSession().setAttribute("articulos", articuloDTOS);
    request.getSession().setAttribute("proveedores", proveedorDTOS);
%>
<div class="container" style="width: 1440px;">
    <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-muted">Proveedores</span>
            </h4>
            <ul class="list-group mb-3" id="proveedores">
            </ul>
        </div>
        <div class="col-md-8 order-md-1">
            <h4 class="mb-3">Generar Orden de Compra</h4>
            <form id="generarOcForm" action="Compra" method="POST">
                <div class="col-md-4 mb-3">
                    <label for="product">Articulo</label>
                    <select class="custom-select d-block w-100" name="product" id="product" required="">
                        <option value="">Elije...</option>
                        <%for(ArticuloDTO articuloDTO : articuloDTOS){%>
                            <option value="<%= articuloDTO.getCodigo() %>"><%= articuloDTO.getDescripcion() %></option>
                        <%}%>
                    </select>
                </div>

                <div class="col-md-4 mb-3">
                    <label for="proveedor">Proveedores</label>
                    <select class="custom-select d-block w-100" name="proveedor" id="proveedor" required="">
                        <option value="">Elije...</option>
                        <%for(ProveedorDTO proveedorDTO : proveedorDTOS){%>
                        <option value="<%= proveedorDTO.getId() %>"><%= proveedorDTO.getNombre() %></option>
                        <%}%>
                    </select>
                </div>
                <hr class="mb-4">
                <%
                    if(request.getAttribute("errorForm") != null){ %>
                    <div class="alert alert-danger" role="alert">
                        <strong>Oh snap!</strong> <%= request.getAttribute("errorForm")%>.
                    </div>
                <%request.setAttribute("errorForm", null); } %>
                <input type="hidden" name="action" value="CREATE">
                <button class="btn btn-success" type="submit">Generar</button>
            </form>
            <form id="AsignarOcForm" action="Compra" method="POST">
                <input type="hidden" name="action" value="UPDATE">
                <button class="btn btn-info" type="submit">Asignar OCs</button>
            </form>
        </div>
    </div>

<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/compra.css">
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.bundle.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/Chart.bundle.min.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/feather-logo.js'></script>

<script>
    $('#product').change(function() {
        $('#proveedores li').remove();
        $.ajax({
            type: "GET",
            url: "/Compra",
            data:"product=" + $('#product option:selected').val(),
            success: function(proveedores){
                proveedores.forEach(prov => $("#proveedores").append('<li class="list-group-item d-flex justify-content-between lh-condensed"><div><h6 class="my-0">' + prov.proveedorDTO.nombre + '</h6><small class="text-muted">' + prov.proveedorDTO.cuit  +'</small></div><span class="text-muted">$'+  prov.total  +'</span></li>'));}});
    });

    $("#AsignarOcForm").submit(function(){
        alert("Se ha intentado asignar Ordenes de compra abiertas a las ordenes de pedido.");
    });

    $("#generarOcForm").submit(function(){
        alert("Se ha generado la Orden de compra!.");
    });

</script>


</body>
</html>
