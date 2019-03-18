
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização Constante</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf" %> 
        <h1><center>Amortização Constante</center></h1><br/>
        <hr/>
        
        <form>
            Valor Financiado: <input type="number" name="valorFinanciado"><br/>
            Número de meses: <input type="number" name="mes"><br/>
            Taxa de Juros(em(%)): <input type="number" name="juros"><br/>
            <br/><input type="submit" name="calcular" value="CALCULAR"><br/><br/>
            
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
                
                <table border="1">
                    <tr>
                        <th>#</th>
                        <th>Parcelas</th>
                        <th>Amortizações</th><th>Juros</th>
                        <th>Saldo Devedor</th>
                    </tr>
                    
                    <tr>
                       <td><%= i %></td>
                       <td><%= parc %></td>
                       <td><%= amort %></td>
                       <td><%= jurosOutput %></td>
                       <td><%= saldoDevedor %></td>
                       
                    </tr>
                    
                    <% for(i =2 ; i<=meses; i++){%>
                        <% jurosOutput =  juros100 * saldoDevedor; %>
                        <% saldoDevedor = saldoDevedor - amort; %>
                        <% parc = jurosOutput + amort; %>
                       
                        <tr>
                            <td><%= i %></td>
                            <td><%= parc %></td>
                            <td><%= amort %></td>
                            <td><%= jurosOutput %></td>
                            <td><%= saldoDevedor %></td>  
                        </tr>
                        <% totalAmort = totalAmort + amort; %>
                        <% totalJurosOutput += jurosOutput; %>
                        <% totalParc += parc; %>
                            
                    <% }%>
                        
                
                    <tr>
                        <td> >> </td>
                        <td><%= totalParc %></td>
                        <td><%= totalAmort %></td>
                        <td><%= totalJurosOutput %></td>
                        <td><center><b> <<-TOTAIS </b></center></td> 
                    </tr>
                </table>
                    
                
                <% }catch(Exception e){%>
                    <h2 style="color:red">Número Inválido</h2>
                <% }%>
            <% } %>
        </form>
    </body>
</html>
