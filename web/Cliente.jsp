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
		<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
		<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.js'></script>
	</head>
	<body class="container" style="background: whitesmoke;">
	<%
		ClienteDTO clienteDTO = (ClienteDTO) request.getSession().getAttribute("cliente");
		List<PedidoDTO> pedidos = PedidoDelegate.getInstance().obtenerPedidosPorCliente(clienteDTO.getDni());
	%>
	<%if(request.getSession().getAttribute("pedidoId") != null){ %>
		<div class="alert alert-success" role="alert">
			<h4 class="alert-heading">Gracias!</h4>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<p>El pedido ha sido recibido, Su numero de pedido es <strong> <%= request.getSession().getAttribute("pedidoId") %> </strong>. </p>
			<hr>
			<p class="mb-0">Si tiene alguna duda o consulta comuniquese al 0-800-NOIMPORTA.</p>
		</div>
		<% request.getSession().setAttribute("pedidoId", null); ;} %>

		<div class="container">
			<div class="col-sm-8 left">
				<table class="table">
					<thead class="thead-dark">
					<tr>
						<th scope="col">#</th>
						<th scope="col">Fecha Solicitud</th>
						<th scope="col">Fecha Despacho</th>
						<th scope="col">Estado</th>
						<th scope="col">Aclaracion</th>
                        <th scope="col">Fecha Entrega</th>
					</tr>
					</thead>
					<tbody>
					<%
						for(int index = 0 ; index <  pedidos.size() ; index++){
						PedidoDTO pedido = pedidos.get(index);%>
					<tr>
						<td><%= index+1%></td>
						<td><%= pedido.getFechaSolicitudOrden() %></td>
                        <td><%= pedido.getFechaDespacho()%></td>
						<td><%= pedido.getEstado() %></td>
						<td><%= pedido.getAclaracion() %></td>
                        <td><%= pedido.getFechaEntrega() %></td>
					</tr>
					<%}%>
					</tbody>
				</table>
			</div>
			<div class="col-sm-4 newsletter">
				newsletter section
			</div>
		</div>
	</body>
</html>