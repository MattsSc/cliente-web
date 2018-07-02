<%@ page import="dtos.ArticuloDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="delegates.ArticuloDelegate" %><%--
  Created by IntelliJ IDEA.
  User: matias.scandroglio
  Date: 02/07/2018
  Time: 00:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body class="container" style="width: 1440px;">
<%
    List<ArticuloDTO> articuloDTOList = ArticuloDelegate.getInstance().obtenerArticulos();
%>
<h2>Ajuste de Stock</h2>
    <div class="row">
        <div name="buscarLoc" style="width: 50%; margin: 25px auto;">
            <div class="form-row">
                <div class="col-7">
                    <select class="custom-select d-block w-100" name="productLoc" id="productLoc" required>
                        <option value="">Elige Articulo...</option>
                        <%for(ArticuloDTO articuloDTO : articuloDTOList){%>
                            <option value="<%= articuloDTO.getCodigo() %>"><%= articuloDTO.getDescripcion()%></option>
                        <%}%>
                    </select>
                </div>
            </div>
        </div>
    </div>
    <div id="ubicaciones" style="width: 50%; margin: 25px auto; display: none;">
        <div class="form-row">
            <div class="col-7">
                <label>Ubicaciòn</label>
                <select class="custom-select d-block w-100" name="ubi" id="ubi" required>
                </select>
            </div>
        </div>
    </div>
    <form id="motivo" action="Articulo" method="POST" style="width: 50%; margin: 25px auto; display: none;">
        <div class="form-row">
            <div class="col-7">
                <label>Motivos</label>
                <select class="custom-select d-block w-100" name="mot" id="mot" required>
                    <option value=""> Elije...</option>
                    <option value="ROTURA">Rotura</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="encargado">Encargado</label>
            <input type="text" class="form-control" id="encargado" name="encargado" aria-describedby="emailHelp" placeholder="Encargado" required>
            <small id="emailHelp" class="form-text text-muted">Encargado a la hora del incidente.</small>
        </div>
        <div class="form-group">
            <label for="destino">Destino</label>
            <input type="text" class="form-control" id="destino"  name="destino" placeholder="Destino" aria-describedby="destHelp">
            <small id="destHelp" class="form-text text-muted">Donde va a ir la mercaderia dañada.</small>
        </div>
        <div class="form-group">
            <label for="autorizador">Autorizador</label>
            <input type="text" class="form-control" id="autorizador"  name="autorizador" placeholder="Autorizador">
        </div>
        <div class="form-group" id="cantRotaDiv">
            <label for="cantRota">Cantidad Dañada:</label>
            <input type="number" class="form-control" id="cantRota"  name="cantRota" placeholder="Cantidad dañada" min="0" step="1" required>
        </div>
        <input type="text" class="form-control" id="ubicacionText" name="ubicacionText" hidden>
        <input type="text" class="form-control" id="loteIdRoto" name="loteIdRoto" hidden>
        <button type="submit" class="btn btn-primary">Notificar</button>
    </form>


<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/compra.css">
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.bundle.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/Chart.bundle.min.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/feather-logo.js'></script>

<script>
    $('#productLoc').change(function() {
        $("#ubicaciones").hide();
        $("#ubicaciones option").remove();
        $("#motivo").hide();
        $("#ubicacionText").val("");
        $("#loteIdRoto").val("");
        $.ajax({
            type: "GET",
            url: "/Articulo",
            data:"articulo=" + $('#productLoc option:selected').val(),
            success: function(ubicaciones) {
                $("#ubicaciones").show();
                $("#ubi").append('<option value="">Elije...</option>');
                ubicaciones.forEach(ubi => $("#ubi").append(' <option value="' + ubi.lote.id + '">' + ubi.clave  + '</option>'));
            }
        });
   });

    $('#ubi').change(function() {
        $("#motivo").show();
        $("#ubicacionText").val($('#ubi option:selected').text());
        $("#loteIdRoto").val($('#ubi option:selected').val());
    });

    $("#motivo").submit(function(){
        alert("Gracias por notificar la rotura!");
    });


</script>


</body>
</html>
