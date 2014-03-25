class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(user_params)
		@post.save
		redirect_to @post
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
