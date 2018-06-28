import delegates.ClienteDelegate;
import dtos.ClienteDTO;
import exceptions.ClienteNotFoundException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.rmi.RemoteException;


@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.getSession().setAttribute("error", null);
			Integer DNI = Integer.valueOf(request.getParameter("dni"));
			ClienteDTO dada = ClienteDelegate.getInstance().obtenerCliente(DNI);
			request.getSession().setAttribute("cliente", dada);
			request.getRequestDispatcher("/Cliente.jsp").forward(request, response);
		} catch (RemoteException e) {
			request.getSession().setAttribute("error", "show this motha");
			request.getRequestDispatcher("/").forward(request, response);
		}
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
