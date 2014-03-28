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
	    

	    begin
			clean_up =  JSON.pretty_generate(JSON.parse(@post.json)) 
			JSON.parse(@post.json)
			@post.json = clean_up
	    	@post.save
	    rescue JSON::ParserError => e
	   		@post.json = "Invalid Json"
	   		@post.save
        end	 
       
       if params[:to_file] 
	         file = File.open("#{Rails.root}/files/test_file.txt",'w+') do |task|
	         task.write(@post.json)
	         end    	
             send_file("#{Rails.root}/files/test_file.txt",
              filename: "parsed_json.txt",
              type: "application/text")  	
	     end
	
	 end

	def show

       begin
		@post = Post.find(params[:id])
		clean_up =  JSON.pretty_generate(JSON.parse(@post.json)) 
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
