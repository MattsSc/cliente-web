import delegates.ClienteDelegate;
import dtos.ClienteDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer DNI = Integer.valueOf(request.getParameter("DNI"));
		ClienteDTO dada = ClienteDelegate.getInstance().obtenerCliente(DNI);

		if (dada != null){
			response.getWriter().print("El usuario existe");
		}else {
			response.getWriter().print("No existe el usuario");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	protected void dispatch(String strPage, HttpServletRequest objRequest, HttpServletResponse objResponse) throws ServletException, IOException
    {
        if (strPage != null)
        {
            RequestDispatcher objRequestDispatcher;
            objRequestDispatcher = objRequest.getRequestDispatcher(strPage);
            objRequestDispatcher.forward(objRequest, objResponse);
        }
    }
	
}
