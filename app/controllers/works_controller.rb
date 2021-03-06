class WorksController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_work, except: [:new, :create, :index, :statistics, :migrate_hit_counts, :manage_awards]

  def statistics
    get_hit_counts
    @works = Work.normal.sort_by do |work|
      - @work_hits[work.id]
    end
  end

  # migrate from old "work_xxx" category to new "xxx"
  def migrate_hit_counts
    all_hits = HitCount.all
    all_hits.each do |hit|
      if hit.cat.start_with? "work_"
        puts "Migrate: Category: \"#{hit.cat}\" is in old format!"
        new_cat = hit.cat.delete "work_"
        new_hit = HitCount.find_by_cat(new_cat)
        # if there is alread new category records
        if new_hit
          puts "Migrate: Category: \"#{new_cat}\" already exists, update it"
          # add old hits to new
          new_hit.hits += hit.hits
          puts "Migrate: Add #{hit.hits} hits to Category: \"#{new_cat}\""
          if new_hit.save
            puts "Migrate: Update Category: \"#{new_cat}\" success!"
            hit.destroy
            puts "Migrate: Category: \"#{hit.cat}\" destroyed"
          end
        # if there is no new category yet
        else
          puts "Migrate: rename old record"
          # rename category 
          hit.cat =  new_cat
          if hit.save
            puts "Migrate: rename success!"
          end
        end
      else
        puts "Migrate: Category: \"#{hit.cat}\" looks OK, nothing to do with it"
      end
    end
    redirect_to action: :statistics
  end

  def new
    @work = Work.new
    @work_count = Work.normal.count + 1
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "New Work #{@work.name} created!"
      create_pictures
      redirect_to edit_work_path(@work.id)
    else
      flash[:error] = "Create new work failed!"
      @work_count = Work.normal.count + 1
      render 'new'
    end
  end

  def index
    @works = Work.normal.sorted
    @work_count = Work.normal.count
  end

  def manage_awards
    @works = Work.awarded.sorted
    @work_count = Work.awarded.count
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
      if @work.award
        flash[:success] = "Award: #{@work.name} updated!"
        redirect_to action: :manage_awards
      else
        flash[:success] = "Work: #{@work.name} updated!"
        redirect_to action: :index
      end
    else
      if @work.award
        flash[:error] = "Award: #{@work.name} update failed!"
        redirect_to action: :manage_awards
      else
        flash[:error] = "Work: #{@work.name} update failed!"
        redirect_to action: :index
      end
    end
  end
  
  def delete
  end

  def destroy
    @work.destroy
    if @work.award
      flash[:alert] = "Award: #{@work.name} deleted!"
      redirect_to action: :manage_awards
    else
      flash[:alert] = "Work: #{@work.name} deleted!"
      redirect_to action: :index
    end
  end


  private
    def work_params
      params.require(:work).permit(:name, :thumbnail, :position, :visible, :description, :award)
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
      @work_count = Work.normal.count
      @pictures = @work.pictures.sorted
      @process_pictures = @work.process_pictures.sorted
    end

    def get_hit_counts
      @overall_hits = HitCount.find_by_cat('all').hits
      @unique_visitors = HitCount.find_by_cat('unique').hits
      @work_hits = Hash.new(0)
      @page_hits = {}
      @total_work_hits = 0
      HitCount.all.each do |hit|
        if hit.cat =~ /\d+/
          @work_hits[hit.cat.to_i] = hit.hits.to_i
          @total_work_hits += hit.hits.to_i
        else
          unless hit.cat == 'all' || hit.cat == 'unique'
            @page_hits[hit.cat] = hit.hits.to_i
          end
        end
      end
    end
end
