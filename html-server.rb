require 'rubygems'
require 'rack'


# only works for direct query to an html file e.g. http://localhost:1337/sample/index.html
# not for http://localhost:1337/sample/
class HtmlServer
  def call env
    begin
      file = open("#{Dir.pwd}#{env["REQUEST_PATH"]}")   # try to open the requested file, relative to this
      if file
        html = []
        file.each_line do |line|
          html << line
        end
        [200, {"Content-Type" => "text/html"}, html]    # render the html file if it exist
      end
    rescue
      [404, {"Content-Type" => "text/html"}, ["Not found buddy, sorry!"]] # Return a 404 error if not found
    end
  end
end

Rack::Handler::Mongrel.run HtmlServer.new, :Port => 1337
