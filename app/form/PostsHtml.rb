class PostsHtml
	def initialize(header, posts)
		@header = header;
		@posts = posts
	end
	
	def getHtml()
		ret = HtmlProvider.GetHtml("index")
		hPosts = "<h1>#{@header}</h1>";
		@posts.each { |post|
			tPost = HtmlProvider.GetHtml("singlePost");
			tPost = tPost.gsub("${{post.id}}" , post.id.to_s)
			tPost = tPost.gsub("${{post.title}}" , post.title.to_s)
			tPost = tPost.gsub("${{post.description}}" , post.description[0..9])
			tPost = tPost.gsub("${{post.tags}}" , post.tags.join(', '))
			hPosts += tPost;
		}
		ret = ret.gsub("${{BODY}}" , hPosts);
		return ret
	end
end