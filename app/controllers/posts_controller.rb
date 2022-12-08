class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update destroy]
  before_action :set_post, only: %i[show edit update destroy purge_attached_image]
  before_action :authenticate_creator, only: %i[edit update destroy purge_attached_image]

  RESULTS_PER_PAGE = 10

  # GET /posts or /posts.json
  def index
    @page = params[:post] ? post_params[:page].to_i : 0
    offset = @page * RESULTS_PER_PAGE
    @posts = Post.order(created_at: :desc)
      .limit(RESULTS_PER_PAGE).offset(offset)
  end

  def index_commentors
    @post = Post.includes(creator: [:profile]).find(params[:id])
    @commentors = @post.comments.map(&:creator).uniq
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    valid_params = post_params.merge(creator: current_user)
    @post = Post.new(valid_params)

    if @post.save
      @post.images.attach(valid_params[:images]) if valid_params[:images]
      redirect_to post_url(@post), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def purge_attached_image
    @image = ActiveStorage::Attachment.find(params[:image_id])
    @image.purge_later
    render :edit
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:user_id, :content, :page, :images, images: {})
  end

  def authenticate_creator
    return if @post.creator == current_user

    flash[:alert] = 'You are not authorized to perform this action'
    redirect_to root_path
  end
end
