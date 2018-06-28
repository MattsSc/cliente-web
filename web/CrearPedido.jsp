<%@ page import="dtos.ClienteDTO" %>
<%@ page import="dtos.ArticuloDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="delegates.ArticuloDelegate" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/b.css">
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
    <div class="row-fluid">
        <form class="form-horizontal" action="CrearPedido" method="POST">
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
                            <select class="span3" name="product" id="product">
                                <option></option>
                                <%for(ArticuloDTO articuloDTO : articuloDTOList){%>
                                <option value="<%out.print(articuloDTO.getCodigo());%>"><%out.print(articuloDTO.getDescripcion());%></option>
                                <%}%>
                            </select>
                            <input type="number" id="cant" name="cant" placeholder="0" class="span2" required>
                            <input type="hidden" name="action" value="ADD">
                            <button class="btn btn-success">Agregar</button>
                        </div>
                    </div>
                <jsp:include page="Cart.jsp" flush="true" />
            </fieldset>
        </form>
    </div>
</div>
</body>
</html>