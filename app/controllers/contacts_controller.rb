class ContactsController < ApplicationController
  
  skip_before_action :authorize, only: [:new, :create, :show]
  
  before_action :set_contact, only: [:show, :edit, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.paginate(page: params[:page]).order('created_at DESC')
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    @contact.name = cookies[:client_name] unless cookies[:client_name].nil?
    @contact.email = cookies[:client_email] unless cookies[:client_email].nil?
    @contact.phone = cookies[:client_phone] unless cookies[:client_phone].nil?
    @contact.message = params[:product]
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        cookies[:client_name] = @contact.name
        cookies[:client_email] = @contact.email
        cookies[:client_phone] = @contact.phone
        format.html { redirect_to @contact, notice: 'Message was successfully sent.' }
        format.json { render action: 'show', status: :created, location: @contact }
      else
        format.html { render action: 'new' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :message)
    end
    
end
