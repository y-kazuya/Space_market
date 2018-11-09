class PaymentsController < UserSettingController

  def show
    @cards = current_user.cards
  end

  def new
    if params[:id]
      @card = Card.find(params[:id])
      return redirect_to root_path unless @card.user_id == current_user.id
    else
      @card = Card.new()
    end
  end

  def create
    @card = Card.new(card_params)
    unless @card.save
      return render :new
    end
    Card.where(user_id: current_user.id).update_all(use: 0)
    @card.update(use: 1)
    redirect_to payments_path
  end

  def set_use
    card = Card.find(params[:id])
    if card.user_id == current_user.id
      Card.where(user_id: current_user.id).update_all(use: 0)
      card.update(use: 1)
      redirect_to payments_path
    else
      redirect_to root_path
    end
  end

  def update
    @card = Card.find(params[:id].to_i)
    if @card.user_id == current_user.id
      unless @card.update(card_params)
        return render :new
      end
      Card.where(user_id: current_user.id).update_all(use: 0)
      @card.update(use: 1)
      redirect_to payments_path
    else
      redirect_to root_path
    end
  end



  def destroy
    card = Card.find(params[:id])
    if card.user_id == current_user.id
      card.destroy
      redirect_to payments_path
    else
      redirect_to root_path
    end
  end

  private

    def card_params
      params.require(:card).permit(
        :num_first,
        :num_seconde,
        :num_thard,
        :num_last,
        :name,
        :mm,
        :yy,
        :code
      ).merge(user_id: current_user.id)
    end

end
