module HomeHelper
  def rate average
    str = ""
    1.upto(5) do |i|
      star = "<span class=\"glyphicon glyphicon-star %s\" data-value=#{i}></span>"
      status = ""

      if i <= average
        status = ""
      elsif i > average.ceil
        status = "uncheck"
      else
        status = "half"
      end
      str += star % [].push(status)
    end
    str
  end

  def upto_item index, courses_size
    (index * 4 + 3) >= courses_size ? courses_size - 1 : (index * 4 + 3)
  end

  def check_course course_id
    current_user.cart_items.find_by(course_id: course_id) if user_signed_in?
  end
end
