require 'app/Post.rb'

class Map2PostMapper
	def map(jsonMap)
		posts1 = jsonMap["posts"]
		posts2 = Array.new()
		posts1.each { |postMap|
			p = Post.new()
			p.id = postMap["id"]
			p.title = postMap["title"]
			p.tags = [];
			postMap["tags"].split(',').each{ |tag|
				tag = tag.strip();
				p.tags().push(tag);
			}
			p.description = postMap["description"]
			p.author = postMap["author"]
			posts2.push(p)
		}
		return posts2
	end
end