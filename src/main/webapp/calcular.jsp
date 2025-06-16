<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Calculadora</title>
    <style>
      :root {
        --safe-margin: 5px;
      }

      details {
        margin: var(--safe-margin) calc(var(--safe-margin) * 2) calc(var(--safe-margin) * 4);
      }

      input,
      select {
        margin-left: var(--safe-margin);
        padding: 8px;
        border: 1px solid #ddd;
      }

      button {
        width: 262px;
        max-width: 90vw;
        height: 35px;
      }

      .form-group {
        display: flex;
        align-items: center;
        margin-bottom: calc(var(--safe-margin) * 3);
      }

      .form-group label {
        width: 70px;
      }

      .error-message {
        color: red;
        font-size: 0.9em;
        margin-left: var(--safe-margin);
      }

      .result {
        margin-top: calc(var(--safe-margin) * 4);
      }
    </style>
  </head>

  <body>
    <h1>Calculadora</h1>
    <details>
      <summary>Criado por Adriano Cahete</summary>
      <p>Este repositório é parte da AVA2 (AV1) da disciplina de Desenvolvimento de Aplicações Distribuídas Web II da UVA.</p>
      <a href="https://github.com/AdrianoCahete/UVA-DesenvAplDisteWeb_II" target="_blank">Veja o código fonte no GitHub</a>
    </details>

    <div class="form-container">
      <form action="calcular">
        <div class="form-group">
          <label for="val1">Valor 1:</label>
          <input type="number" id="val1" name="val1" value="${val1}" />
          <span class="error-message">${erroV1}</span>
        </div>

        <div class="form-group">
          <label for="val2">Valor 2:</label>
          <input type="number" id="val2" name="val2" value="${val2}" />
          <span class="error-message">${erroV2}</span>
        </div>

        <div class="form-group">
          <label for="op">Op:</label>
          <select id="op" name="op">
            <option value="" ${op == null || op == '' ? 'selected' : ''}>Selecione uma operação</option>
            <option value="adicao" ${op == 'adicao' ? 'selected' : ''}>+</option>
            <option value="subtracao" ${op == 'subtracao' ? 'selected' : ''}>-</option>
            <option value="multiplicacao" ${op == 'multiplicacao' ? 'selected' : ''}>x</option>
            <option value="divisao" ${op == 'divisao' ? 'selected' : ''}>/</option>
          </select>
          <span class="error-message">${erroOp}</span>
          <span class="error-message">${erroDivisao}</span>
        </div>

        <button type="submit">Calcular</button>
      </form>

      <% if (request.getAttribute("expressao") != null) { %>
      <div class="result">
        <p>Expressão: ${expressao}</p>
      </div>
      <% } %>
    </div>
  </body>
</html>
