module PostsHelper


end
def parset(parent,child)
	if parent[child].class == String
		
		if child.class != Fixnum
			data = "<b>"+ child.to_s + ":</b> " + parent[child].to_s + "<br><br>"
		else
			data = parent[child].to_s + "<br>"
		end

		return data.html_safe 
	end

	if parent[child].class == Array
		data = parent[child]
		size = data.size
		idx = 0
		arr = ""
		while idx < size do
			if data[idx].class == Hash
            arr = "<b>" + arr + child.to_s + "</b>"
			end

			arr = arr + parset(data,idx).to_s
			idx += 1 
		end
		return arr.html_safe
	end

	if parent[child].class == Hash
		data = parent[child]
		keys = data.keys
		
		str = ""
		if child.class != Fixnum
			str = "<b>" + child.to_s + "</b><ul>"
		end
		keys.each do |key|
		  str = str + "<b><li>" + key.to_s + "</li></b><ul>"
	      str = str + "<li>" + parset(data,key).to_s + "</li></ul>"
		end
		str = str + "</ul>"
		return str.html_safe
	end
end