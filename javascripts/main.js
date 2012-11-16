

$(function (){
	
	var converter = new Showdown.converter();
	$.get("README.md", function(page) { 
		$("#main_content").html(converter.makeHtml(page));
		$.get("00-PREAMBULE.md", function(page) { 
			$("#preambule").html(converter.makeHtml(page));
		} );
	} );

}); 






