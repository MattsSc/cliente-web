<%--
  Created by IntelliJ IDEA.
  User: matias.scandroglio
  Date: 29/06/2018
  Time: 02:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">TP ADO - Grupo 2</a>
    <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
            <a class="nav-link" href="/">Salir</a>
        </li>
    </ul>
</nav>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#" id="dashboardBtn">
                            <i class="fas fa-tachometer-alt"></i>Dashboard <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="ordersBtn">
                            <i class="fas fa-archive"></i>Ordenes de Pedido
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        <div id="dashboard">
            <jsp:include page="Dashboard.jsp"/>
        </div>
        <div id="ordenesPedido" style="display: none;" >
            <jsp:include page="OrdenesPedido.jsp"/>
        </div>
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
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/feather-logo.js'></script>
<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/font-awesome-all.js'></script>

<!-- Icons -->
<script>
    feather.replace()
</script>

<script>
    $(document).ready(function(){
        $("#dashboardBtn").click(function(){
            $("#dashboard").show();
            $("#dashboardBtn").addClass("active");

            $("#ordenesPedido").hide();
            $("#ordersBtn").removeClass("active");
        });
        $("#ordersBtn").click(function(){
            $("#ordenesPedido").show();
            $("#ordersBtn").addClass("active");

            $("#dashboard").hide();
            $("#dashboardBtn").removeClass("active");
        });
    });
</script>

<!-- Graphs -->

</body>
</html>
