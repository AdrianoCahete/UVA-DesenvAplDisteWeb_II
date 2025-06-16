<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Calculadora</title>
  </head>
  <body>
    <h1>Calculadora</h1>

    <div class="form-container">
      <form action="calcular">
        <div class="form-group">
          <label for="valor1">Valor 1:</label>
          <input type="text" id="valor1" name="valor1" value="${valor1}" />
        </div>

        <div class="form-group">
          <label for="valor2">Valor 2:</label>
          <input type="text" id="valor2" name="valor2" value="${valor2}" />
        </div>

        <div class="form-group">
          <label for="op">Op:</label>
          <select id="op" name="op">
            <option value="">Selecione uma operação</option>
            <option value="adicao">+</option>
            <option value="subtracao">-</option>
            <option value="multiplicacao">×</option>
            <option value="divisao">/</option>
          </select>
        </div>

        <button type="submit">Calcular</button>
      </form>

      <div>Expressão:</div>
    </div>
  </body>
</html>
