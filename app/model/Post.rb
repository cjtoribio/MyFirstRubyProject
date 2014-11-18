class Post
	def initialize()
		@id , @title , @tags , @description , @author = 0 , nil , nil , nil , nil
	end
	
	def Post.fromMap(postMap)
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
    return p;
	end
	
	attr_accessor :id
	attr_accessor :title
	attr_accessor :tags
	attr_accessor :description
	attr_accessor :author

	def to_json
		return "
				{
					'id' : '#@id',
					'title' : '#@title',
					'tags' : ['#{@tags.join("\',\'")}'],
					'description' : '#{@description[0..9]}...',
					'author' : '#@author'
				}
				".gsub("'",'"');
	end
end