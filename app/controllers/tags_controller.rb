class TagsController < ApplicationController
  def index
    @comments = Comment.All
  end

  def show
  @tag = Tag.find(params[:id])
end

end
