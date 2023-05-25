# app/models/product.rb
class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # Define mapping and other configurations for Elastic Search indexing
  mapping dynamic: 'false' do
    indexes :name, type: 'text'
    indexes :description, type: 'text'
  end

  # Define custom search method
  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['name', 'description']
          }
        }
      }
    )
  end
end
