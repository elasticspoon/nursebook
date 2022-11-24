class LikedPostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :set_liked_post, only: %i[show destroy]

  # GET /liked_posts/1 or /liked_posts/1.json
  def show
  end

  # POST /liked_posts or /liked_posts.json
  def create
    valid_params = liked_post_params.merge(user_id: current_user.id)
    @liked_post = LikedPost.new(valid_params)

    respond_to do |format|
      if @liked_post.save
        format.html { redirect_to liked_post_url(@liked_post), notice: 'Liked post was successfully created.' }
        format.json { render :show, status: :created, location: @liked_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @liked_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /liked_posts/1 or /liked_posts/1.json
  def destroy
    @liked_post.destroy

    respond_to do |format|
      format.html { redirect_to liked_posts_url, notice: 'Liked post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_liked_post
    @liked_post = LikedPost.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def liked_post_params
    params.require(:liked_post).permit(:post_id)
  end
end
