class ContactsController < UserSettingController

  def show
    @contact = current_user.contact || Contact.new(user_id: current_user.id)
  end

  def create
    @contact = Contact.new(contact_params)
    unless @contact.save
      return render :show
    end
    redirect_to contact_path
  end

  def update
    @contact = current_user.contact
    unless @contact.update(contact_params)
      return render :show
    end
    redirect_to contact_path

  end

  private
    def contact_params
      params.require(:contact).permit(
        :first_name,
        :last_name,
        :phone_number,
        :company,
        :company_name
      ).merge(user_id: current_user.id)
    end
end
