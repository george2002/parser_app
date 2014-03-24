class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(params[user_params])
		@post.save
		redirect_to @post
	end

	def show
		@post = Post.find(params[:id])
	end

	private
	def user_params
		params.require(:post).permit(:json)
	end
end
