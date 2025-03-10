<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Produto</title>
    </head>
    <body>
  
        <%
            //receber dados digitados do formulario cadpro

            int codigo;
            String nome, marca;
            double preco;

            codigo = Integer.parseInt(request.getParameter("codigo"));
            nome = request.getParameter(("nome"));
            marca = request.getParameter("marca");
            preco = Double.parseDouble(request.getParameter("preco"));
            //Fazer a conexão com o banco de dados

            try {
                Connection conecta;
                PreparedStatement st; //Esse objeto permite enviar vários
                // comandos sql como um grupo unico para um banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver"); //este método é usado para que o servidor 
                //de aplicação faça o registro do driver do banco
                String url = "jdbc:mysql://localhost:3306/produto";
                String user = "root";
                String password = "root";

                conecta = DriverManager.getConnection(url, user, password);

                String sql = ("INSERT INTO produto VALUES (?, ?, ?, ?)");
                st = conecta.prepareStatement(sql);
                st.setInt(1, codigo);
                st.setString(2, nome);
                st.setString(3, marca);
                st.setDouble(4, preco);
                st.executeUpdate(); //executar a instrução INSERT
                out.print("<p style= 'color: green; font-size:25px'>Produto cadastrado com sucesso...</p>");
            } catch (Exception x) {
                String erro=x.getMessage();
                if (erro.contains("Duplicate entry")) {
                out.print("<p style='color: purple; font-size25px'>Este produto está cadastrado</p>");
            } else {
            out.print("<p style='color: red; font-size:25px'>Mensagem de erro: " + erro + "</p>");
            
            
            }
            }

        %>
    </body>
</html>
