<%@ page import="dtos.OrdenDeCompraDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="delegates.CompraDelegate" %><%--
  Created by IntelliJ IDEA.
  User: matias.scandroglio
  Date: 29/06/2018
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<%
    List<OrdenDeCompraDTO> ordenDeCompraDTOS = CompraDelegate.getInstance().obtenerTodasLasOrdenes();
%>
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">

    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Dashboard</h1>
    </div>

    <canvas class="my-4 w-100 chartjs-render-monitor" id="myChart" width="2304" height="972" style="display: block; height: 486px; width: 1152px;"></canvas>

    <h2>Ordenes de Compra Emitidas</h2>
    <div class="table-responsive">
        <table class="table table-striped table-sm">
            <thead>
            <tr>
                <th>Id</th>
                <th>Fecha Emision</th>
                <th>Articulo</th>
                <th>Estado</th>
                <th>Proveedor</th>
                <th>Precio</th>
            </tr>
            </thead>
            <tbody>
            <%
                for(int index = 0 ; index <  ordenDeCompraDTOS.size() ; index++){
                    OrdenDeCompraDTO oc = ordenDeCompraDTOS.get(index);%>
            <tr>
                <td><%= oc.getId()  %></td>
                <td><%= oc.getFechaEmision() %></td>
                <td><%= oc.getArticulo().getDescripcion() %></td>
                <td><%= oc.isResuelto() ? "COMPLETO" : "ENVIADA" %></td>
                <td><%= oc.getProovedor().getNombre() %></td>
                <td><%= oc.getPrecio() > 0f ? "$" + oc.getPrecio() : "-" %></td>
            </tr>
            <%}%>
            </tbody>
        </table>
    </div>
</main>

<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/compra.css">
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.bundle.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/Chart.bundle.min.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/feather-logo.js'></script>

<script>

    $(window).on("load", new function(){
        if($("#dashboard").is(":visible")) {
            console.log("HOLAAAA");
            GetAllPedidos();
        }
    });

    function GetAllPedidos(){
        $.ajax({
            type: "GET",
            url: "/Compra",
            success: function(ocs){
                var month = new Date().getMonth();
                var actualMonth = ocs.filter(oc => new Date(oc.fechaEmision).getMonth() == month).length;
                var prevMonth = ocs.filter(oc => new Date(oc.fechaEmision).getMonth() == (month-1)).length;
                var prevPrevMonth = ocs.filter(oc => new Date(oc.fechaEmision).getMonth() == (month-2)).length;
                var ctx = document.getElementById("myChart").getContext('2d');
                var myChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: [getMonthName(month-2), getMonthName(month-1), getMonthName(month)],
                        datasets: [{
                            data: [prevPrevMonth, prevMonth, actualMonth],
                            lineTension: 0,
                            backgroundColor: 'transparent',
                            borderColor: '#96ff52',
                            borderWidth: 4,
                            pointBackgroundColor: '#96ff52'
                        }]
                    },
                    options: {
                        scales: {
                            yAxes: [{
                                scaleLabel: {
                                    display: true,
                                    labelString: '# de Ordenes De Compra'
                                },
                                ticks: {
                                    beginAtZero: false,
                                    stepSize: 1
                                }
                            }]
                        }
                    }
                });
            }
        });
    }

    function getMonthName(indice){
        var month = new Array();
        month[0] = "Enero";
        month[1] = "Febrero";
        month[2] = "Marzo";
        month[3] = "Abril";
        month[4] = "Mayo";
        month[5] = "Junio";
        month[6] = "Julio";
        month[7] = "Agosto";
        month[8] = "Septiembre";
        month[9] = "Octubre";
        month[10] = "Noviembre";
        month[11] = "Diciembre";
        return month[indice];
    }

</script>


</body>
</html>
