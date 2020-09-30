/**
 * @author  jangbi	tykim@auroraworld.co.kr, geojangbi@naver.com
 * @version 1.3
 * @since 2011.11.15
 */
	/*document.oncontextmenu = new Function('return false');
    document.ondragstart = new Function('return false');
    document.onselectstart = new Function('return false');*/
	
	$(function(){
		$.fn.extend({
			getDiffDate:function(d_day){
				var now = new Date();
				var diff_date = new Date(Date.parse(now)-(parseInt(d_day)*1000*60*60*24));
				$(this).val(diff_date.getFullYear()+'-'+$.fn.setAddZero(diff_date.getMonth()+1)+'-'+$.fn.setAddZero(diff_date.getDate()));
			},
		 
			setAddZero:function(val){
				var tmp = val.toString(); 
				if(tmp.length == 1){
					tmp = '0'+tmp;
				}
				return tmp;
			}
		});
	});

	$(function(){
		var menu_v = $('div.menu_v');
		var sItem = menu_v.find('>ul>li');
		var ssItem = menu_v.find('>ul>li>ul>li');
		var lastEvent = null;

		sItem.find('>ul').css('display','none');
		menu_v.find('>ul>li>ul>li[class=active]').parents('li').attr('class','active');
		menu_v.find('>ul>li[class=active]').find('>ul').css('display','block');
		
		$("#s_Sdate, #s_Edate, #P_day").datepicker({dateFormat: 'yy-mm-dd',changeMonth: true,changeYear: true});
		
		$("#i_search_btn").click(function(){argment_now(0);	});
		
		$("#i_list").click(function(){
			$(this).attr("disabled","disabled");
			location.reload();
		});
		$('#s_item').keydown(function(e){
			if(e.keyCode == 13){
				
				$('#i_search_btn').click();
				
			}
			
		});

		if (Json_url != ''){
			gen_page(0);
			argment_now(0);
		}
		//}
		$("div.fr").find("select").change(function () {
			
			if ($(this).attr("name") == "s_period")
			{
				if ($(this).val() != "T"){
					$("#Period_form").fadeIn();
					
					if ($(this).val() == "W"){
						$("#s_Sdate").getDiffDate(7); 
	
					}else{
						
						$("#s_Sdate").getDiffDate(30);
					}
				}else{
					$("#s_Sdate").getDiffDate(0);
					$("#Period_form").fadeOut();	
				}
			}
			argment_now(0);
			
		});
		
		
		function menu_vToggle(event){
			var t = $(this);
			
			if (this == lastEvent) return false;
			lastEvent = this;
			setTimeout(function(){ lastEvent=null }, 200);
			
			if (t.next('ul').is(':hidden')) {
				sItem.find('>ul').slideUp(100);
				t.next('ul').slideDown(100);
			} else if(!t.next('ul').length) {
				sItem.find('>ul').slideUp(100);
			} else {
				t.next('ul').slideUp(100);
			}
			if (t.parent('li').hasClass('active')){
				t.parent('li').removeClass('active');
			} else {
				sItem.removeClass('active');
				t.parent('li').addClass('active');
			}
		}
		
		sItem.find('>a').click(menu_vToggle).focus(menu_vToggle);
		function subMenuActive(){
			ssItem.removeClass('active');
			$(this).parent(ssItem).addClass('active');
		}; 
		ssItem.find('>a').click(subMenuActive).focus(subMenuActive);
		menu_v.find('>ul>li>ul').prev('a').append('<span class="i"></span>');
	});	
	
	
	function argment_now(page){
		var PageSize = "";
		var s_period = "";
		var s_Server = "";
		var s_gbn    = "";
		var s_Sdate	 = "";
		var s_Edate  = "";
		var str		 = "";
		var I_Pro	 = "";
		$("#spinner").empty().html('<img src="/images/ajax-loader.gif" />');
		PageSize	= $("div.fr > div > select[name=pagesize] > option:selected").val();
		s_period	= $("div.fr > div > select[name=s_period] > option:selected").val();
		s_Server	= $("select[name=Server] > option:selected").val();
		s_gbn		= $("div.fr2 > select[name=s_gbn] > option:selected").val();
		
		I_Pro		= $("#I_Pro").val();
		
		if 	(s_period != "T"){
			s_Sdate = $.trim($("#s_Sdate").val());
			s_Edate = $.trim($("#s_Edate").val());
		}
		str			= $.trim($("#s_item").val());

		$("#i_list").removeAttr("disabled");
		if (page == 0){
			$.getJSON(Json_url +"?I_Pro="+ I_Pro +"&pagesize="+PageSize+"&s_period="+s_period+"&Server="+s_Server+"&s_gbn="+s_gbn+"&s_item="+escape(str)+"&s_Sdate="+s_Sdate+"&s_Edate="+s_Edate,	function(data){
				gen_table(data);
				$("#n_page").html(1);
				gen_page(data.CNT);
			});
		}else{
			$.getJSON(Json_url +"?I_Pro="+ I_Pro +"&Page="+page+"&pagesize="+PageSize+"&s_period="+s_period+"&Server="+s_Server+"&s_gbn="+s_gbn+"&s_item="+escape(str)+"&s_Sdate="+s_Sdate+"&s_Edate="+s_Edate,	function(data){
				gen_table(data);
			});
		}
	}
	
	function log_dialog_form(Dialog_nm, tit){
		
		//$('#Log_Detail1').dialog({
		Dialog_nm.dialog({
			modal:true, 
			height: 600, 
			width:1300, 
			title: tit, 
			resizable: false,
			buttons: {
				Ok: function() {
					$( this ).dialog( "close" );
				}
			}
		
		});	
	
	}
	
	function validationForm(formData, jqForm, optionsa) {         
		var errormsg = 'This field is required!';
		var errorcn = 'form_error';
		var errorck = true;
		
		$('.' + errorcn, jqForm[0]).remove();			
		$('.required',jqForm[0]).each(function(){
			var parent = $(this).parent();
			if( $(this).val() == '' ){
				var msg = $(this).attr('title');

				msg = (msg != '') ? msg : errormsg;
				$('<div class="'+ errorcn +'">'+ msg +'</div>').appendTo(parent).fadeIn('fast').click(function(){ $(this).remove(); });
				errorck = false;
			};
		});
		return errorck; 
	}
	
	function validationForm2(formData, jqForm, optionsa) {         
		var errormsg = 'This field is required!';
		var errorcn = 'form_error';
		var errorck = true;
		
		$('.' + errorcn, jqForm[0]).remove();			
		$('.required',jqForm[0]).each(function(){
			var parent = $(this).parent();
			if( $(this).val() == '' ){
				var msg = $(this).attr('title');

				msg = (msg != '') ? msg : errormsg;
				alert(msg);
				$(this).focus();
				errorck = false;
			};
		});
		return errorck; 
	}
	
	function s_item_search(code){
		
		for(var i = 0; i < s_item_json.length; i++) 
		{ 
		  if(s_item_json[i].N1 == code) 
		  { 
			  return unescape(s_item_json[i].N2); 
		  } 
		} 
	}
	function s_item_GubunCD(code){
		
		for(var i = 0; i < s_item_json.length; i++) 
		{ 
		  if(s_item_json[i].N1 == code) 
		  { 
			  return unescape(s_item_json[i].N3); 
		  } 
		} 
	}
	function s_item_GubunLimit(code){
		
		for(var i = 0; i < s_item_json.length; i++) 
		{ 
		  if(s_item_json[i].N1 == code) 
		  { 
			  return unescape(s_item_json[i].N4); 
		  } 
		} 
	}
	function s_item_GubunDU(code){
		
		for(var i = 0; i < s_item_json.length; i++) 
		{ 
		  if(s_item_json[i].N1 == code) 
		  { 
			  return unescape(s_item_json[i].N5); 
		  } 
		} 
	}
	function s_ITEM_Rarity(code){
		
		for(var i = 0; i < s_item_json.length; i++) 
		{ 
		  if(s_item_json[i].N1 == code) 
		  { 
			  return unescape(s_item_json[i].N6); 
		  } 
		} 
	}
	function s_ITEM_Price(code){
		
		for(var i = 0; i < s_item_json.length; i++) 
		{ 
		  if(s_item_json[i].N1 == code) 
		  { 
			  return unescape(s_item_json[i].N7); 
		  } 
		} 
	}
	function s_zone_search(code){
	
		for(var i = 0; i < s_zone_json.length; i++) 
		{ 
		  if(s_zone_json[i].N1 == code ) 
		  { 
		    return (unescape(s_zone_json[i].N2)); 
		  } 
		} 
	}
	
	function s_monster_search(code){
		for(var i = 0; i < s_monster_json.length; i++) 
		{ 
		  if(s_monster_json[i].N1 == code) 
		  { 
			  return (unescape(s_monster_json[i].N2)); 
		  } 
		} 
	}
	
	function s_monster_group(code){
		for(var i = 0; i < s_monster_json.length; i++) 
		{ 
		  if(s_monster_json[i].N1 == code) 
		  { 
			  return (unescape(s_monster_json[i].N3)); 
		  } 
		} 
	}
	
	function Character_level(code){
		
		for(var i = 0; i < s_LvUserInfo.length; i++) 
		{ 
		  if(s_LvUserInfo[i].N1 == code) 
		  { 
			  return (s_LvUserInfo[i].N2); 
		  } 
		} 
		
	}
	function Char_Type2 (code){

		for(var i = 0; i < Enum_data.CHAR_Type.length; i++) 
		{ 
		  if(Enum_data.CHAR_Type[i].N1 == code) 
		  { 
			  return (unescape(Enum_data.CHAR_Type[i].N2)); 
		  } 
		} 
	}
	
	function Guild_Grade (code){

		for(var i = 0; i < Enum_data.Guild_Grade.length; i++) 
		{ 
		  if(Enum_data.Guild_Grade[i].N1 == code) 
		  { 
			  return (unescape(Enum_data.Guild_Grade[i].N2)); 
		  } 
		} 
	}
	
	function Item_GUBUN (code){

		for(var i = 0; i < Enum_data.ItemType_GBN.length; i++) 
		{ 
		  if(Enum_data.ItemType_GBN[i].N1 == code) 
		  { 
			  return (unescape(Enum_data.ItemType_GBN[i].N2)); 
		  } 
		} 
	}
	
	function Block_Type (code){

		for(var i = 0; i < Enum_data.BlockType.length; i++) 
		{ 
		  if(Enum_data.BlockType[i].N1 == code) 
		  { 
			  return (unescape(Enum_data.BlockType[i].N2)); 
		  } 
		} 
	}
	
	function Block_SUB_Type (code){

		for(var i = 0; i < Enum_data.BlockSUBType.length; i++) 
		{ 
		  if(Enum_data.BlockSUBType[i].N1 == code) 
		  { 
			  return (unescape(Enum_data.BlockSUBType[i].N2)); 
		  } 
		} 
	}
	
	function Acc_Deny_Type (code){

		for(var i = 0; i < Enum_data.ACC_DENYType.length; i++) 
		{ 
		  if(Enum_data.ACC_DENYType[i].N1 == code) 
		  { 
			  return (unescape(Enum_data.ACC_DENYType[i].N2)); 
		  } 
		} 
	}
	
	function Access_Type (code){

		for(var i = 0; i < Enum_data.ACC_Type.length; i++) 
		{ 
		  if(Enum_data.ACC_Type[i].N1 == code) 
		  { 
			  return (unescape(Enum_data.ACC_Type[i].N2)); 
		  } 
		} 
	}
	
	function Item_Type_search (code){

		for(var i = 0; i < Enum_data.ItemType.length; i++) 
		{ 
		  if(Enum_data.ItemType[i].N1 == code) 
		  { 
			  return (unescape(Enum_data.ItemType[i].N2)); 
		  } 
		} 
	}
	
	function Get_ITEM_Rarity (code){

		for(var i = 0; i < Enum_data.ITEM_Rarity.length; i++) 
		{ 
		  if(Enum_data.ITEM_Rarity[i].N1 == code) 
		  { 
			  return (unescape(Enum_data.ITEM_Rarity[i].N2)); 
		  } 
		} 
	}
	
	function Player_view(idx){
		
		form_modal_load('/GMtool/Form/Form_Player.asp?Pidx=' + idx , 'Player Information', 690, 730);
		
	}
	
	function Block_Player_form(ID){
		
		form_modal_load('/GMtool/Form/Form_Block_Player.asp?rPid='+escape(ID), 'Block Player Form', 620, 630);
		
	}
	
	function sel_option(target_sel, j_data, Sel_data){
		var s_option = ""; 
		var s_sel		="";
		for(var i = 0; i < j_data.length; i++) {
			s_sel	= (Sel_data == j_data[i].N1) ? 'selected' : '';
			s_option = s_option + "<option value='"+j_data[i].N1+"' "+ s_sel +">"+j_data[i].N2+"</option>";
		}
		$("#"+target_sel).empty().append(s_option); 
	}
	
	function sel_option2(target_sel, j_data, Sel_data){
		var s_option = ''; 
		var s_sel		='';
		for(var i = 0; i < j_data.length; i++) {
			
			if (s_sel != 'selected'){
				s_sel	= (Sel_data == $.trim(j_data[i].N2)) ? 'selected'  :  '';
				s_option = s_option + "<option value='"+j_data[i].N2+"' "+ s_sel +" rel='"+ j_data[i].N1 +"'>"+j_data[i].N2+"</option>";
			}else{
				
				s_option = s_option + "<option value='"+j_data[i].N2+"' rel='"+ j_data[i].N1 +"'>"+j_data[i].N2+"</option>";
			}
		}
		
		$("#"+target_sel).empty().append(s_option); 
		
		if ($.trim(s_sel) == ''){
			$("#"+target_sel +" > option[value="+j_data[i-1].N2+"]").attr("selected", true);
			$('#Subject').show();
		}
	}
	
	function sel_option3(target_sel, start_val, end_val){
		var s_option = ""; 
		var s_sel		="";
		for(var i = start_val; i <= end_val ; i++) {
			s_option = s_option + "<option value='"+i+"'>"+i+"</option>";
		}
		$("#"+target_sel).empty().append(s_option); 
	}
	
	function gen_selet_socket(data, def_sel){
		
		var sel_socket = '<select id="Sel_SO" name="Sel_SO">';
		
		if (def_sel != ''){
			sel_socket = sel_socket + '<option selected value="'+def_sel+'">' + def_sel +'</option>';
		}
		$.each(data.Sel, function(cnt, C_sel){
			
			sel_socket = sel_socket + '<option value="'+ C_sel.N1 +'">'+ C_sel.N1 +'</option>';
			
		});
		sel_socket = sel_socket + '</select>';
		
		return sel_socket;
	
	}

	function gen_Item_Give_Position(code, id_val){

		var str = '<select id="'+id_val+'" name="'+id_val+'">';
		for(var i = 0; i < Enum_data.ITEM_GIVE_POSITION.length; i++) 
		{ 
		  if(unescape(Enum_data.ITEM_GIVE_POSITION[i].N1) == code) 
		  { 
				str = str + '<option value="'+ Enum_data.ITEM_GIVE_POSITION[i].N1 +'" selected>'+Enum_data.ITEM_GIVE_POSITION[i].N2 +'</option>';
		  }else{
			  	str = str + '<option value="'+ Enum_data.ITEM_GIVE_POSITION[i].N1 +'">'+Enum_data.ITEM_GIVE_POSITION[i].N2+'</option>';
		  }
		} 
		str = str + '</select>';
		return str;
	}
	
	function gen_Item_Name_Select(code, id_val){
		
		var str = '<select id="'+id_val+'" name="'+id_val+'">';
		for(var i = 0; i < s_item_json.length; i++) 
		{ 
		  if(unescape(s_item_json[i].N3) == code) 
		  { 
				str = str + '<option value="'+ unescape(s_item_json[i].N1) +'">'+ unescape(s_item_json[i].N2) +'</option>';
		  } 
		} 
		str = str + '</select>';
		return str;
	}
	
	function gen_monster_Name_Select(code, id_val){
		
		var str = '<select id="'+id_val+'" name="'+id_val+'">';
		for(var i = 0; i < s_monster_json.length; i++) 
		{ 
		  if(unescape(s_monster_json[i].N3) == code) 
		  { 
			  	
				str = str + '<option value="'+ unescape(s_monster_json[i].N1) +'" rel="'+unescape(s_monster_json[i].N2)+'">'+ unescape(s_monster_json[i].N2) +' (Lv.'+unescape(s_monster_json[i].N4) +')</option>';
		  } 
		} 
		str = str + '</select>';
		return str;
	}
	
	function gen_Item_Type_Select(id_val){
		
		var str = '<select id="'+id_val+'" name="'+id_val+'">';
		for(var i = 0; i < Enum_data.ItemType_GBN.length; i++) 
		{
			str = str + '<option value="'+ Enum_data.ItemType_GBN[i].N1 +'">'+ Enum_data.ItemType_GBN[i].N2 +'</option>';
		}
		str = str + '</select>';
		return str;
	
	}
	
	function gen_page(CNT){
		$("#Pagination").pagination(CNT, {
			num_edge_entries: 1,
			num_display_entries: 5,
			items_per_page : $("select[name=pagesize] > option:selected").val(),
			callback: pageselectCallback,
			num_edge_entries :0,
			prev_text : '< Prev',
			next_text : 'Next >'
		});
	}
	
	function pageselectCallback(page_index, jq){
		$("#n_page").html(page_index+1);
		argment_now(page_index);
		return false;
	}
	
	function menu_control(m1, m2){
		$('div.menu_v>ul>li:eq('+m1+')').addClass('active');
		$('div.menu_v>ul>li:eq('+m1+')>ul:eq(0)').slideDown(100);
		$('div.menu_v>ul>li:eq('+m1+')>ul>li:eq('+m2+')').addClass('active');
	}
	
	function log_list_color(){
		$("#log_List > tr:odd").addClass("od1");	
			$("#log_List").find("tr").mouseover(
				function() {$(this).addClass("od2");}
			).mouseout(
				function() {$(this).removeClass("od2");}
			).click(
				function() {
					$("#log_List").find("tr").removeClass("od3");
					$(this).addClass("od3");
			}
		);
	}
	function list_color( str){
		$("#"+str +" > tr:odd").addClass("od1");	
			$("#"+str).find("tr").mouseover(
				function() {$(this).addClass("od2");}
			).mouseout(
				function() {$(this).removeClass("od2");}
			).click(
				function() {
					$("#"+str).find("tr").removeClass("od3");
					$(this).addClass("od3");
			}
		);
	}
	
	
	
	function formatNumber(num)
	{
		var str = String(num);
		var re = /(-?[0-9]+)([0-9]{3})/;
		while (re.test(str))
		{
			str = str.replace(re,"$1,$2");
		}
		return str;
	} 
	
	var dlg = "";
	
	function form_modal_load(form_url, form_title, form_width, form_height){
		
		$( "#dialog:ui-dialog" ).dialog( "destroy" );
		
		$('#ins_form').dialog({
			modal:true, 
			title: form_title, 
			resizable: false,
			open : function(event,ui){
				$(this).load(form_url);
				dlg = $(this);
			},
			height:form_height,
			width:form_width,
			close: function(){
				
				$('#ins_form').empty();
			}
		
		});
		
	}


	



	
	
	
