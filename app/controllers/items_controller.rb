class ItemsController < ApplicationController
  before_filter :logged_in?
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @item }
    end
  end

  def pre_new

    respond_to do |format|
      format.html # pre_new.html.erb
      format.json { render :json => @items }
    end
  end


  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new
    @amount_form = params['amount']
    @storage_form = params['storage']
    @amount_form.to_i.times do
      product = @item.products.build
      product.quantities.build
      product.quantities.each do |quant|
        quant.storage = @storage_form
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
 def create

    @item = Item.new(params[:item])

    respond_to do |format|
    if @item.valid?
        

    @prods_hash = params[:item][:products_attributes]

    @prods_hash.keys.each do |key|
      next if ( @prods_hash[key][:name].to_s == "" and @prods_hash[key][:supplier_code].to_s == "" and @prods_hash[key][:ppd_code].to_s == "" )
      @quants_hash = @prods_hash[key][:quantities_attributes]
      
      @quants_hash.keys.each do |key2|
        if @prods_hash[key][:name] != ""
          @right_param = @prods_hash[key][:name]
        elsif @prods_hash[key][:supplier_code] != ""
          @right_param = @prods_hash[key][:supplier_code]
        elsif @prods_hash[key][:ppd_code] != ""
          @right_param = @prods_hash[key][:ppd_code]
        else
          #We are fucked, contact site admin
        end
        @find_prod = Product.find(:first, :conditions => ["id = ?",@right_param])
        if @find_prod != nil         
          @quants = @find_prod.quantities
          #if quants is empty or nil? (added product no quants yet) will the for loop work? Update: I think its ok
          @quants.each do |q|
            if q.storage == @quants_hash[key2][:storage].to_i
              q.amount += @quants_hash[key2][:amount].to_i
              q.save!
              redirect_to(products_path)
              return
            end
          end
          @new_quantity = @find_prod.quantities.build(:storage => @quants_hash[key2][:storage].to_i, :amount => @quants_hash[key2][:amount].to_i)
          @new_quantity.save
        else
          #we are fucked
          We are fucked! If you have reached here please contact someone.
          redirect_to(products_path)
          return
        end
          #@pp = Product.new(@prods_hash[key])
          #@pp.save
      end
    end
    redirect_to(products_path)
    return
      else
        format.html { render :action => "new" }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, :notice => 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end

