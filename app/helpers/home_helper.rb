module HomeHelper
  def complete_url(id)
    request.base_url + '/' + id
  end
end
