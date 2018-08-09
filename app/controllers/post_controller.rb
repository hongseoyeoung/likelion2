class PostController < ApplicationController
  def index
    
    checkParam
    @p = params

  end
