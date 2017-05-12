require "bundler/setup"
Bundler.require :default

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

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
  capture_boxes(store)
  redirect "/store/#{store.id}"
end

patch "/store" do
  store_id = params.fetch("store-id")
  updated_name = params.fetch("store-name")
  store = Store.find(store_id)
  store.update({name: updated_name})
  store.shoes.destroy_all
  capture_boxes(store)
  redirect "/store/#{store.id}"
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

