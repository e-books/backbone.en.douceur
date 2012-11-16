

$(function (){
	
	var mdConverter = new Showdown.converter();
	
	$.ajax({
		contentType : 'application/text',
		url : 'https://raw.github.com/k33g/backbone.en.douceur/master/README.md',
		success: function(data) {
			//console.log(data);
			var content = mdConverter.makeHtml(data);
			$("#main_content").html(content);

			$.ajax({
				contentType : 'application/text',
				url : 'https://raw.github.com/k33g/backbone.en.douceur/master/00-PREAMBULE.md',
				success: function(data) {
					//console.log(data);
					var content = mdConverter.makeHtml(data);
					$("#preambule").html(content);
				},
				error : function(err) {
					throw err;
				}
			});

		},
		error : function(err) {
			throw err;
		}
	});


}); //End of $(function (){...}	


