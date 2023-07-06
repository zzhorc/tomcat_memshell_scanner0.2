<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.catalina.core.StandardContext" %>
<%@ page import="org.apache.catalina.core.ApplicationContext" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.lang.reflect.Field" %>
<html>
<head>
    <title>操作Tomcat中的ApplicationEventListener</title>
</head>
<body>
    <h1>操作Tomcat中的ApplicationEventListener</h1>
    <ul>
<%
String methodName = request.getParameter("method");
if(methodName==null){
	out.println("请输入方法：getl 或者 kill 。");
	out.println("获取Listener的url：/gak.jsp?method=getl");
	out.println("获取Listener的url：/gak.jsp?method=kill&ListenerName={ListenerName}");
}else{
	if("getl".equals(methodName)){
		out.println("<h2>获取Tomcat中的ApplicationEventListener</h2>");
		//获取到当前listener list
		List<Object> arrayList = getl(request);
		if(arrayList.size()>0){
			//打印所有Listener的名称
			out.println("当前有"+ arrayList.size() +"个Listeners。<br>");
			for (Object listener : arrayList) {
				out.println("<li>" + listener.getClass().getName() + "</li>");
			}
		}else{
			out.println("当前没有Listener。<br>");
		}
	}else if ("kill".equals(methodName)){
		out.println("<h2>删除Tomcat中的ApplicationEventListener</h2>");
		String ListenerName= request.getParameter("ListenerName");
		if(ListenerName!=null){
			//删除对应listener
			boolean status = kill(request,ListenerName);			
			if(status==true){
				out.println("删除完成<br>");
				//获取所有listener名称，不为空则打印出来，否则打印提示信息
				List<Object> arrayList = getl(request);
				if(arrayList.size()>0){
					//打印所有Listener的名称
					out.println("当前有" + arrayList.size() + "个Listeners。<br>");
					for (Object listener : arrayList) {
						out.println("<li>" + listener.getClass().getName() + "</li>");
					}
				}else{
					out.println("当前无Listener。<br>");
				}
			}else{
				out.println("删除失败，没有对应ListenerName的Listener。<br>");
			}
		}else{
			out.println("请在url传入ListenerName参数。<br>");
		}
	
	}else{
		out.println("无效参数<br>");
		out.println("请输入方法：getl 或者 kill 。<br>");
	}
}
%>
<%!
public StandardContext getStandardContext(HttpServletRequest request) throws NoSuchFieldException,IllegalAccessException{
	//反射获取当前request servlet 上下文
	Object obj = request.getServletContext();
	Field field = obj.getClass().getDeclaredField("context");
	field.setAccessible(true);
	ApplicationContext applicationContext = (ApplicationContext) field.get(obj);
	//获取ApplicationContext
	field = applicationContext.getClass().getDeclaredField("context");
	field.setAccessible(true);
	//获取standardContext
	StandardContext standardContext = (StandardContext) field.get(applicationContext);
	return standardContext;
}

public List<Object> getl(HttpServletRequest request) throws NoSuchFieldException,IllegalAccessException{
	StandardContext standardContext = getStandardContext(request);
	Object[] listeners1 = standardContext.getApplicationEventListeners();
	List<Object> listeners = Arrays.asList(listeners1);
	//将长度不可变的List转换成一个可变的ArrayList
	List<Object> arrayList = new ArrayList<>(listeners);
	return arrayList;
}
public boolean kill(HttpServletRequest request,String ListenerName) throws NoSuchFieldException,IllegalAccessException,ConcurrentModificationException{
	try{
		StandardContext standardContext = getStandardContext(request);
		Object[] listeners1 = standardContext.getApplicationEventListeners();
		List<Object> listeners = Arrays.asList(listeners1);
		List<Object> arrayList = new ArrayList<>(listeners);
		//遍历所有同名的Listener并将其从ArrayList中删除
		for (Object listener : arrayList) {
			if(listener.getClass().getName().equals(ListenerName)){
				arrayList.remove(listener);
				//删除后将新的ArrayLisr转成Array设置到ApplicationEventListeners
				Object[] ao = arrayList.toArray(new Object[0]);
				standardContext.setApplicationEventListeners(ao);
				return true;
			}else{
				return false;
			}
		}
		return false;
		}catch (Exception e){
			e.printStackTrace();
			return false;
		}
}
%>
    </ul>
</body>
</html>