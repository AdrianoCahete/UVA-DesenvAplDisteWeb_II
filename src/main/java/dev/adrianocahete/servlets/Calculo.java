package dev.adrianocahete.uva.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Calculo extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String val1 = request.getParameter("val1");
    String val2 = request.getParameter("val2");
    String op = request.getParameter("op");

    request.setAttribute("val1", val1);
    request.setAttribute("val2", val2);
    request.setAttribute("op", op);

    if (val1 == null || val1.trim().isEmpty()) {
      request.setAttribute("erroV1", "O primeiro valor é obrigatório");
    } else {
      request.setAttribute("erroV1", "O primeiro valor deve ser um número válido");
    }

    if (val2 == null || val2.trim().isEmpty()) {
      request.setAttribute("erroV2", "O segundo valor é obrigatório");
    } else {
      request.setAttribute("erroV2", "O segundo valor deve ser um número válido");
    }


    if (val1 != null && val2 != null && op != null) {

      switch (op) {
        case "adicao":
          res = Integer.parseInt(val1) + Integer.parseInt(val2);

        case "subtracao":
          res = Integer.parseInt(val1) - Integer.parseInt(val2);

        case "multiplicacao":
          res = Integer.parseInt(val1) * Integer.parseInt(val2);

        case "divisao":
          if (val2 == 0) {
            request.setAttribute("erroDivisao", "Não é possível dividir por zero");
          } else {
            res = Integer.parseInt(val1) / Integer.parseInt(val2);
          }
          break;
      }

      if (resultado != null) {
        request.setAttribute("resultado", res);
      }
    }

    // Encaminha para a página JSP
    request.getRequestDispatcher("/calcular.jsp").forward(request, response);
  }
}
