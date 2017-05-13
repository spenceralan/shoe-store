require "bundler/setup"
Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

enable :session

helpers do
  def capture_boxes(store)
    params.fetch("shoes", []).each do |shoe|
      store.shoes.push(Shoe.find(shoe['id']))
    end
  end
end

get "/" do
  @shoes = Shoe.all
  @stores = Store.all
  erb :index
end

#stores

get "/store/add" do
  @shoes = Shoe.all
  erb :store_add
end

get "/store/:id/edit" do
  store_id = params.fetch("id")
  @store = Store.find(store_id)
  @shoes = Shoe.all
  erb :store_edit
end

post "/store" do
  store_name = params.fetch("store-name")
  store = Store.create({name: store_name})
  if store.errors.any? == true
    session[:error] = store.errors.full_messages.first
    erb :error
  else
    capture_boxes(store)
    redirect "/store/#{store.id}"
  end
end

patch "/store" do
  store_id = params.fetch("store-id")
  updated_name = params.fetch("store-name")
  store = Store.find(store_id)
  store.update({name: updated_name})
  store.shoes.destroy_all
  if store.errors.any? == true
    session[:error] = store.errors.full_messages.first
    erb :error
  else
    capture_boxes(store)
    redirect "/store/#{store.id}"
  end
end

delete "/store" do
  store_id = params.fetch("store-id")
  @store = Store.find(store_id)
  @store.destroy
  redirect "/"
end

get "/store/:id" do
  store_id = params.fetch("id")
  @store = Store.find(store_id)
  erb :store
end

#shoes

get "/shoes/add" do
  @shoes = Shoe.all
  erb :shoe_add
end

get "/shoes/:id/edit" do
  shoe_id = params.fetch("id")
  @shoe = Shoe.find(shoe_id)
  @shoes = Shoe.all
  erb :shoe_edit
end

post "/shoes" do
  shoe_name = params.fetch("shoe-name")
  shoe_price = params.fetch("shoe-price", 0)
  shoe = Shoe.create({name: shoe_name, price: shoe_price})
  if shoe.errors.any? == true
    session[:error] = shoe.errors.full_messages.first
    erb :error
  else
    redirect "/shoes/#{shoe.id}"
  end
end

patch "/shoes" do
  shoe_id = params.fetch("shoe-id")
  shoe_name = params.fetch("shoe-name")
  shoe_price = params.fetch("shoe-price", 0)
  shoe = Shoe.find(shoe_id)
  shoe.update({name: shoe_name, price: shoe_price})
  if shoe.errors.any? == true
    session[:error] = shoe.errors.full_messages.first
    erb :error
  else
    redirect "/shoes/#{shoe.id}"
  end
end

delete "/shoes" do
  shoe_id = params.fetch("shoe-id")
  @shoe = Shoe.find(shoe_id)
  @shoe.destroy
  redirect "/"
end

get "/shoes/:id" do
  shoe_id = params.fetch("id")
  @shoes = Shoe.find(shoe_id)
  erb :shoe
end