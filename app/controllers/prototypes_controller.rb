class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  
  def index
    @prototypes = Prototype.includes(:user).order("created_at DESC")
  end 

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path 
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    #updateアクションにデータを更新する記述
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    if prototype.valid?
      prototype.save
      redirect_to prototype
    else
      render 'edit'
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless current_user == @prototype.user
  end
    
end
