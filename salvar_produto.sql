<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.SQLException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Produto</title>
    </head>
    <body>
  
        <%
            // Receber dados digitados do formulário cadpro
            int codigo;
            String nome, marca;
            double preco;

            codigo = Integer.parseInt(request.getParameter("codigo"));
            nome = request.getParameter("nome"); // Removido parêntese extra
            marca = request.getParameter("marca");
            preco = Double.parseDouble(request.getParameter("preco"));

            // Fazer a conexão com o banco de dados
            try {
                Connection conecta;
                PreparedStatement st;

                // Registrar o driver JDBC
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/produto";
                String user = "root";
                String password = "root";

                conecta = DriverManager.getConnection(url, user, password);

                // SQL para inserção de dados
                String sql = "INSERT INTO produto VALUES (?, ?, ?, ?)";
                st = conecta.prepareStatement(sql);
                st.setInt(1, codigo);
                st.setString(2, nome);
                st.setString(3, marca);
                st.setDouble(4, preco);
                st.executeUpdate(); // Executa o comando SQL

                out.print("<p style='color: green; font-size: 25px;'>Produto cadastrado com sucesso...</p>");
            } catch (Exception x) {
                String erro = x.getMessage();
                if (erro.contains("Duplicate entry")) {
                    out.print("<p style='color: purple; font-size: 25px;'>Este produto já está cadastrado</p>");
                } else {
                    out.print("<p style='color: red; font-size: 25px;'>Mensagem de erro: " + erro + "</p>");
                }
            }
        %>
    </body>
</html>
