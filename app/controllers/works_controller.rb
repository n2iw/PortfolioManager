class WorksController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_work, except: [:new, :create, :index]
  before_action :get_hit_counts

  def new
    @work = Work.new
    @work_count = Work.count + 1
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "New Work #{@work.name} created!"
      create_pictures
      redirect_to edit_work_path(@work.id)
    else
      flash[:error] = "Create new work failed!"
      @work_count = Work.count + 1
      render 'new'
    end
  end

  def index
    @works = Work.sorted
    @work_count = Work.count
  end

  def show
    @pictures = @work.pictures.sorted
    @process_picture_count = @work.process_pictures.count
  end

  def show_process
    @pictures = @process_pictures
    render 'show'
  end

  def edit
  end

  def update
    if @work.update_attributes(work_params)
      flash[:success] = "Work: #{@work.name} updated!"
      create_pictures
      redirect_to action: :show
    else
      flash[:error] = "Work: #{@work.name} update failed!"
      render 'edit'
    end
  end

  def update_position
    if @work.update_attributes(work_params)
      flash[:success] = "Work: #{@work.name} updated!"
      redirect_to action: :index
    else
      flash[:error] = "Work: #{@work.name} update failed!"
      redirect_to action: :index
    end
  end

  def delete
  end

  def destroy
    @work.destroy
    flash[:alert] = "Work: #{@work.name} deleted!"
    redirect_to action: :index
  end


  private
    def work_params
      params.require(:work).permit(:name, :thumbnail, :position, :visible, :description)
    end

    def create_pictures
      if params[:pictures]
        params[:pictures].each do |picture| 
          @work.pictures.create(file: picture)
        end
      end

      if params[:process_pictures]
        params[:process_pictures].each do |picture| 
          @work.process_pictures.create(file: picture)
        end
      end
    end

    def find_work
      @work = Work.find params[:id]
      @work_count = Work.count
      @pictures = @work.pictures.sorted
      @process_pictures = @work.process_pictures.sorted
    end
end
