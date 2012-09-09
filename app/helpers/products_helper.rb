module ProductsHelper


  
  def show_storage_items(storage_num)
  storage_items = Quantity.where(:storage => storage_num)
  return storage_items
  end
end
