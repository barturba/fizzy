class Cards::Comments::ReactionsController < ApplicationController
  include CardScoped

  before_action :set_comment

  def index
  end

  def new
  end

  def create
    @reaction = @comment.reactions.create!(params.expect(reaction: :content))

    respond_to do |format|
      format.turbo_stream
      format.json { head :created }
    end
  end

  def destroy
    @reaction = @comment.reactions.find(params[:id])

    if Current.user != @reaction.reacter
      head :forbidden
    else
      @reaction.destroy

      respond_to do |format|
        format.turbo_stream
        format.json { head :no_content }
      end
    end
  end

  private
    def set_comment
      @comment = @card.comments.find(params[:comment_id])
    end
end
