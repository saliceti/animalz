class OrderRecordsController < ApplicationController
  before_action :set_order_record, only: [:show, :edit, :update, :destroy]

  # GET /order_records
  # GET /order_records.json
  def index
    @order_records = OrderRecord.all
  end

  # GET /order_records/1
  # GET /order_records/1.json
  def show
  end

  # GET /order_records/new
  def new
    @order_record = OrderRecord.new
  end

  # GET /order_records/1/edit
  def edit
  end

  # POST /order_records
  # POST /order_records.json
  def create
    @order_record = OrderRecord.new(order_record_params)

    respond_to do |format|
      if @order_record.save
        format.html { redirect_to @order_record, notice: 'Order record was successfully created.' }
        format.json { render :show, status: :created, location: @order_record }
      else
        format.html { render :new }
        format.json { render json: @order_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_records/1
  # PATCH/PUT /order_records/1.json
  def update
    respond_to do |format|
      if @order_record.update(order_record_params)
        format.html { redirect_to @order_record, notice: 'Order record was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_record }
      else
        format.html { render :edit }
        format.json { render json: @order_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_records/1
  # DELETE /order_records/1.json
  def destroy
    @order_record.destroy
    respond_to do |format|
      format.html { redirect_to order_records_url, notice: 'Order record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_record
      @order_record = OrderRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_record_params
      params.require(:order_record).permit(:name, :description, :class_record_id)
    end
end
