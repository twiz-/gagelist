module ListsHelper
  def active_members(list)
    list.active_members.collect {|m| [ m.full_name, m.id ]}
  end
end
