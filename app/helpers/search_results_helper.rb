module SearchResultsHelper
  include ActionView

  PARENT_COLUMNS = [
    :ling_0, :property_0, :value_0, :example_0
  ]

  CHILD_COLUMNS = [
    :ling_1, :property_1, :value_1, :example_1
  ]

  HEADERS = {
    :ling_0     => lambda { |g| g.ling0_name },
    :property_0 => lambda { |g| "#{g.ling0_name} #{g.property_name.pluralize.titleize}" },
    :value_0    => lambda { |g| "#{g.ling0_name} Values" },
    :example_0  => lambda { |g| "#{g.ling0_name} Examples" },
    :ling_1     => lambda { |g| g.ling1_name },
    :property_1 => lambda { |g| "#{g.ling1_name} #{g.property_name.pluralize.titleize}" },
    :value_1    => lambda { |g| "#{g.ling1_name} Values" },
    :example_1  => lambda { |g| "#{g.ling1_name} Examples" }
  }

  COLUMNS = PARENT_COLUMNS + CHILD_COLUMNS

  def columns_to_include
    @columns_to_include ||= @search.included_columns
  end

  def result_headers
    columns_to_include.map{ |k| HEADERS[k] }
  end

  def result_rows
    @result_rows ||= row_methods.map { |k| row_methods[k] }
  end

  def parent_columns
    @parent_columns ||= columns_to_include & PARENT_COLUMNS
  end

  def child_columns
    @child_columns ||= columns_to_include & CHILD_COLUMNS
  end

  def excluded_columns
    # {"ling_0"=>"1", "ling_1"=>"1", "prop"=>"1", "value"=>"1"}
    COLUMNS - @search.included_columns
  end

  def link_to_ling(ling)
    "<a href='/groups/#{current_group.to_param}/lings/#{ling.to_param}'>#{h(ling.name)}</a>".html_safe
  end

  def link_to_property(property)
    "<a href='/groups/#{current_group.to_param}/properties/#{property.to_param}'>#{h(property.name)}</a>".html_safe
  end

  def row_methods
    @row_methods ||= {
      :ling_0     => lambda { |v| link_to_ling(v.ling) },
      :ling_1     => lambda { |v| link_to_ling(v.ling) },
      :property_0 => lambda { |v| link_to_property(v.property) },
      :property_1 => lambda { |v| link_to_property(v.property) },
      :value_0    => lambda { |v| v.value  },
      :value_1    => lambda { |v| v.value  },
      :example_0  => lambda { |v| v.examples.map(&:name).join(", ") },
      :example_1  => lambda { |v| v.examples.map(&:name).join(", ") }
    }
  end

  def search_result_attributes(parent, child = nil)
    {}.tap do |attrs|
      attrs[:class] = "row"
      attrs["data-parent-value"] = parent.id
      attrs["data-child-value"]  = child.id unless child.nil?
    end
  end


end