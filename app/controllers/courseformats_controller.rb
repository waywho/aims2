class CourseformatsController < ApplicationController
	 before_action :set_courseformat, only: [:show, :edit, :update, :destroy]

	  # GET /courseformats
	  # GET /courseformats.json
	  def index
	    @courseformats = Courseformat.published_now.rank(:row_order)
	  end

	  # GET /courseformats/1
	  # GET /courseformats/1.json
	  def show
	  	@courses = Course.published_now.rank(:row_order)
	  end

	  # GET /courseformats/new
	  # def new
	  #   @courseformat = Courseformat.new
	  # end

	  # GET /courseformats/1/edit
	  # def edit
	  # end

	  # # POST /courseformats
	  # # POST /courseformats.json
	  # def create
	  #   @courseformat = CourseFormat.new(courseformat_params)

	  #   respond_to do |format|
	  #     if @courseformat.save
	  #       format.html { redirect_to @courseformat, notice: 'Course format was successfully created.' }
	  #       format.json { render :show, status: :created, location: @courseformat }
	  #     else
	  #       format.html { render :new }
	  #       format.json { render json: @courseformat.errors, status: :unprocessable_entity }
	  #     end
	  #   end
	  # end

	  # # PATCH/PUT /courseformats/1
	  # # PATCH/PUT /courseformats/1.json
	  # def update
	  #   respond_to do |format|
	  #     if @courseformat.update(courseformat_params)
	  #       format.html { redirect_to @courseformat, notice: 'Course format was successfully updated.' }
	  #       format.json { render :show, status: :ok, location: @courseformat }
	  #     else
	  #       format.html { render :edit }
	  #       format.json { render json: @courseformat.errors, status: :unprocessable_entity }
	  #     end
	  #   end
	  # end

	  # # DELETE /courseformats/1
	  # # DELETE /courseformats/1.json
	  # def destroy
	  #   @courseformat.destroy
	  #   respond_to do |format|
	  #     format.html { redirect_to courseformats_url, notice: 'Course format was successfully destroyed.' }
	  #     format.json { head :no_content }
	  #   end
	  # end

	  private
	    # Use callbacks to share common setup or constraints between actions.
	    def set_courseformat
	      @courseformat = Courseformat.friendly.find(params[:id])
	    end

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def courseformat_params
	      params[:courseformat]
	    end
end
