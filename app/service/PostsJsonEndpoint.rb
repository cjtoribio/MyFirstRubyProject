require 'sinatra'
require 'app/db/PostDB.rb'

get '/ws/posts/' do
  posts = PostDB.instance.getAllPosts()
  ret = "["
  posts.each { |post|
    if(ret != "["); ret += "," end
    ret += post.to_json
  }
  ret += "]"
  return ret
end
get '/ws/posts/id/:id' do
  post = PostDB.instance.getPostById(params[:id]);
  return post == nil ? "{'error': 'No Post Found'}" : post.to_json
end
get '/ws/posts/tag/:tag' do
  posts = PostDB.instance.getPostsByTag(params[:tag]);
  ret = "["
  posts.each { |post|
    if(ret != "["); ret += "," end
    ret += post.to_json
  }
  ret += "]"
  return ret
end
get '/ws/posts/author/:author' do
  posts = PostDB.instance.getPostsByAuthor(params[:author]);
  ret = "["
  posts.each { |post|
    if(ret != "["); ret += "," end
    ret += post.to_json
  }
  ret += "]"
  return ret
end
get '/ws/tags/' do
  tags = PostDB.instance.getAllTags();
  ret = "{"
  tags.each do |key , value|
    if(ret != "{"); ret += "," end
    ret += "\"#{key}\" : \"#{value}\""
  end
  ret += "}"
  return ret
end
