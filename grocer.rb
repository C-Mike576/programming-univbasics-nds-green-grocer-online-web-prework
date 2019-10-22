require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
   item_index = 0
   while item_index < collection.length do
     if collection[item_index][:item] == name
       return collection[item_index]
     end
     item_index += 1
   end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  fill_basket = []
  item_index = 0
  
  while item_index < cart.length do
    #binding.pry
    basket_index = 0
    
    if fill_basket.length == 0
      fill_basket << Marshal.load(Marshal.dump(cart[item_index]))
    end
      while basket_index < fill_basket.length do
        #binding.pry
        if fill_basket[basket_index].has_value?(cart[item_index][:item]) && fill_basket[basket_index].has_key?(:count)
          fill_basket[basket_index][:count] += 1
        elsif fill_basket[basket_index].has_value?(cart[item_index][:item])
        fill_basket[basket_index][:count] = 1
        else
          fill_basket << Marshal.load(Marshal.dump(cart[item_index]))
        end
      basket_index += 1
    end
   item_index += 1
 end
 #binding.pry
  fill_basket.uniq
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupon_count = 0 
  while coupon_count < coupons.length do
    item_index = 0
    item_edit = {}
    while item_index < cart.length do
      if cart[item_index].has_value?(coupons[coupon_count][:item]) && cart[item_index][:count] >=
        coupons[coupon_count][:num]
        
        item_edit = Marshal.load(Marshal.dump(cart[item_index]))
        item_edit[:item] = "#{cart[item_index][:item]} W/COUPON"
        item_edit[:price] = coupons[coupon_count][:cost]/coupons[coupon_count][:num]
        item_edit[:count] = coupons[coupon_count][:num]
        cart[item_index][:count] -= coupons[coupon_count][:num]
        cart << item_edit
        #binding.pry
      else
      item_index += 1
      end
      
    end
    coupon_count += 1
  end
   cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  item_index = 0
  while item_index < cart.length do
    if cart[item_index][:clearance] == true
      cart[item_index][:price] = cart[item_index][:price]-(cart[item_index][:price]*0.2).round(1)
      #binding.pry
    end
    item_index += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  p cart
  p coupons
  #binding.pry
  total = 0
  item_index = 0
  if cart[item_index].has_key?(:count)
    return total += (cart[item_index][:price]*cart[item_index][:count])
  end
  cart = consolidate_cart(cart)
  #binding.pry
  cart = apply_coupons(cart, coupons)
  #binding.pry
  cart = apply_clearance(cart)
  #binding.pry
  
  
  p cart
  while item_index < cart.length do
    #binding.pry
    total += (cart[item_index][:price]*cart[item_index][:count])
    item_index += 1
  end
  if total >= 100
    total = total - (total*0.1).round(2)
  end
  #binding.pry
  p total.round(2)

end
