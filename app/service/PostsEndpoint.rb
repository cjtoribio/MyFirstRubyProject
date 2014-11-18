require 'sinatra'
require 'app/form/PostsHtml.rb'
require 'app/db/PostDB.rb'

get '/html/posts/' do
  posts = PostDB.instance.getAllPosts()
  return PostsHtml.new("All Posts", posts).getHtml();
end

get '/html/posts/id/:id' do
  post = PostDB.instance.getPostById(params[:id]);
  posts = post == nil ? [] : [post];
    
  return PostsHtml.new("<h1>All Posts with Id = '#{params[:id]}'</h1>", posts).getHtml();
end

get '/html/posts/tag/:tag' do
  posts = PostDB.instance.getPostsByTag(params[:tag]);
  return PostsHtml.new("<h1>All Posts with Tag = '#{params[:tag]}'</h1>", posts).getHtml();
  return ret;
end

get '/html/posts/author/:author' do
  posts = PostDB.instance.getPostsByAuthor(params[:author]);
  return PostsHtml.new("<h1>All Posts with Author = '#{params[:author]}'</h1>", posts).getHtml();
end

get '/html/tags/' do
  tags = PostDB.instance.getAllTags();
  ret = HtmlProvider.GetHtml("index")
  body = "";
  tags.each do |key , value|
    body += "<div class='property'>TagName: #{key}</div><div class='value'>Popularity: #{value}</div>"
  end
  ret = ret.gsub("${{BODY}}" , body);
  return ret
end
