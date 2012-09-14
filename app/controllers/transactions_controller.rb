class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.order("created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @storages }
    end
  end

end