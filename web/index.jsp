<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/bootstrap.css">
	<link rel="stylesheet" href="./bootstrap-4.1.1-dist/css/signin.css">
	<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/jquery.js'></script>
	<script type='text/javascript' src='./bootstrap-4.1.1-dist/js/bootstrap.js'></script>
	<body class="text-center">
		<form class="form-signin" action="Login" method="POST">
			<h1 class="h3 mb-3">Please Sign In </h1>
            <%
                if(request.getSession().getAttribute("error") != null){ %>
                <div class="alert alert-danger" role="alert">
                    <strong>Oh snap!</strong> The client does not exist.
                </div>
            <% } %>
			<label for="input" class="sr-only">D.N.I.</label>
			<input type="text" id="input" class="form-control" name="dni" placeholder="DNI" required="" autofocus="" onblur="validate()">
			<button class="btn btn-success btn-lg btn-block" type="submit">Sign In</button>
			<p class="mt-5 mb-3">TP AD Grupo 2 º 2017-2018 Associated with Anonymous</p>
		</form>


		<script>
			function validate(){
                $("#input").get(0).setCustomValidity("");
			    var value = $("#input").val();
			   if(value != ""  && (value == "COMPRA" || isNumber(value))){
                   $("#input").get(0).setCustomValidity("");
			   }else{
                   $("#input").get(0).setCustomValidity("Solo nùmeros.");
			   }
			}

            function isNumber(n) {
                return !isNaN(parseFloat(n)) && isFinite(n);
            }
		</script>
	</body>
</html>