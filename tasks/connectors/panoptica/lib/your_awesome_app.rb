class YourAwesomeApp

  def call(env)
    response = Rack::Response.new
    response.write 'OK'
    response.status = 200
    response.finish
  end

end
