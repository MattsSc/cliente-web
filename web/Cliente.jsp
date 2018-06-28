<%@ page import="java.util.List" %>
<%@ page import="dtos.PedidoDTO" %>
<%@ page import="delegates.PedidoDelegate" %>
<%@ page import="dtos.ClienteDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Clientes</title>
		<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/cliente.css">
		<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
		<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.js'></script>
		<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/Chart.bundle.min.js'></script>
		<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/cliente.js'></script>
	</head>
	<body style="background: whitesmoke;">
	<%
		ClienteDTO clienteDTO = (ClienteDTO) request.getSession().getAttribute("cliente");
		List<PedidoDTO> pedidos = PedidoDelegate.getInstance().obtenerPedidosPorCliente(clienteDTO.getDni());
	%>
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
			<div class="container-fluid">
				<div class="row">
					<div class="col">
						<div class="card">
							<div class="card-body">
								<h5 class="card-title">Bienvenido <%= clienteDTO.getNombre() + " " + clienteDTO.getApellido() %></h5>
								<h6 class="card-subtitle mb-2 text-muted">Tus datos personales</h6>
								<p class="card-text">
									DNI: <%= clienteDTO.getDni()%><br>
									Razon Social: <%= clienteDTO.getRazonSocial()%><br>
									Cuit: <%= clienteDTO.getCuit()%><br>
									Domicilio<%= clienteDTO.getDomicilio()%><br>
									<strong>
										Limite Credito: $<%= clienteDTO.getLimiteCredito()%><br>
										Monto Disponible: $<%= clienteDTO.getMontoDisponible()%><br>
									</strong>
									<br>
								</p>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card">
							<div class="card-body">
								<h5 class="card-title">Pedidos</h5>
								<h6 class="card-subtitle mb-2 text-muted">Vea el estado de sus pedidos!</h6>
								<p class="card-text">Si tiene alguna pregunta o desea comunicarse con nosotros, llamenos al : 0-800-NOIMPORTA.</p>
								<canvas id="myChart" style="max-width: 500px;"></canvas>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<div class="card">
							<div class="card-body">
								<h5 class="card-title">Card title</h5>
								<table class="table">
									<thead>
									<tr>
										<th scope="col">#</th>
										<th scope="col">First</th>
										<th scope="col">Last</th>
										<th scope="col">Handle</th>
									</tr>
									</thead>
									<tbody>
									<tr>
										<th scope="row">1</th>
										<td>Mark</td>
										<td>Otto</td>
										<td>@mdo</td>
									</tr>
									<tr>
										<th scope="row">2</th>
										<td>Jacob</td>
										<td>Thornton</td>
										<td>@fat</td>
									</tr>
									<tr>
										<th scope="row">3</th>
										<td>Larry</td>
										<td>the Bird</td>
										<td>@twitter</td>
									</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card">
							<div class="card-body">
								<h5 class="card-title">Pedidos </h5>
								<table class="table">
									<thead>
									<tr>
										<th scope="col">Fecha Solicitud</th>
										<th scope="col">Estado</th>
										<th scope="col">Fecha Entrega</th>
									</tr>
									</thead>
									<tbody>
                                    <%
                                        for(int index = 0 ; index <  pedidos.size() ; index++){
                                            PedidoDTO pedido = pedidos.get(index);%>
                                        <tr>
                                            <td><%= pedido.getFechaSolicitudOrden() %></td>
                                            <td><%= pedido.getEstado() %></td>
                                            <td><%= pedido.getFechaEntrega() != null ? pedido.getFechaEntrega() : "-" %></td>
                                        </tr>
                                    <%}%>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>