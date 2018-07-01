<%--
  Created by IntelliJ IDEA.
  User: matias.scandroglio
  Date: 30/06/2018
  Time: 02:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>

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
                        <a class="nav-link active" href="#" id="pedidosBtn" style="font-size: 20px;">
                            <i class="far fa-newspaper"></i>
                            Despacha Pedido
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="pedidosCompletarBtn" style="font-size: 20px;">
                            <i class="far fa-newspaper"></i>
                            Completar Pedido
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="stockBtn"  style="font-size: 20px;">
                            <i class="fas fa-database"></i>
                            Stock
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>


    <div id="despachoPedido">
        <jsp:include page="DespachoPedidos.jsp"/>
    </div>

    <div id="despachoCompletar" style="display: none;">
        <jsp:include page="CompletarPedidos.jsp"/>
    </div>

</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/compra.css">
<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/font-awesome-all.css">
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.bundle.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/Chart.bundle.min.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/font-awesome-all.js'></script>

    <script>
        $(document).ready(function(){
            $("#pedidosBtn").click(function(){
                showDespachar();
                ocultarCompletar();
            });
            $("#pedidosCompletarBtn").click(function(){
                showCompletar();
                ocultarDespachar();
            });
            $("#stockBtn").click(function(){

            });
        });

        function showCompletar() {
            $("#despachoCompletar").show();
            $("#pedidosCompletarBtn").addClass("active");
        }

        function ocultarCompletar() {
            $("#despachoCompletar").hide();
            $("#pedidosCompletarBtn").removeClass("active");
        }

        function showDespachar() {
            $("#despachoPedido").show();
            $("#pedidosBtn").addClass("active");
        }

        function ocultarDespachar() {
            $("#despachoPedido").hide();
            $("#pedidosBtn").removeClass("active");
        }

    </script>

</body>
</html>
