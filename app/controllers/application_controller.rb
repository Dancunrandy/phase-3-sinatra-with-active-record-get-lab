class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    set :public_dir, 'public'
    set :database, { adapter: "sqlite3", database: "db/bakery.db" }
    set :show_exceptions, false
  end

  not_found do
    status 404
    erb :error
  end

  error do
    status 500
    erb :error
  end

  get '/' do
    erb :index
  end

  get '/bakeries' do
    content_type :json
    bakeries = Bakery.all
    bakeries.to_json(include: :baked_goods)
  end

  get '/bakeries/:id' do
    content_type :json
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    content_type :json
    baked_goods = BakedGood.order(price: :desc)
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    content_type :json
    baked_good = BakedGood.order(price: :desc).first
    baked_good.to_json
  end
end
