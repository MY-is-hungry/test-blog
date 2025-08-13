class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by!(name: params[:name].to_s.downcase)
    @posts = @tag.posts.recent
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to @tag, notice: "Tag was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tag = Tag.find_by!(name: params[:name].to_s.downcase)
  end

  def update
    @tag = Tag.find_by!(name: params[:name].to_s.downcase)
    if @tag.update(tag_params)
      redirect_to @tag, notice: "Tag was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag = Tag.find_by!(name: params[:name].to_s.downcase)
    @tag.destroy
    redirect_to tags_path, notice: "Tag was successfully deleted."
  end

  private

  def search
    @tags = Tag.search(params[:query])
  end
end
