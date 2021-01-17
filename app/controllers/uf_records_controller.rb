class UfRecordsController < ApplicationController

  # GET /uf_records
  def request_data
  
    if params[:uf_date].match?('^\d{2}-\d{2}-\d{4}$')    #Validate date format

      @uf_value = request_api_ext("https://mindicador.cl/api/uf/", params[:uf_date])

      if @uf_value['serie'][0].present?
        redirect_to action: :create, params: { uf_record: { client: request.headers["X-CLIENT"], resquest_date: params[:uf_date], uf_value: @uf_value['serie'][0]['valor'] } }
      else
        render json: { msg: "Info doesn't exist, try with a valid date"}
      end
      
    else
      render json: { msg: "Date format must be dd-mm-yyyy"}
    end
    
  end

  def create
    @uf_record = UfRecord.new(uf_record_params)

    if @uf_record.save
      render json: @uf_record[:uf_value]
    else
      render json: @uf_record.errors, status: :unprocessable_entity
    end
  end

  def client
    @client_requests = UfRecord.where(client: params[:client])

    if @client_requests.present?
      render json: @client_requests.count
    else
      render json: { msg: "Client not found"}
    end   
  end


  private
    # Only allow a list of trusted parameters through.
    def uf_record_params
      params.require(:uf_record).permit(:client, :resquest_date, :uf_value)
    end

    #Generic resquest API
    def request_api_ext (url_requested, request_date)
      url_builded = url_requested + request_date
  
      url = URI(url_builded)
  
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
  
      request = Net::HTTP::Get.new(url)
  
      response = https.request(request)
  
      JSON.parse(response.read_body)
    end
end
