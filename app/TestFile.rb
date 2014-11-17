ENV['RACK_ENV'] = 'test'

require 'app/Main.rb'
require 'test/unit'
require 'rack/test'

class HelloWorldTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def testGetAllPost
	puts ""
	print "testGetAllPost Start..  "
    get '/ws/posts/'
    assert last_response.ok?
    assert_equal '[{"id" : "1","title" : "My first post","tags" : ["cooking","sports"],"description" : "Lorem ipsu...","author" : "Pixelator"},{"id" : "2","title" : "Your second post","tags" : ["fitness","recreation"],"description" : "Morbi est ...","author" : "Pixelated"},{"id" : "3","title" : "Your third post","tags" : ["fitness"],"description" : "Praesent i...","author" : "Pixelated"}]', last_response.body.gsub("\n","").gsub("\t","");

    print "testGetAllPost Done"
  end

  def testGetPostById
	puts ""
	print "GetPostById Start..  "
	get '/ws/posts/id/2'
	assert last_response.ok?
	assert_equal '{"id" : "2","title" : "Your second post","tags" : ["fitness","recreation"],"description" : "Morbi est ...","author" : "Pixelated"}', last_response.body.gsub("\n","").gsub("\t","");
	print "GetPostById Done"
  end
  
  def testGetPostByTag
  	puts ""
	print "GetPostByTag Start..  "
  	get '/ws/posts/tag/fitness'
  	assert last_response.ok?
  	assert_equal '[{"id" : "2","title" : "Your second post","tags" : ["fitness","recreation"],"description" : "Morbi est ...","author" : "Pixelated"},{"id" : "3","title" : "Your third post","tags" : ["fitness"],"description" : "Praesent i...","author" : "Pixelated"}]', last_response.body.gsub("\n","").gsub("\t","");
  	print "GetPostByTag Done"
  end
    
  def testGetPostByAuthor
	puts ""
	print "GetPostByAuthor Start..  "
	get '/ws/posts/author/Pixelated'
	assert last_response.ok?
	assert_equal '[{"id" : "2","title" : "Your second post","tags" : ["fitness","recreation"],"description" : "Morbi est ...","author" : "Pixelated"},{"id" : "3","title" : "Your third post","tags" : ["fitness"],"description" : "Praesent i...","author" : "Pixelated"}]', last_response.body.gsub("\n","").gsub("\t","");
	print "GetPostByAuthor Done"
  end
      
    def testGetAllTags
  	puts ""
  	print "GetAllTags Start..  "
  	get '/ws/tags/'
  	assert last_response.ok?
  	assert_equal '{"cooking" : "1","sports" : "1","fitness" : "2","recreation" : "1"}', last_response.body.gsub("\n","").gsub("\t","");
  	print "GetAllTags Done"
    end
  
  
  
end