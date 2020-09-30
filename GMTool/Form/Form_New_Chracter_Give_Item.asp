<!--#include virtual="/Common/Include/Gmtool_Form_Header.asp"-->
<%
	Dim rServer 	:	rServer			= Request("Server")
	Dim rGBN		:	rGBN			= trim(Request("GBN"))
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
%>				
				<form id="GiveItem" method="post" action="/Common/Class/GMTool/GMT_Character_Item.class.asp?I_Pro=ITADD" >
					<input type=hidden name="Server" value="<%=rServer%>">
					<input type=hidden name="id_idx" value="<%=rid_idx%>">
					<input type=hidden name="Socket" value="<%=rSocket%>">
					
					<div class="form_table" style="margin-top: 10px">
					<table border="1" cellspacing="0" summary="New Player Insert Form">
					<colgroup>
						<col width="120"><col width="*">
					</colgroup>
					  <tr>
					    <th><%=MsgExtract("F6_Title016")%></th>
					    <td>
					      <div class="item" id="F_Item_Type_DIV"></div>
					    </td>
					  </tr>
					  <tr>
					    <th><%=MsgExtract("F6_Title017")%></th>
					    <td>
					      <div class="item" id="F_Item_Name_DIV"></div>
					    </td>
					  </tr>
					                   
					  <tr>
					    <th><%=MsgExtract("F6_Title018")%></th>
					    <td>
					      <div class="item" id="F_Item_GiveP_DIV"></div>
					    </td>
					  </tr>
					   <tr>
					    <th><%=MsgExtract("F6_Title019")%></th>
					    <td>
					      <div class="item" id="F_ITem_Sock_DIV"></div>
					    </td>
					  </tr>         
					  <tr>
					    <th><%=MsgExtract("F6_Title020")%></th>
					    <td>
					      <div class="item" id="F_Item_Price_DIV"></div>
					    </td>
					  </tr>       
					  <tr>
					    <th><%=MsgExtract("F6_Title021")%></th>
					    <td>
					    
					      <div class="item" id="F_Item_Pri_DIV"></div>
					    </td>
					  </tr>
					  <tr>
					    <th><%=MsgExtract("F6_Title022")%></th>
					    <td>
					      <div class="item" id="F_Item_Kind_DIV"></div>
					    </td>
					  </tr>  
					 <tr>
					    <th><%=MsgExtract("F6_Title023")%></th>
					    <td>
					      <div class="item" id="F_Item_DB_DIV"></div>
					    </td>
					  </tr>
					
					</table>
					
					<div style="margin-top:20px"><center>
								<span class="btn_pack medium icon"><span class="saveas"></span><button type="submit">&nbsp;<%=MsgExtract("Btn_Save")%></button></span>
								
						</center></div>
					</form>
			
				<script>
					$(function($){
						
						$('#GiveItem').submit(function(){ 
							if (confirm('<%=MsgExtract("F6_Title024")%>')){
							$(this).ajaxSubmit({ beforeSubmit: validationForm, success: Item_Reult_val });
							} 
							return false;
						});
						function Item_Reult_val(responseText, statusText, xhr, $form)  {     
							
							alert('<%=MsgExtract("F6_Title025")%>');
							$("#Player_char_Info").empty().load("/GMTool/Form/Form_Character_Item2.asp?GBN="+$('#GBN').val()+"&id_idx=<%=rid_idx%>&Server=<%=rServer%>&Socket=<%=rSocket%>");
							$('#ins_form').dialog('close');
							$('#ins_form').empty();
							
						} 
						//alert(gen_Item_Type_Select('F_Item_Type_Sel'));
						$('#F_Item_Type_DIV').html(gen_Item_Type_Select('F_Item_Type_Sel'));
						$('#F_Item_Name_DIV').html(gen_Item_Name_Select($('#F_Item_Type_Sel').val(),'F_Item_Name_Sel'));
						$('#F_Item_GiveP_DIV').html(gen_Item_Give_Position('<%=rGBN%>','GBN'));
						Get_Socket_N_Create('<%=rGBN%>');
						$('#F_Item_Price_DIV').empty().html(s_ITEM_Price($('#F_Item_Name_Sel').val()));
						$('#F_Item_Pri_DIV').empty().html(s_item_GubunDU($('#F_Item_Name_Sel').val()));
						$('#F_Item_Kind_DIV').empty().html(Get_ITEM_Rarity(s_ITEM_Rarity($('#F_Item_Name_Sel').val())));
						//alert(s_ITEM_Rarity($('#F_Item_Name_Sel').val()));
						Get_DBL(s_item_GubunLimit($('#F_Item_Name_Sel').val()));
						
						$('#F_Item_Type_Sel').change(function(){
							$('#F_Item_Name_DIV').empty().html(gen_Item_Name_Select($(this).val(),'F_Item_Name_Sel'));
							$('#F_Item_Price_DIV').empty().html(s_ITEM_Price($('#F_Item_Name_Sel').val()));
							$('#F_Item_Pri_DIV').empty().html(s_item_GubunDU($('#F_Item_Name_Sel').val()));
							$('#F_Item_Kind_DIV').empty().html(Get_ITEM_Rarity(s_ITEM_Rarity($('#F_Item_Name_Sel').val())));
							Get_DBL(s_item_GubunLimit($('#F_Item_Name_Sel').val()));
							 
							$('#F_Item_Name_Sel').change(function(){
								$('#F_Item_Price_DIV').empty().html(s_ITEM_Price($(this).val()));
								$('#F_Item_Pri_DIV').empty().html(s_item_GubunDU($(this).val()));
								$('#F_Item_Kind_DIV').empty().html(Get_ITEM_Rarity(s_ITEM_Rarity($(this).val()))); 
								Get_DBL(s_item_GubunLimit( $(this).val() ));
							});
						});

						$('#GBN').change(function(){ 
							Get_Socket_N_Create($(this).val());
						});
						function Get_DBL(qty){
							var DB_Gbn = "";
							
							if(parseInt(qty) <= 1){
								DB_Gbn = '<div class="item, f_red"><%=MsgExtract("F6_Title013")%></div>';
							}else{
								DB_Gbn = '<div class="item, f_gre"><input type="text" name="Item_Qty" value="1" size=3/> &nbsp <%=MsgExtract("F6_Title012")%></div>';
							}
							//alert(qty);
							$('#F_Item_DB_DIV').html(DB_Gbn);
						
						}
					});
					function Get_Socket_N_Create(GBN_Val){
						var Select_val = "";
						$.getJSON('/Common/Class/GMTool/GMT_Character_Item.class.asp?id_idx=<%=rid_idx%>&Socket=<%=rSocket%>&Server=<%=rServer%>&GBN=' + GBN_Val ,	function(data){
							$('#F_ITem_Sock_DIV').html( gen_selet_socket(data, '') );
						});
					}
				</script>