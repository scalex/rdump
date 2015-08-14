configure do
  set :server, :puma
  Mongoid.load! "./database.yml", :production
end

class Mail
  include Mongoid::Document

  field :message_id, type: String
  field :raw, type: Hash
end

class RDump < Sinatra::Base
  get "/" do
    halt 418
  end

  post "/catch" do
    request.body.rewind
    data = Oj.load(request.body.read)
    Mail.create message_id: "pre", raw: data
    status 200
  end
end
