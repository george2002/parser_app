class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create

	    @post = Post.new(user_params)
		@post.save

		if params[:to_screen] || params[:to_pdf]
			redirect_to @post	
	    end

     if params[:to_file] 

	    begin
			clean_up =  JSON.pretty_generate(JSON.parse(@post.json)) 
			clean_up = clean_up.delete '{}[],"'
			JSON.parse(@post.json)
			@post.json = clean_up
	    	@post.save

	    rescue JSON::ParserError => e
	   		@post.json = "Invalid Json"
	   		clean_up = "Invalid Json"
	   		@post.save
        end	    


            file = File.open("#{Rails.root}/files/test_file.txt",'w+') do |task|
	         task.write(clean_up)
	         end  
              
             send_data("people\np", filename:  "name.txt")
             #send_file("#{Rails.root}/files/test_file.txt",
             #filename: "parsed_json.txt",
             #type: "application/txt")    
      	
	  end
	
	 end

	def show


       begin
		@post = Post.find(params[:id])
		@pj = JSON.parse(@post.json)
		clean_up =  JSON.pretty_generate(JSON.parse(@post.json)) 
		clean_up = clean_up.delete '{}[],"'
		JSON.parse(@post.json)
		@post.json = clean_up
	    @post.save
	   rescue JSON::ParserError => e
	   	@post.json = "Invalid Json"
	   	@post.save
       end	 
	end

	private
	def user_params
		params.require(:post).permit(:json)
	end
end
