# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action { @page_title = 'Послуги швейної майстерні ☞ДРУЖБА☜ у Кривому Розі' }
  before_action { @page_description }

  caches_page :index, :show, gzip: :best_speed

  def index
    @services = Service.order(id: :asc)

    @schemas = SchemaDotOrg::ItemList.new(
      #name: 'Список наших услуг',
      #description: 'Полный перечень всех доступных услуг',
      itemListElement: @services.map.with_index(1) do |service, index|
        SchemaDotOrg::ListItem.new(
          position: index,
          item: SchemaDotOrg::Product.new(
            name: service.title,
            description: service.description,
            url: url_for(service),
            offers: SchemaDotOrg::AggregateOffer.new(
              lowPrice: service.price.to_i,
              highPrice: service.price.to_i,
              priceCurrency: 'RUB',
              offers: [
                SchemaDotOrg::Offer.new(
                  price: service.price.to_i,
                  priceCurrency: 'RUB',
                  availability: 'https://schema.org/InStock'
                )
              ]
            )
          )
        )
      end
    )

    if I18n.locale == :uk
      @page_title = '🌟 Послуги швейної майстерні ☞ДРУЖБА☜ (Ательє Кривий Ріг)'
      @page_description = 'Майстерня ☞ДРУЖБА☜ у Кривому Розі. Якісний ремонт будь-якої складності та індивідуальний пощив одягу'
    else
      @page_title = '🌟 Услуги швейной мастерской ☞ДРУЖБА☜ (Ателье Кривой Рог)'
      @page_description = 'Ателье ☞ДРУЖБА☜ в Кривом Роге. Качественный ремонт любой сложности и индивидуальный покров одежды'
    end
  end

  def show
    @service = Service.friendly.find(params[:id])

    @schema = SchemaDotOrg::Product.new(
      name: @service.title,
      description: @service.description,
      url: url_for(@service),
      offers: SchemaDotOrg::AggregateOffer.new(
        lowPrice: @service.price.to_i,  # Convert to integer, will be 0 if nil
        highPrice: @service.price.to_i, # Assuming the high price is the same as the low price
        priceCurrency: 'RUB',  # Assuming Russian Rubles, change if needed
        offers: [
          SchemaDotOrg::Offer.new(
            price: @service.price.to_i,
            priceCurrency: 'UAH',
            availability: 'https://schema.org/InStock'  # Adjust based on your business logic
          )
        ]
      )
    )

    @page_title = @service.subtitle
    @page_description = if I18n.locale == :uk
                          "Майстерня ☞ДРУЖБА☜ - #{@service.description}"
                        else
                          "Ателье ☞ДРУЖБА☜ -#{@service.description}"
                        end
  end
end
