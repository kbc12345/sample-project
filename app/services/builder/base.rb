module Builder
  class Base


    def metadata page_number, total_count
      {current_page: page_number, count: total_count}
    end

  end
end