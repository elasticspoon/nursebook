class LikedPostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :set_liked_post, only: :destroy
  before_action :set_or_initialize_liked_post, only: :show

  layout false

  def index_likers
    @target_id = params[:id]
    liked_posts = LikedPost.includes(user: [:profile])
    specific_liked_posts = @target_id ? liked_posts.where(target_id: @target_id) : liked_posts
    @likers = specific_liked_posts.map(&:user)
  end

  # GET /liked_posts/1 or /liked_posts/1.json
  def show
  end

  # POST /liked_posts or /liked_posts.json
  def create
    valid_params = liked_post_params.merge(user_id: current_user.id)
    @liked_post = LikedPost.new(valid_params)

    respond_to do |format|
      if @liked_post.save
        format.html { render :show, notice: 'Liked post was successfully created.' }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   if @liked_post.save
  #     redirect_to post_url(@post), notice: 'Post was successfully updated.'
  #   else
  #     render :show, status: :unprocessable_entity
  #   end
  # end

  # DELETE /liked_posts/1 or /liked_posts/1.json
  def destroy
    @liked_post.destroy

    render :show, notice: 'Liked post was successfully destroyed.'
  end

  private

  # Set a liked post based on liked_post_id given
  def set_liked_post
    @liked_post = LikedPost.find(params[:id])
  end

  # Set a liked post based on post_id and current_user
  # initialize a new liked post if none exists
  def set_or_initialize_liked_post
    target_id = liked_post_params[:target_id]
    user_id = current_user&.id
    @liked_post = LikedPost.find_or_initialize_by(target_id:, user_id:)
  end

  # Only allow a list of trusted parameters through.
  def liked_post_params
    params.require(:liked_post).permit(:target_id, :id)
  end

  def authenticate_user!
    redirect_to new_user_session_path unless user_signed_in?
  end
end
