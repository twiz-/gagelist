module ListsHelper
  def members_list(list)
    list.members.collect {|m| [ m.full_name, m.id ]}
  end
end
