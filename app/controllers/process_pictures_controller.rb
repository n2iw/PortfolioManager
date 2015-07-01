class ProcessPicturesController < ApplicationController
  layout 'admin'
  
  before_action :confirm_logged_in
  before_action :find_work
  before_action :find_process_picture, except: [:create, :index]
  before_action :get_hit_counts

  def create
    if params[:files]
      params[:files].each do |picture|
        @work.process_pictures.create file: picture
      end
      flash[:success] = "#{params[:files].count} Pictures added!"
    end

    redirect_to work_process_pictures_path params[:work_id]
  end

  def index
    @picture = @work.process_pictures.build
    @pictures = @work.process_pictures.sorted
    @picture_count = @pictures.count + 1
  end

  def update
    if @picture.update_attributes(picture_params)
      flash[:success] = "Picture updated!"
      redirect_to work_process_pictures_path params[:work_id]
    else
      flash[:error] = "Update picture failed!"
      redirect_to work_process_pictures_path params[:work_id]
    end
  end

  def delete
    render 'pictures/delete'
  end

  def destroy
    flash[:alert] = "Picture #{@picture.file_file_name} deleted!"
    @picture.destroy
    redirect_to work_process_pictures_path params[:work_id]
  end

  private
    def picture_params
      params.require(:process_picture).permit(:id, :file, :position)
    end

    def find_work
      @work = Work.find(params[:work_id])
    end

    def find_process_picture
      @picture = ProcessPicture.find params[:id]
    end
end
