class PublicController < ApplicationController
  layout 'public'

  def about
  end

  def contact
  end

  def index
    @works = Work.visible.sorted
  end

  def show
    @work = Work.find(params[:id])
    unless @work.visible
      redirect_to action: :index
    end
    @pictures = @work.pictures.sorted
    @process_picture_count = @work.process_pictures.count
  end

  def show_process
    @work = Work.find(params[:id])
    unless @work.visible
      redirect_to action: :index
    end
    @pictures = @work.process_pictures.sorted
    render 'show'
  end
end
