class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		require 'json'
		@post = Post.new(user_params)
		@post.save
	    #w =  JSON.pretty_generate(JSON.parse(@post.json))
	    #str = render_to_string(:json => w) 
	    #file = File.open("C:/Sites/parser_app/tmp/text.txt", 'w') 
	    #file.write(@str)
	    #file.close
		#post.json = w
		#render :json => w
		#@post.save
		redirect_to @post
	end

	def show
		@post = Post.find(params[:id])
		@w =  JSON.pretty_generate(JSON.parse(@post.json))

	    #@str = render_to_string(:json => @w) 
	    @post.json = @w
	    @post.save
	end

	private
	def user_params
		params.require(:post).permit(:json)
	end
end
