class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :build_new_comment, only: :new

  layout false

  # GET /comments
  def index
    parent_type = comment_params[:parent_type]
    parent_id = comment_params[:parent_id]
    @comments = Comment.where(parent_id:, parent_type:)
  end

  # def index_direct_comments

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment ||= Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to helpers.build_new_comment_path(@comment.parent, current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def build_new_comment
    parent_id = comment_params[:parent_id]
    parent_type = comment_params[:parent_type]
    creator = current_user
    @comment = Comment.new(parent_id:, parent_type:, creator:)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, :parent_id, :parent_type, :likes_count)
  end
end
