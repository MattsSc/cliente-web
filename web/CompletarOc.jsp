<%@ page import="utils.SessionVars" %><%--
  Created by IntelliJ IDEA.
  User: matias.scandroglio
  Date: 01/07/2018
  Time: 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body class="container" style="width: 1440px;">
    <h2>Buscar Orden de Compra</h2>
    <div class="row">
        <div name="buscarOc" style="width: 50%; margin: 25px auto;">
            <div class="form-row">
                <div id="error-msg" class="alert alert-warning col-9" role="alert" style="display: none;">
                </div>
                <div class="col-7">
                    <input id="orderOc" type="numer" min="0" step="1" class="form-control" placeholder="Id de Orden de Compra" name="orderOc">
                </div>
                <div class="col">
                    <button type="submit" class="btn btn-info" onclick="buscarOc()">Buscar</button>
                </div>
            </div>
        </div>
    </div>
    <br/>
    <h2 id="datosTitle" style="display: none;">Datos</h2>
    <div id="show-info" style="display: none;">
        <h4 id="art-info" class="card-title pricing-card-title text-muted" style="width: 50%; margin: 5px auto;">Articulo: <small></small></h4>
        <h4 id="cant-info" class="card-title pricing-card-title text-muted" style="width: 50%; margin: 5px auto;">Cantidad: <small>}</small></h4>
        <h4 id="prov-info" class="card-title pricing-card-title text-muted" style="width: 50%; margin: 5px auto;">Proveedor: <small></small></h4>
        <h4 id="est-info" class="card-title pricing-card-title text-muted" style="width: 50%; margin: 5px auto;">Estado: <small></small></h4>
    </div>
    <br/>
    <h2 id="closeFormTitle" style="display: none;">Cerrar</h2>
    <form id="closeForm" class="form-row" action="OrdenCompra" method="POST" style="width: 75%; margin: 25px auto; display: none;">
        <div class="col-6">
            <input id="fechaVenc" type="date" class="form-control" placeholder="Fecha Vencimiento Lote" name="fechaVenc" required>
        </div>
        <div class="col-4">
            <input id="precio" type="number" min="0"  class="form-control" placeholder="Precio Orden($)" name="precio" required>
        </div>
        <div class="col">
            <input type="hidden" name="action" value="CLOSE">
            <input type="hidden" id="ocId" name="ocId" value="">
            <button type="submit" class="btn btn-success">Cerrar Oc</button>
        </div>
    </form>


<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/compra.css">
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.bundle.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/Chart.bundle.min.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/feather-logo.js'></script>

<script>
    function buscarOc() {
        $("#art-info small").html("");
        $("#prov-info small").html("");
        $("#cant-info small").html("");
        $("#est-info small").html("");
        $("#show-info").hide();
        $("#error-msg").html("");
        $("#error-msg").hide();
        $("#closeForm").hide();
        $("#datosTitle").hide();
        $("#closeFormTitle").hide();
        var ocId = $("#orderOc").val();
        if(ocId && isNumber(ocId))
            doCall(ocId);
        else{
            $("#error-msg").append('<strong>Por favor</strong>, ingrese solo nùmeros.');
            $("#error-msg").show();
        }
    }

    function isNumber(n) {
        return !isNaN(parseFloat(n)) && isFinite(n);
    }

    function doCall(ocId) {
        $.ajax({
            type: "GET",
            url: "/OrdenCompra",
            data: "orderOc=" + ocId,
            success: function (oc) {
                $("#ocId").val(ocId);
                $("#art-info small").append(oc.articulo.descripcion);
                $("#prov-info small").append(oc.proovedor.nombre);
                $("#cant-info small").append(oc.cantidad);
                $("#est-info small").append(oc.resuelto ? "COMPLETA" : "ENVIADA");
                $("#show-info").show();
                $("#datosTitle").show();
                if(!oc.resuelto){
                    $("#closeForm").show();
                    $("#closeFormTitle").show();
                }
            },
            error: function(error){
                $("#error-msg").append('<strong>Lo siento</strong>, la orden de compra no existe.');
                $("#error-msg").show();
            }
        });
    }
</script>


</body>
</html>
