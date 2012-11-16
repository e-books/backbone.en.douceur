

$(function (){
	
	var k33g = new Gh3.User("k33g")
	,   k33gBlog = new Gh3.Repository("backbone.en.douceur", k33g);

	k33gBlog.fetch(function (err, res) {
	    if(err) { throw "outch ..." }

	    var mdConverter = new Showdown.converter();

	    k33gBlog.fetchBranches(function (err, res) {
	        if(err) { throw "outch ..." }

	        var master = k33gBlog.getBranchByName("master");

	        master.fetchContents(function (err, res) {
	            if(err) { throw "outch ..." }


			    window.readme = master.getFileByName("README.md");
				window.preambule = master.getFileByName("00-PREAMBULE.md");

			    readme.fetchContent(function (err, res) {
			        if(err) { throw "outch ..." }

			        var content = mdConverter.makeHtml(readme.getRawContent());
					$("#main_content").html(content);

				    preambule.fetchContent(function (err, res) {
				        if(err) { throw "outch ..." }

				        var content = mdConverter.makeHtml(preambule.getRawContent());
						$("#preambule").html(content);

				    });


			    });

	        });

	    })
	});


}); //End of $(function (){...}	






