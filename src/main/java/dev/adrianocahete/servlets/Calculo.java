package dev.adrianocahete.servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Calculo extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String val1Str = request.getParameter("val1");
    String val2Str = request.getParameter("val2");
    String op = request.getParameter("op");

    request.setAttribute("val1", val1Str);
    request.setAttribute("val2", val2Str);
    request.setAttribute("op", op);

    boolean hasError = false;
    Float val1 = null;
    Float val2 = null;

    if (val1Str == null || val1Str.trim().isEmpty()) {
      request.setAttribute("erroV1", "O primeiro valor é obrigatório");
      hasError = true;
    } else {
      try {
        val1 = Float.parseFloat(val1Str);
      } catch (NumberFormatException e) {
        request.setAttribute("erroV1", "O primeiro valor deve ser um número válido");
        hasError = true;
      }
    }

    if (val2Str == null || val2Str.trim().isEmpty()) {
      request.setAttribute("erroV2", "O segundo valor é obrigatório");
      hasError = true;
    } else {
      try {
        val2 = Float.parseFloat(val2Str);
      } catch (NumberFormatException e) {
        request.setAttribute("erroV2", "O segundo valor deve ser um número válido");
        hasError = true;
      }
    }

    // Se não houver erros nos valores, realiza o cálculo
    if (!hasError && val1 != null && val2 != null && op != null && !op.isEmpty()) {
      Float res = null;
      String expressao = "";

      switch (op) {
        case "adicao":
          res = val1 + val2;
          expressao = val1 + " + " + val2 + " = " + res;
          break;

        case "subtracao":
          res = val1 - val2;
          expressao = val1 + " - " + val2 + " = " + res;
          break;

        case "multiplicacao":
          res = val1 * val2;
          expressao = val1 + " x " + val2 + " = " + res;
          break;

        case "divisao":
          if (val2 == 0) {
            request.setAttribute("erroDivisao", "Não é possível dividir por zero");
            hasError = true;
          } else {
            res = val1 / val2;
            expressao = val1 + " / " + val2 + " = " + res;
          }
          break;

        default:
          request.setAttribute("erroOp", "Selecione uma operação válida");
          hasError = true;
          break;
      }

      if (!hasError && res != null) {
        request.setAttribute("res", res);
        request.setAttribute("expressao", expressao);
      }
    } else if (op == null || op.isEmpty()) {
      request.setAttribute("erroOp", "Selecione uma operação");
    }

    request.getRequestDispatcher("/calcular.jsp").forward(request, response);
  }
}
