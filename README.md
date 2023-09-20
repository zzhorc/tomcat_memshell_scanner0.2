# v2.0 tomcat-memshell-scanner-0.2
把我的listener查杀和 @c0ny1 大佬的查杀工具[java-memshell-scanner](https://github.com/c0ny1/java-memshell-scanner) 整合到一起了，现在使用 tomcat-memshell-scanner-0.2.jsp 即可对三种内存马进行查杀

## usage

查：/tomcat-memshell-scanner-0.2.jsp
杀：/tomcat-memshell-scanner-0.2.jsp?action=kill&{listenerName|filterName|servletName}=xxxxx  (点对应的 kill 链接即可)

向大佬们致敬(^^ゞ


# v1.0 tomcat_memshell_Listener_getandkill
## tomcat_memshell_Listener_getandkill
@c0ny1 大佬的查杀工具[java-memshell-scanner](https://github.com/c0ny1/java-memshell-scanner)中遗漏了对listener型内存马的kill功能

作为学习和补充，本jsp可获取tomcat当前上下文的listeners名以及根据输入的listenername删除特定的listener，可用于排查listener型内存马并由用户终止，无需重启tomcat。


## usage
获取Listeners：/getandkill.jsp?method=getl

kill Listener：/getandkill.jsp?method=kill&ListenerName={ListenerName}

## PS
界面显示较为简陋，代码也很小学鸡，师傅们可根据自身需求修改

