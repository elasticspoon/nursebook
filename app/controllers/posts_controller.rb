class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update destroy]
  before_action :set_post, only: %i[show edit update destroy purge_attached_image]
  before_action :authenticate_creator, only: %i[edit update destroy purge_attached_image]

  # layout false
  RESULTS_PER_PAGE = 10

  # GET /posts or /posts.json
  def index
    @page = params[:post] ? post_params[:page].to_i : 0
    offset = @page * RESULTS_PER_PAGE
    @posts = Post.order(created_at: :desc)
      .limit(RESULTS_PER_PAGE).offset(offset)

    render layout: 'application'
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
      redirect_to post_url(@post), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  # image attachment is done manually because I don't
  # want the update method to delete the existing images
  def update
    update_params = post_params.except('images')
    images = post_params[:images]

    if @post.update(update_params)
      @post.images.attach(images)
      redirect_to post_url(@post), notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
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
    render turbo_stream: turbo_stream.remove(@image)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:user_id, :content, :page, images: [])
  end

  def authenticate_creator
    return if @post.creator == current_user

    flash[:alert] = 'You are not authorized to perform this action'
    redirect_to root_path
  end
end
