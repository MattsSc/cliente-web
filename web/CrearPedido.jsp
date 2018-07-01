<%@ page import="dtos.ClienteDTO" %>
<%@ page import="dtos.ArticuloDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="delegates.ArticuloDelegate" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/cliente.css">
    <link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/font-awesome-all.css">
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.js'></script>
    <script type='text/javascript' src='./bootstrap-4.1.1-dist/js/font-awesome-all.js'></script>
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

                    <form>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="inputEmail4">Nombre</label>
                                <input type="text" class="form-control" id="inputEmail4" value="<%= clienteDTO.getNombre() %>" disabled>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="inputPassword4">Apellido</label>
                                <input type="text" class="form-control" id="inputPassword4" value="<%= clienteDTO.getApellido() %>" disabled>
                            </div>
                        </div>
                    </form>

                    <br/>
                    <h4>Agregar Articulos</h4>
                        <form action="CrearPedido" method="POST">
                            <div class="form-row">
                                <div class="col-7">
                                    <select class="custom-select d-block w-100" name="product" id="product" required>
                                        <option value="">Elige Articulo...</option>
                                        <%for(ArticuloDTO articuloDTO : articuloDTOList){%>
                                        <option value="<%out.print(articuloDTO.getCodigo());%>"><%out.print(articuloDTO.getDescripcion());%></option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="col">
                                    <input type="number" id="cant" name="cant" placeholder="0" class="form-control" min="0" required>
                                    <input type="hidden" name="action" value="ADD">
                                </div>
                                <div class="col">
                                    <button class="btn btn-info">Agregar <i class="fas fa-cart-plus"></i></button>
                                </div>
                            </div>
                        </form>
                </fieldset>
                <br/>
                <br/>
                <jsp:include page="Cart.jsp" flush="true" />
            </div>
        </div>
    </div>
</div>
</body>
</html>