<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/common/Include/Gmlog_Header.asp"-->
<%
	Dim	rServer		: rServer		= lcase(Request("Server"))
	Dim Guild_code 	: Guild_code	= Request("Guild_code")
	
%>
</head>
<style> td{height:24px; font-size:12px}</style> 
<body>
<div id="wrap">
	<div id="header">
		<!--#include virtual="/common/Include/Header.asp"-->
	</div>
	<div id="container" style="padding-bottom:10px;">
		<div class="snb">
			<!--#include virtual="/common/Include/GMTool_Left.asp"-->
		</div>
		<div id="content">
			
			<div class="progress">
					<strong class="tit"><%=MsgExtract("Lab_Home")%></strong> 
					<ol><li class="on"><span><%=Now_Position%></span></li><li class="on"><span><%=MsgExtract("TOOL_Mid3_Title")%></span></li><li class="on"><span><%=MsgExtract("TOOL_SM6_Title")%></span></li></ol>
			</div>
			<h3 style="margin:10px 0 20px 0; padding:0"><%=MsgExtract("TOOL_SM6_Title")%></h3> 
			
			<div id="content_Gmember"></div>
		
		</div>
	</div>
	<!-- footer -->
	<div id="footer">
	<!--#include virtual="/common/Include/Footer.asp"-->
	</div>
	<!--//footer -->
	<div id ="ins_form"></div>
</div>



<script language=javascript>
	//<![CDATA[	
	var Json_url = "/common/class/GMTool/GMT_Guild.class.asp";
	$(function($){
		menu_control(2, 0);
		$("#content_Gmember").load("/GMTool/Form/Form_Character_Guild.asp?Guild_code=<%=Guild_code%>&Server=<%=rServer%>")	
	});
		
	//]]>
	</script>
</body>
</html>