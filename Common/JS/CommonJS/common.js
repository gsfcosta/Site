/**
 * @author Jangbi
 */
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
				$('<span class="'+ errorcn +'">'+ msg +'</span>').appendTo(parent).fadeIn('fast').click(function(){ $(this).remove(); });
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
	
	function gen_page(data){
		$("#Pagination").pagination(data.CNT, {
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
	
	