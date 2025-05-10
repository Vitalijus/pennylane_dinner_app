class PagesController < ApplicationController
  require "./app/services/elasticsearch/ingridients_query.rb"

  def home
    # binding.pry
    # if params[:ingredients].present?
      elasticsearch = Elasticsearch::IngridientsQuery.new(params[:ingredients])
      elasticsearch.response
      @recipes = elasticsearch.result
      # binding.pry

    # else
    #   format.html { render :home, status: :unprocessable_entity }
    # end
    # else
    #   redirect_back fallback_location: root_url
    # end

    # elasticsearch.errors if elasticsearch.errors.present?

    # respond_to do |format|
    #   if elasticsearch.errors.present?
    #     format.html { redirect_to root_url, notice: "Vehicle was successfully created." }
    #     # format.json { render :show, status: :created, location: @vehicle }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @vehicle.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  private

  def page_params
    params.require(:page).permit(:ingredients)
  end
end
