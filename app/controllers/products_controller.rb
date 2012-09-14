
class ProductsController < ApplicationController
  helper_method :sort_column, :sort_direction, :sort_column2
  before_filter :logged_in?
  autocomplete :product, :name,:full => true
  # GET /products
  # GET /products.json
  def index
    @quantities = Product.search(params[:search])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
    if params[:product][:min_quantity].blank?
      params[:product][:min_quantity] = -1
    end
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, :notice => 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_info_path }
      format.json { head :no_content }
    end
  end

def pre_move
end

def move
    @to_storage = params[:to_storage]
    @from_storage = params[:from_storage]
    if @to_storage == @from_storage
      redirect_to products_pre_move_path, :notice => "Cant move from/to the same storage!"
      return
    elsif !Storage.where(:id => @to_storage.to_s).exists? or !Storage.where(:id => @from_storage.to_s).exists?
      redirect_to products_pre_move_path, :notice => "One of the Storages you inputted doesn't exist!"
      return
    end
    @quantities = Quantity.where(:storage => params[:from_storage])
   # @quantities.sort! { |a,b| a.product.name <=> b.product.name }
    respond_to do |format|
      format.html
      format.json { render :json => @products }
    end
end

def move_multiple
    @the_params = "" 
  if params[:quantity_ids] == nil
    redirect_to products_pre_move_path, :notice => "You haven't checked any product!"
    return
  end
  @quantities = Quantity.find(params[:quantity_ids])
  @quantities.each do |quantity|
    if params[:quantities][quantity.id.to_s][:amount].to_i > quantity.amount
      redirect_to products_pre_move_path, :notice => "Cant move more than the current amount!"
      return
    elsif params[:quantities][quantity.id.to_s][:amount].to_i == 0
    redirect_to products_pre_move_path, :notice => "You can only enter numbers > 0 in the amount field!"
    return
    end
    #check if asked to move more than available
    @product_destination = Product.find(quantity.product.id)
    @quantity_destination = @product_destination.quantities.where(:storage => params[:to_storage]).first
    if @quantity_destination == nil
      #no such quantity in storage destination
      if params[:quantities][quantity.id.to_s][:amount].to_i == quantity.amount
        #if we moved all of the amount and there isnt already an amount in the new storage
        #logger.info params[:to_storage].inspect
        quantity.update_attribute(:storage, params[:to_storage])
      else
        #if we hadn't moved all of the amount and there isnt already an amount in the new storage
        amount_to_leave = quantity.amount - params[:quantities][quantity.id.to_s][:amount].to_i
        quantity.update_attribute(:amount, amount_to_leave)
        @new_quantity = @product_destination.quantities.build(:storage => params[:to_storage], :amount => params[:quantities][quantity.id.to_s][:amount].to_i)
        @new_quantity.save
      end
    else
      #there is such quantity in storage destination
      @quantity_destination.update_attribute(:amount, (@quantity_destination.amount + params[:quantities][quantity.id.to_s][:amount].to_i))
      if params[:quantities][quantity.id.to_s][:amount].to_i == quantity.amount  
        quantity.destroy
      else
        quantity.update_attribute(:amount, quantity.amount - params[:quantities][quantity.id.to_s][:amount].to_i)
      end
    end
    #quantity.update_attributes!(params[:product].reject { |k,v| v.blank? })
   #logger.info params[:quantities][quantity.id.to_s].inspect
   @the_params += "Moved " + params[:quantities][quantity.id.to_s][:amount] + 
   " For Product: " + quantity.product.name + " " + quantity.product.size + ", "
  end
  @the_params += " From Storage " +  Storage.find(params[:from_storage]).name + " To Storage " + Storage.find(params[:to_storage]).name
  @trans = Transaction.new(:operationtype => "Move Stock", :reason => params[:reason], :info => @the_params)
  @trans.save

  flash[:notice] = "Moved the products!"
  redirect_to products_path
end


  # GET /items/new
  # GET /items/new.json
  def new
    @product = Product.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @item }
    end
  end


def pre_remove
end

def remove
  @from_storage = params[:from_storage]

  @quantities = Quantity.where(:storage => params[:from_storage])
  #@quantities.sort! { |a,b| a.product.name <=> b.product.name }
  respond_to do |format|
    format.html
    format.json { render :json => @products }
  end
end


def remove_multiple
  @the_params = "" 
  if params[:quantity_ids] == nil
    redirect_to products_pre_remove_path, :notice => "You haven't checked any product!"
    return
  end
  @quantities = Quantity.find(params[:quantity_ids])
  @quantities.each do |quantity|
    if params[:quantities][quantity.id.to_s][:amount].to_i > quantity.amount
      redirect_to products_pre_remove_path, :notice => "Cant remove more than the current amount!"
      return
    elsif params[:quantities][quantity.id.to_s][:amount].to_i == 0
    redirect_to products_pre_remove_path, :notice => "You can only enter numbers > 0 in the amount field!"
    return
    end
    if params[:quantities][quantity.id.to_s][:amount].to_i == quantity.amount
      quantity.destroy
    else
      amount_to_leave = quantity.amount - params[:quantities][quantity.id.to_s][:amount].to_i
      quantity.update_attribute(:amount, amount_to_leave)
    end
    @the_params += "Removed " + params[:quantities][quantity.id.to_s][:amount] + 
     " For Product: " + quantity.product.name + " " + quantity.product.size + ", "
  end
  @the_params += " From Storage " +  Storage.find(@quantities.first.storage).name
  @trans = Transaction.new(:operationtype => "Remove Stock", :reason => params[:reason], :info => @the_params)
  @trans.save  
  flash[:notice] = "Removed the stock!"
  redirect_to products_path
end



  def create
    @product = Product.new(params[:product])
    if params[:product][:name].blank? and params[:product][:ppd_code].blank? and params[:product][:supplier_code].blank? 
      redirect_to(products_path)
      return
    end
    if params[:product][:min_quantity].blank?
      @product.min_quantity = -1
    end
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_info_path, :notice => 'Product was successfully created.' }
        format.json { render :json => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def info
    @products = Product.order(sort_column2 + " " + sort_direction)
    @good_items = []
    @bad_items = []
    @products.each do |prod|
      if prod.min_quantity != nil
        temp_sum = 0
        prod.quantities.each do |quant|
          if Storage.find(quant.storage).name.downcase != "packing room"
            temp_sum += quant.amount
          end
        end
        if temp_sum >= prod.min_quantity
          @good_items << prod
        else
          @bad_items << prod
        end
      end
    end
    @final_products = @bad_items + @good_items
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @products }
    end
  end

private

 def sort_column
    if params[:sort] == "amount" or params[:sort] == "products.ppd_code" or params[:sort] == "products.supplier_code"
      params[:sort]
    else
      "products.name"
    end
  end

 def sort_column2
    if params[:sort] == "ppd_code" or params[:sort] == "supplier_code" or params[:sort] == "size"
      params[:sort]
    else
      "name"
    end
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end
