module TineeHelper

  def url_chars
    ('0'..'9').to_a + %w(b c d f g h j k l m n p q r s t v w x y z) + 
                      %w(B C D F G H J K L M N P Q R S T V W X Y Z)
  end

  def generate_encoded_id(id)
    result = ''
    while id != 0
      rem = id % url_chars.size
      id = (id - rem) / url_chars.size
      result = url_chars[rem] + result
    end
    result
  end

  def one_line(&block)
    haml_concat capture_haml(&block).gsub("\n", '').gsub('\\n', "\n")
  end

  def limit64(string)
    string = string.to_s
    if string.length > 64
      return string.slice(0, 61) + "..."
    end
    string
  end

  def save_encoded_url(valid_url)
    new_tinee_url = TineeUrl.new(:url => valid_url)
    new_tinee_url.save
    encoded_id = generate_encoded_id(new_tinee_url.id)
    user = User.find_by_email(params[:user])
    new_tinee_url.update({encoded_id: encoded_id, user_id: user.id})
    url = request.base_url + '/' + encoded_id
    return { :status => "success" , :url =>  url }
  end

end
