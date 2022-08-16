class BlogsController < ApplicationController
  protect_from_forgery :except => [:destroy]
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
  end
  
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blog_path(@blog.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update

    @blog = Blog.find(params[:id])
    
    if @blog.update(blog_params)
      redirect_to blog_path(@blog)
    else
      render :edit, status: :unprocessable_entity
    end
    
  end
  
  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to blogs_path, status: :see_other  # 投稿一覧画面へリダイレクト
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :category, :body)
  end
end
