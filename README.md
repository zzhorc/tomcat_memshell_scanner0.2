# tomcat_memshell_Listener_getandkill
@c0ny1 大佬的查杀工具[java-memshell-scanner](https://github.com/c0ny1/java-memshell-scanner)中遗漏了对listener型内存马的kill功能

作为学习和补充，本jsp可获取tomcat当前上下文的listeners名以及根据输入的listenername删除特定的listener，可用于排查listener型内存马并由用户终止，无需重启tomcat。


## usage
获取Listeners：/getandkill.jsp?method=getl

kill Listener：/getandkill.jsp?method=kill&ListenerName={ListenerName}

## PS
界面显示较为简陋，代码也很小学鸡，师傅们可根据自身需求修改

向大佬们致敬(^^ゞ
