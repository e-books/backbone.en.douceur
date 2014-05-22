
/*
$(function (){
	
	var converter = new Showdown.converter();
	$.get("README.md", function(page) { 
		$("#main_content").html(converter.makeHtml(page));
		$.get("00-PREAMBULE.md", function(page) { 
			$("#preambule").html(converter.makeHtml(page));
		} );
	} );

}); 
*/

$(function (){
	//var k33g = new Gh3.User("k33g")
	var k33g = new Gh3.User("e-books")
	,   k33gBlog = new Gh3.Repository("backbone.en.douceur", k33g)
	,   converter = new Showdown.converter();

	k33gBlog.fetch(function (err, res) {
	    if(err) { throw "outch ..." }

	    k33gBlog.fetchBranches(function (err, res) {
	        if(err) { throw "outch ..." }

	        var master = k33gBlog.getBranchByName("master");

	        master.fetchContents(function (err, res) {
	            if(err) { throw "outch ..." }


			    var readme = master.getFileByName("README.md");
				var preambule = master.getFileByName("00-PREAMBULE.md");

			    readme.fetchContent(function (err, res) {
			        
			        if(err) { throw "outch ..." }
			        $("#main_content").html(converter.makeHtml(readme.getRawContent()));

				    preambule.fetchContent(function (err, res) {
				        if(err) { throw "outch ..." }
				        $("#preambule").html(converter.makeHtml(preambule.getRawContent()));
				    });

			    });


	        });

	    })
	});
}); 


