module HtmlProvider extend self
	def GetHtml(name)
		return IO.read("views/#{name}.html");
	end
end