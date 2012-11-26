class MembersController < ApplicationController
  helper_method :sort_column, :sort_direction 
  # GET /members
  # GET /members.json
  def index
    update_filter
    if params[:filter] == "0"
      @members = Member.order(sort_column + " " + sort_direction)
    else
      @members = Member.where(status_id: params[:filter].to_i).order(sort_column + " " + sort_direction)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  def directory

    @members = Member.where(status_id: 1).order("last_name")
    @conductor = Member.find(85)
    @conductor_address = { title: "First Community Church", address: "1320 Cambridge Blvd.", city: "Columbus" ,state: "OH", zip: 43212}
    @accompanist = Member.find(84)
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new
    @member.phone_numbers.build
    @member.email_addresses.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(params[:member])

    respond_to do |format|
      if @member.save
        if params[:member][:photo].blank?
          format.html { redirect_to @member, notice: "#{@member.first_name} #{@member.last_name} was added successfully." }
          format.json { render json: @member, status: :created, location: @member }
        else
          format.html {render action: "crop"}
        end
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        if new_photo
          #TODO:add check for cropping here, then reprocess member photo if needed using @member.photo.reprocess!
          format.html {render action: "crop"}
        #elsif !params[:member][:crop_x].blank? && !params[:member][:crop_y].blank? && !params[:member][:crop_h].blank? && !params[:member][:crop_w].blank? 
      
          #if the crop parameters exist process the photo
          #@member.reprocess_photo

          #format.html { redirect_to @member, notice: 'Photo was cropped.' }
          #format.json { head :no_content }
        elsif !params[:member][:crop_x].blank?
          @member.reprocess_photo
          format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        else
          #the default case is !new_photo && !cropping
          format.html { redirect_to @member, notice: 'Member was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url, notice: "#{@member.first_name} #{@member.last_name} was removed." }
      format.json { head :no_content }
    end
  end

  def check_pictures
    @members = Member.all
    @members.each do |member|
      member.picture = picture_status(member)
      member.save
    end 
    flash[:success] = "Updated picture status"
    redirect_to members_path
  end
      

  private
    
    def cropping
      !params[:member][:crop_x].blank? && !params[:member][:crop_y].blank? && !params[:member][:crop_h].blank? && !params[:member][:crop_w].blank? 
    end

    def new_photo
      !params[:member][:photo].blank?
    end

    def sort_column
      Member.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def update_filter
      unless %w[0 1 2 3 4].include?(params[:filter]) 
        params[:filter] = "0"
      end
    end

    def picture_status(member)
      status = Rails.application.assets.find_asset("Pics/#{member.id}.jpg").nil? ? false : true
    end
end
