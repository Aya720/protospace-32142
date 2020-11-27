class PrototypesController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :new, :create]
  before_action :set_prototype, only: [:edit, :show]
  
  def index
    @prototypes = Prototype.includes(:user).order("created_at DESC")
  end 

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
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

  def move_to_index
    unless user_signed_in? && current_user.id == @prototype
      redirect_to action: :index
    end
  end

  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  #パラメータで送信されるID値で、Prototypeモデルの特定のオブジェクトを取得するように記述し、それを@prototypeに代入
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
    
end
