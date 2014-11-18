require 'sinatra'
require 'app/service/HtmlProvider'
require 'app/service/PostsEndpoint.rb'
require 'app/service/PostsJsonEndpoint.rb'

set :public_folder, File.dirname(__FILE__) + "/../../public"