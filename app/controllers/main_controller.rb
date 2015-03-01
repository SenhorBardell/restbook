class MainController < ApplicationController
  def root
    render text: "<h1>Hello World!</h1>"
  end
end