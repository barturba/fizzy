class Cards::ClosuresController < ApplicationController
  include CardScoped

  def create
    @card.close(user: Current.user)

    respond_to do |format|
      format.turbo_stream { render_card_replacement }
      format.json { head :no_content }
    end
  end

  def destroy
    @card.reopen(user: Current.user)

    respond_to do |format|
      format.turbo_stream { render_card_replacement }
      format.json { head :no_content }
    end
  end
end
