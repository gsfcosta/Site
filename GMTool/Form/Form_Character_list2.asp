<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->
<%
	Dim rid_idx		: rid_idx		= Request("id_idx") 
	Dim rPlayerID	: rPlayerID		= Request("PlayerID")
	Dim rServer		: rServer		= Request("Server")
	Dim rName		: rName			= Request("Name")
	Dim rSocket		: rSocket		= Request("Socket")
	Dim cn
%>


	
	<script>
	
		//<![CDATA[	
		var sw_tab = 0; 
		$(function($){ 
			
			$('#tabs').tabs();
			
			$('.char_title').click(function(){
				Player_view($(this).attr('rel'));
			});
			$('#c_add').click(function(){
					Chara_de_Focus();
					$("#Player_char_Info").empty().load("/GMTool/Form/Form_Character_Detail_New.asp?id_idx=<%=rid_idx%>");
				
			});
			
			$.getJSON('/Common/Class/GMTool/GMT_Character.class.asp?id_idx=<%=rid_idx%>',	function(data){
				var html = "";
				var index =0;
				$.each(data.LIST, function(i,Chara){
					 
					$("#tab_"+Chara.N1).html('['+Chara.N2 +']');
					
					if (parseInt(Chara.N2) == 0){
					
						html = html + '<div style="padding-top:20px;padding-left:20px;">';
						html = html + '<%=MsgExtract("F4_Title001")%>';
						html = html + '</div>';
						$("#div_"+Chara.N1).html(html);
						html = '';
					
					}else{
						if ('<%=rServer%>' != ''){
								index = $('#tabs > ul > li > a[href="#<%=rServer%>"]').parent().index();
								$('#tabs').tabs({selected:index});
								sw_tab = 1;
						}else{
							if (sw_tab == 0){
									index = $('#tabs > ul > li > a[href="#'+Chara.N1+'"]').parent().index();
									$('#tabs').tabs({selected:index});
									sw_tab = 1;
							}
						}
						$.each(Chara.N3, function(j,Chara2){
							html = html + '<div class="char_info_w char_info_w_'+Chara.N1+' char_i_'+Chara.N1+unescape(Chara2.N8)+'" rel="'+Chara.N1+'" summary="'+Chara2.N3+'" data="'+unescape(Chara2.N8)+'" title="'+unescape(Chara2.N3)+'">';
							html = html + '	<div class="ci_sp">';
							html = html + '<div class="chat-bubble-arrow-border"></div>  <div class="chat-bubble-arrow"></div>';
							html = html + '		<div class="ci_socket"><span>'+unescape(Chara2.N8)+'</span></div>';
							html = html + '		<div class="ci_icon"><img src="/images/icon_character_'+unescape(Chara2.N4)+'.gif" title="'+Char_Type2(unescape(Chara2.N4))+'"></div>'
							html = html + '		<div class="ci_name ci_name_'+Chara.N1+'">'+unescape(Chara2.N3)+'</div>';
							html = html + '		<div class="ci_level">[Lv.'+unescape(Chara2.N5) +']</div>';
							html = html + '		<div class="ci_create_D"> '+unescape(Chara2.N6) +'</div>';
							html = html + '	</div>';
							html = html + '	<div class="ci_btn_group" align=right style="padding-right:16px">';
							html = html + '		<img src="/images/I-icon24.png" class="Item_btn_'+Chara.N1+'" title="<%=MsgExtract("Btn_Item_list")%>" style="cursor:pointer">';
							html = html + '		<img src="/images/S-icon24.png" class="ItemS_btn_'+Chara.N1+'" title="<%=MsgExtract("Btn_IStore_View")%>" style="cursor:pointer">&nbsp;&nbsp; ';
							html = html + '		<img src="/images/H-icon24.png" class="Hench_btn_'+Chara.N1+'" title="<%=MsgExtract("Btn_Hench")%>" style="cursor:pointer">';
							html = html + '		<img src="/images/S-icon24.png" class="HenchS_btn_'+Chara.N1+'" title="<%=MsgExtract("Btn_HStore_View")%>" style="cursor:pointer">&nbsp;&nbsp; ';
							html = html + '		<img src="/images/G-icon24.png" class="Guild_btn_'+Chara.N1+'" title="<%=MsgExtract("Btn_Guild")%>" style="cursor:pointer">';
							html = html + '		<img src="/images/F-icon24.png" class="Friend_btn_'+Chara.N1+'" title="<%=MsgExtract("Btn_Friend")%>" style="cursor:pointer">';
							//html = html + '		';
							html = html + '	</div>';
							
							html = html + '</div>';
							
						});
						
						$("#div_"+Chara.N1).html(html);
						html = '';
						
						// 캐릭터 이름 클릭시
						$(".ci_name_"+Chara.N1).click(function(){
							Chara_de_Focus();
							$("#Player_char_Info").empty().load("/GMTool/Form/Form_Character_Detail2.asp?id_idx=<%=rid_idx%>&Server="+$(this).parent().parent().attr('rel')+"&C_serial="+$(this).parent().parent().attr('summary') + "&C_name=" + escape($(this).parent().parent().attr('title')) + "&Socket="+$(this).parent().parent().attr("data"));
							$(this).parent().parent().css('border', '1px solid #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').css('border-color','transparent transparent transparent #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').show();
							$(this).parent().parent().children().children('.chat-bubble-arrow').show();
						});
						
						// 길드 버튼 클릭시
						$(".Guild_btn_"+Chara.N1).click(function(){
							Chara_de_Focus();
							$("#Player_char_Info").empty().load("/GMTool/Form/Form_Character_Guild.asp?id_idx=<%=rid_idx%>&Server="+$(this).parent().parent().attr('rel')+"&C_serial="+$(this).parent().parent().attr('summary') + "&C_name=" + escape($(this).parent().parent().attr('title')) + "&Socket="+$(this).parent().parent().attr("data"));
							$(this).parent().parent().css('border', '1px solid #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').css('border-color','transparent transparent transparent #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').show();
							$(this).parent().parent().children().children('.chat-bubble-arrow').show();
						});
						
						// 아이템 버튼 클릭시
						$(".Item_btn_"+Chara.N1).click(function(){
							Chara_de_Focus();
							$("#Player_char_Info").empty().load("/GMTool/Form/Form_Character_Item2.asp?GBN=I&id_idx=<%=rid_idx%>&Server="+$(this).parent().parent().attr('rel')+"&C_serial="+$(this).parent().parent().attr('summary') + "&C_name=" + escape($(this).parent().parent().attr('title')) + "&Socket="+$(this).parent().parent().attr("data"));
							$(this).parent().parent().css('border', '1px solid #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').css('border-color','transparent transparent transparent #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').show();
							$(this).parent().parent().children().children('.chat-bubble-arrow').show();
						});
						
						// 아이템 창고버튼 클릭시
						$(".ItemS_btn_"+Chara.N1).click(function(){
							Chara_de_Focus();
							$("#Player_char_Info").empty().load("/GMTool/Form/Form_Character_Item2.asp?GBN=S&id_idx=<%=rid_idx%>&Server="+$(this).parent().parent().attr('rel')+"&C_serial="+$(this).parent().parent().attr('summary') + "&C_name=" + escape($(this).parent().parent().attr('title')) + "&Socket="+$(this).parent().parent().attr("data"));
							$(this).parent().parent().css('border', '1px solid #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').css('border-color','transparent transparent transparent #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').show();
							$(this).parent().parent().children().children('.chat-bubble-arrow').show();
						});
						
						// 헨치 버튼 믈릭시
						$(".Hench_btn_"+Chara.N1).click(function(){
							Chara_de_Focus();
							$("#Player_char_Info").empty().load("/GMTool/Form/Form_Character_Hench2.asp?GBN=HI&id_idx=<%=rid_idx%>&Server="+$(this).parent().parent().attr('rel')+"&C_serial="+$(this).parent().parent().attr('summary') + "&C_name=" + escape($(this).parent().parent().attr('title')) + "&Socket="+$(this).parent().parent().attr("data"));
							$(this).parent().parent().css('border', '1px solid #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').css('border-color','transparent transparent transparent #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').show();
							$(this).parent().parent().children().children('.chat-bubble-arrow').show();
						});
						// 헨치 창고 버튼 믈릭시
						$(".HenchS_btn_"+Chara.N1).click(function(){
							Chara_de_Focus();
							$("#Player_char_Info").empty().load("/GMTool/Form/Form_Character_Hench2.asp?GBN=HS&id_idx=<%=rid_idx%>&Server="+$(this).parent().parent().attr('rel')+"&C_serial="+$(this).parent().parent().attr('summary') + "&C_name=" + escape($(this).parent().parent().attr('title')) + "&Socket="+$(this).parent().parent().attr("data"));
							$(this).parent().parent().css('border', '1px solid #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').css('border-color','transparent transparent transparent #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').show();
							$(this).parent().parent().children().children('.chat-bubble-arrow').show();
						});
						// 친구 버튼 클릭시
						$(".Friend_btn_"+Chara.N1).click(function(){
							Chara_de_Focus();
							$("#Player_char_Info").empty().load("/GMTool/Form/Form_Character_friend.asp?GBN=I&id_idx=<%=rid_idx%>&Server="+$(this).parent().parent().attr('rel')+"&C_serial="+$(this).parent().parent().attr('summary') + "&C_name=" + escape($(this).parent().parent().attr('title')) + "&Socket="+$(this).parent().parent().attr("data"));
							$(this).parent().parent().css('border', '1px solid #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').css('border-color','transparent transparent transparent #35aaea');
							$(this).parent().parent().children().children('.chat-bubble-arrow-border').show();
							$(this).parent().parent().children().children('.chat-bubble-arrow').show();
						});
					}
					
				});	
				if ('<%=rSocket%>' != ''){
					$('.char_i_<%=rServer%><%=rSocket%>').css('border', '1px solid #35aaea');
					$('.char_i_<%=rServer%><%=rSocket%>').children().children('.chat-bubble-arrow-border').css('border-color','transparent transparent transparent #35aaea');
					$('.char_i_<%=rServer%><%=rSocket%>').children().children('.chat-bubble-arrow-border').show();
					$('.char_i_<%=rServer%><%=rSocket%>').children().children('.chat-bubble-arrow').show();
				}
				
				
			});
		}); 
		function Chara_de_Focus(){
			$('.char_info_w').css('border', '1px solid #efefef');
			$('.chat-bubble-arrow-border').css('border-color','transparent transparent transparent #efefef'); 
			$('.chat-bubble-arrow-border').hide();
			$('.chat-bubble-arrow').hide();
			return;
		}
		//]]>
	</script> 

	<div class="ui-widget-header"><div class="char_title2" > 
		<span class="char_title" rel="<%=rid_idx%>" style="text-align:left;padding-left:0"><font class='f_blu'>Player ID</font> : <span id="r_playerID"><%=rPlayerID%></span> </span> 
		<div style="float:right; margin-top:-5px;margin-right:10px;" ><span class="btn_pack medium icon"><span class="add"></span><button id="c_add"><%=MsgExtract("F5_Title000")%></button></span></div>
	</div>
	<div id="tabs">
<%
	' 서버 이름별로 Tab 을 생성한다.
	
		Call Server_Tab("")
		Dim obj_Ser
		Set obj_Ser = JSON.parse (Server_List)
		
		For cn = 0  to obj_Ser.length-1
			Response.Write "<div id='"& obj_Ser.get(cn).N2 &"'>"
			Char_Create_Table(obj_Ser.get(cn).N2)
			Response.Write "</div>"
		Next
			

%>
	</div>
	
<%

	
	Response.End

	Public Sub Char_Create_Table(trName)
%>
	<input type="hidden" name="Char_ID_IDX" id="Char_ID_IDX" value="<%=rid_idx%>">

	<div id="div_<%=trName%>" style="width:100%; vertical-align:middle; text-align:center">
	
		
		<img src="/images/wait_fbisk.gif" style="margin-top: 100px">
		
	
	</div>
		

<%
	End Sub
%>
