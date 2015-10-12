module Builder
  class Posts < Builder::Base

    def create_index collection
      result = []
      collection.each do |obj|
        result.push extract_details(obj)
      end
      result
    end

    private

    def extract_details obj
      {
        id: obj.id,
        title: obj.title,
        excerpt: obj.excerpt,
        content: obj.content,
        creator: obj.creator_name,
        last_updator: obj.updator_name
      }
    end

  end
end