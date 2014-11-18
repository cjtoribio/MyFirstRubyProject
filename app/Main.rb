#!/usr/bin/ruby
require 'sinatra'
require 'app/JsonFileToMapConverter.rb'
require 'app/Map2PostMapper.rb'
require 'app/PostDB.rb'
require 'app/Post.rb'
require 'app/HtmlProvider.rb'
require 'app/PostsHtml.rb'


fileProcessor = JsonFileToMapConverter.new("posts.js")
posts = Map2PostMapper.new.map(fileProcessor.process());
db = PostDB.new()
posts.each { |post|
	db.addPost(post);
}




#Web Service
get '/ws/posts/' do
	posts = db.getAllPosts()
	ret = "["
	posts.each { |post|
		if(ret != "["); ret += "," end
		ret += post.to_json
	}
	ret += "]"
	return ret
end
get '/ws/posts/id/:id' do
	post = db.getPostById(params[:id]);
	return post == nil ? "{'error': 'No Post Found'}" : post.to_json
end
get '/ws/posts/tag/:tag' do
	posts = db.getPostsByTag(params[:tag]);
	ret = "["
	posts.each { |post|
		if(ret != "["); ret += "," end
		ret += post.to_json
	}
	ret += "]"
	return ret
end
get '/ws/posts/author/:author' do
	posts = db.getPostsByAuthor(params[:author]);
	ret = HtmlProvider.GetHtml("index")
	hPosts = "";
	posts.each { |post|
		tPost = HtmlProvider.GetHtml("singlePost");
		tPost.gsub("${{post.id}}" , post.id.to_s)
		tPost.gsub("${{post.title}}" , post.id.to_s)
		tPost.gsub("${{post.description}}" , post.description[0..9])
		tPost.gsub("${{post.tags}}" , post.tags.join(', '))
		hPost += tPost;
	}
	ret.gsub("${{BODY}}" , hPosts);
	return ret
end
get '/ws/tags/' do
	tags = db.getAllTags();
	ret = "{"
	tags.each do |key , value|
		if(ret != "{"); ret += "," end
		ret += "\"#{key}\" : \"#{value}\""
	end
	ret += "}"
	return ret
end


#Web Service
get '/html/posts/' do
	posts = db.getAllPosts()
	return PostsHtml.new("All Posts", posts).getHtml();
end

get '/html/posts/id/:id' do
	posts = [db.getPostById(params[:id])];
	return PostsHtml.new("<h1>All Posts with Id = '#{params[:id]}'</h1>", posts).getHtml();
end

get '/html/posts/tag/:tag' do
	posts = db.getPostsByTag(params[:tag]);
	return PostsHtml.new("<h1>All Posts with Tag = '#{params[:tag]}'</h1>", posts).getHtml();
	return ret;
end
get '/html/posts/author/:author' do
	posts = db.getPostsByAuthor(params[:author]);
	return PostsHtml.new("<h1>All Posts with Author = '#{params[:author]}'</h1>", posts).getHtml();
end
get '/html/tags/' do
	tags = db.getAllTags();
	ret = HtmlProvider.GetHtml("index")
	body = "";
	tags.each do |key , value|
		body += "<div class='property'>TagName: #{key}</div><div class='value'>Popularity: #{value}</div>"
	end
	ret = ret.gsub("${{BODY}}" , body);
	return ret
end

set :public_folder, File.dirname(__FILE__) + "/../public"

