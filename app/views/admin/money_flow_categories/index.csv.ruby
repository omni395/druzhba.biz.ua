require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::MoneyFlowCategory.human_attribute_name(:id),
    Admin::MoneyFlowCategory.human_attribute_name(:title),
    Admin::MoneyFlowCategory.human_attribute_name(:description),
    Admin::MoneyFlowCategory.human_attribute_name(:flow),
    Admin::MoneyFlowCategory.human_attribute_name(:created_at),
    Admin::MoneyFlowCategory.human_attribute_name(:updated_at),
  ]
  # set body rows
  @money_flow_categories.each do |money_flow_category|
    csv << [
      money_flow_category.id,
      money_flow_category.title,
      money_flow_category.description,
      money_flow_category.flow_i18n,
      money_flow_category.created_at,
      money_flow_category.updated_at,
    ]
  end
end