<%--
  Created by IntelliJ IDEA.
  User: prayjourney
  Date: 2016/6/24
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<h1>我来测试Servlet！</h1>
<%
out.println("Your IP address is " + request.getRemoteAddr());
%>
<p>
  今天是:<%=(new java.util.Date()).toLocaleString()%>
  <%-- This comment will not be visible in the page source --%>
  <% if (day == 1 | day == 7) { %>
      <p> Today is weekend</p>
<% } else { %>
      <p> Today is not weekend</p>
<% } %>
</p>
</body>
</html>
