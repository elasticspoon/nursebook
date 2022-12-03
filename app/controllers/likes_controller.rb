class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :set_like, only: :destroy
  before_action :set_or_initialize_like, only: :show

  layout false

  def index_likers
    @target_id = target_id = params[:target_id]
    @target_type = target_type = params[:target_type].capitalize

    likes = Like.includes(user: [:profile]).where(target_id:, target_type:)
    @likers = likes.map(&:user).excluding(current_user)
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # POST /likes or /likes.json
  def create
    valid_params = like_params.merge(user_id: current_user.id)
    @like = Like.new(valid_params)

    if @like.save
      render :show, notice: 'Like was successfully created.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy

    render :show, notice: 'Like was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  def set_or_initialize_like
    target_id = like_params[:target_id]
    target_type = like_params[:target_type].capitalize
    user_id = current_user&.id

    @like = Like.find_or_initialize_by(target_id:, user_id:, target_type:)
  end

  # Only allow a list of trusted parameters through.
  def like_params
    params.require(:like).permit(:target_id, :target_type, :id)
  end
end
