<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização Constante</title>
        <%@include file="WEB-INF/jspf/header.jspf" %>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf" %> 
        <h1><center>Amortização Constante</center></h1><br/>
        <p align="center">Também conhecido como Sistema de Amortização Constante (SAC), ou Método Hamburguês, é caracterizado por pagamentos mensais decrescentes, que embutem uma amortização constante.</p>
        <hr/>
        
        <form>
            <table align="center">
                <tr>
                    <td>Valor Financiado:</td><td> <input type="number" name="valorFinanciado"></td>
                    <td>Número de meses: </td><td><input type="number" name="mes"></td>
                    <td>Taxa de Juros(em(%)) por mês: </td><td><input type="number" name="juros" min="0" step="0.01" required></td>
                    <td><input type="submit" name="calcular" value="CALCULAR"></td>
                </tr>
            </table>
            <br/><br/><br/>
            <% Locale localeBR = new Locale("pt","BR"); %>
            <% NumberFormat dinheiro = NumberFormat.getCurrencyInstance(localeBR); %>
            <% if(request.getParameter("calcular")!=null){ %>
                
            <% try{ %>
                <% int i=1; %>
                <% double vf = Double.valueOf(request.getParameter("valorFinanciado")); %>
                <% double meses = Double.valueOf(request.getParameter("mes")); %>
                <% double jurosInput = Double.valueOf(request.getParameter("juros")); %>
                <% double amort = 0; %>
                <% double totalAmort = 0; %>
                <% double parc = 0; %>
                <% double totalParc = 0; %>
                <% double jurosOutput = 0; %>
                <% double totalJurosOutput = 0; %>
                <% double saldoDevedor = 0; %>
                <% double juros100 = jurosInput/100; %>
                
                <% amort = vf / meses; %>
                <% jurosOutput =  juros100* vf;%>
                <% parc =  amort + jurosOutput;%>
                <% saldoDevedor =  vf - amort;%>
                
                <% totalAmort += amort; %>
                <% totalJurosOutput += jurosOutput; %>
                <% totalParc += parc; %>
                
                <table border="1" align="center">
                    <tr>
                        <th>#</th>
                        <th>Parcelas</th>
                        <th>Amortizações</th><th>Juros</th>
                        <th>Saldo Devedor</th>
                    </tr>
                    
                    <tr>
                       <td align="center"><%= i %></td>
                       <td align="right"><%= dinheiro.format(parc) %></td>
                       <td align="right"><%= dinheiro.format(amort) %></td>
                       <td align="right"><%= dinheiro.format(jurosOutput) %></td>
                       <td align="right"><%= dinheiro.format(saldoDevedor)%></td>
                       
                    </tr>
                    
                    <% for(i =2 ; i<=meses; i++){%>
                        <% jurosOutput =  juros100 * saldoDevedor; %>
                        <% saldoDevedor = saldoDevedor - amort; %>
                        <% parc = jurosOutput + amort; %>
                       
                        <tr>
                            <td align="center"><%= i %></td>
                            <td align="right"><%= dinheiro.format(parc) %></td>
                            <td align="right"><%= dinheiro.format(amort) %></td>
                            <td align="right"><%= dinheiro.format(jurosOutput) %></td>
                            <td align="right"><%= dinheiro.format(saldoDevedor)%></td> 
                        </tr>
                        <% totalAmort = totalAmort + amort; %>
                        <% totalJurosOutput += jurosOutput; %>
                        <% totalParc += parc; %>
                            
                    <% }%>
                        
                
                    <tr>
                        <td> >> </td>
                        <td align="right"><%= dinheiro.format(totalParc) %></td>
                        <td align="right"><%= dinheiro.format(totalAmort) %></td>
                        <td align="right"><%= dinheiro.format(totalJurosOutput) %></td>
                        <td><center><b> <<-TOTAIS </b></center></td> 
                    </tr>
                </table>
                <br/>    
                
                <% }catch(Exception e){%>
                    <h2 style="color:red">Número Inválido</h2>
                <% }%>
            <% } %>
        </form>
    </body>
    <footer>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </footer>
</html>
