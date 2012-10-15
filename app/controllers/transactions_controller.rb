class TransactionsController < ApplicationController
  before_filter :logged_in?
  def index
    @transactions = Transaction.order("created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @storages }
    end
  end

  def sales
  	@sales = Sales.order("name")

  	respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @storages }
    end
  end

  def sales_search
  	if params[:sal][:fromDate] != "" and params[:sal][:toDate] != ""
  	@fromDate = Date.strptime(params[:sal][:fromDate], "%m/%d/%Y")
  	@toDate = Date.strptime(params[:sal][:toDate], "%m/%d/%Y")
  	#"sal"=>{"toDate"=>"10/25/2012", "fromDate"=>"10/05/2012"}
  	@sales_search = Sales.find(:all, :conditions => {:created_at => @fromDate.beginning_of_day..@toDate.end_of_day }, :order => "name")
    else
    redirect_to transactions_sales_path
    return
    end
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @storages }
    end
  end

end