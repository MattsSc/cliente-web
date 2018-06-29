<%@ page import="dtos.ClienteDTO" %>
<%@ page import="dtos.ArticuloDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="delegates.ArticuloDelegate" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/b.css">
    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/cliente.css">
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.js'></script>
</head>
<body style="background: gainsboro;">
<%
    ClienteDTO clienteDTO = (ClienteDTO) request.getSession().getAttribute("cliente");
    String nombre = clienteDTO.getNombre() + " " + clienteDTO.getApellido();
    List<ArticuloDTO> articuloDTOList = ArticuloDelegate.getInstance().obtenerArticulos();
%>

<div class="container" style="background: whitesmoke;">
    <div id="wrapper" class="animate">
        <nav class="navbar header-top fixed-top navbar-expand-lg  navbar-dark bg-dark">
            <a class="navbar-brand" href="#">Tp AD - Grupo 2</a>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav ml-md-auto d-md-flex">
                    <li class="nav-item">
                        <a class="nav-link" href="/Cliente.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/CrearPedido.jsp">Crear Pedido</a>
                    </li>
                    <li class="nav-item">
                        <form action="/Cliente" method="POST">
                            <input type="hidden" name= "logout" value='LOGOUT'>
                            <button class="nav-link" style="border: transparent; background: transparent">Salir</button>
                        </form>
                    </li>
                </ul>
            </div>
        </nav>
        <div class="row-fluid">
            <div class="form-horizontal" >
                <fieldset>
                    <div id="legend">
                        <legend class="">Crear Pedido</legend>
                    </div>

                    <!-- Name -->
                    <div class="control-group">
                        <label class="control-label" for="username">Nombre</label>
                        <div class="controls">
                            <input type="text" id="username" name="username" value="<% out.print(nombre); %>" class="span3" disabled>
                        </div>
                    </div>

                    <!-- Card Number -->
                    <div class="control-group">
                        <label class="control-label" for="dni">DNI</label>
                        <div class="controls">
                            <input type="text" id="dni" name="dni" value="<% out.print(clienteDTO.getDni());%>" class="span3" disabled>
                        </div>
                    </div>

                    <!-- CVV -->
                    <div class="control-group">
                        <label class="control-label" for="razon_social">Razon Social</label>
                        <div class="controls">
                            <input type="text" id="razon_social" name="razon_social" value="<% out.print(clienteDTO.getRazonSocial());%>" class="span3" disabled>
                        </div>
                    </div>

                    <br/>
                    <h4>Agregar Articulos</h4>
                        <div class="control-group">
                        <label class="control-label" for="product">Producto</label>
                            <div class="controls">
                                <form action="CrearPedido" method="POST">
                                    <select class="span3" name="product" id="product">
                                        <option></option>
                                        <%for(ArticuloDTO articuloDTO : articuloDTOList){%>
                                        <option value="<%out.print(articuloDTO.getCodigo());%>"><%out.print(articuloDTO.getDescripcion());%></option>
                                        <%}%>
                                    </select>
                                    <input type="number" id="cant" name="cant" placeholder="0" class="span2" required>
                                    <input type="hidden" name="action" value="ADD">
                                    <button class="btn btn-success">Agregar</button>
                                </form>
                            </div>
                        </div>
                    <jsp:include page="Cart.jsp" flush="true" />
                </fieldset>
            </div>
        </div>
    </div>
</div>
</body>
</html>