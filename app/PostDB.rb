class PostDB
	def initialize()
		@postById = {}
		@postByTags = {}
		@postByAuthor = {}
		@tagsPopilarity = {}
	end

	def addPost(post)
		@postById[post.id] = post;
		post.tags.each{ |tag|
			if @postByTags[tag] == nil
				@postByTags[tag] = Array.new
				@tagsPopilarity[tag] = 0
			end
			@postByTags[tag].push(post)
			@tagsPopilarity[tag] += 1
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
		return @tagsPopilarity
	end
end