require 'app/util/Configuration.rb'
require 'app/util/JsonFileToMapConverter.rb'
require 'app/model/Post.rb'

class PostDB
  
     
	def initialize()
		@postById = {}
		@postByTags = {}
		@postByAuthor = {}
		@@instance = self    
	end
	
	def PostDB.instance
	  return @@instance
	end
	  
	
	def start()
    fileProcessor = JsonFileToMapConverter.new(Configuration::JSONFILE)
    posts1 = fileProcessor.process()["posts"]
    posts = Array.new()
    posts1.each { |postMap|
      self.addPost(Post.fromMap(postMap))
    }
	end

	def addPost(post)
		@postById[post.id] = post;
		post.tags.each{ |tag|
			if @postByTags[tag] == nil
				@postByTags[tag] = Array.new
			end
			@postByTags[tag].push(post)
		}
		if @postByAuthor[post.author] == nil
			@postByAuthor[post.author] = Array.new
		end
		@postByAuthor[post.author].push(post)
	end

	def getPostById(id)
		return @postById[id]
	end

	def getPostsByTag(tag)
		return @postByTags[tag] || []
	end

	def getPostsByAuthor(author)
		return @postByAuthor[author] || []
	end

	def getAllPosts()
		ret = []
		@postById.each{ |key , value|
			ret.push(value) 
		}
		return ret;
	end

	def getAllTags()
	  ret = {}
	  for key in @postByTags.keys()
	    ret[key] = @postByTags[key].size()
	  end
	  return ret
	end
end