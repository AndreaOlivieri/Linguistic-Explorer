module LinkHelper

  def link_to_new_group_ling ling, depth, options={}, &block
    if current_user.is_expert_of?(ling)
      link_to new_group_ling_path(current_group, :depth => depth), options, &block
    else
      options[:confirm] = 'Send a message to an Admin for requesting the approval'
      link_to "#", options, &block
    end
  end

  def link_to_delete_property property, options={}, &block
    if current_user.is_expert_of?(property)
      link_to [current_group, property], options, &block
    else
      options[:confirm] = 'Send a message to an Admin for requesting the approval'
      link_to "#", options, &block
    end
  end

end