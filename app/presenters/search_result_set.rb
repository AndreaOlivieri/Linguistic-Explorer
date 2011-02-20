class SearchResultSet
  include Enumerable

  def initialize(params)
    @params = params
  end

  def each
    results.each { |r| yield r }
  end

  def results
    select_lings.joins(:properties) & select_properties & select_lings_properties
  end

  private

  def select_lings
    Ling.select("lings.name AS ling_name, lings.id AS ling_id").where("lings.id in (?)", selected_ling_ids)
  end

  def select_properties
    Property.select("properties.name AS prop_name, properties.id AS prop_id").where("properties.id in (?)", selected_prop_ids)
  end

  def select_lings_properties
    LingsProperty.select("lings_properties.value AS value").where("lings_properties.id" => selected_lings_prop_ids)
  end

  def selected_ling_ids
    @params[:lings] || Ling.select("id")
  end

  def selected_prop_ids
    @params[:properties] || Property.select("id")
  end

  def selected_lings_prop_ids
    relation = LingsProperty.select("id")
    if @params[:lings_properties].present?
      pairs = @params[:lings_properties].map { |str| str.split(":") }
      conditions = pairs.inject({:id => nil}) do |conds, pair|
        conds | { :property_id => pair.first, :value => pair.last }
      end 
      relation = relation.where(conditions)
    end
    relation
  end

end