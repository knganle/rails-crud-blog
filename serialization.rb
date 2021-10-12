class Person
  include ActiveModel::Serialization

  attr_accessor :name

  def attributes
    { 'name' => nil }
  end
end

person = Person.new
person.serializable_hash   # => {"name"=>nil}
person.as_json             # => {"name"=>nil}
person.to_json             # => "{\"name\":null}"

person.name = 'Bob'
person.serializable_hash   # => {"name"=>"Bob"}
person.as_json             # => {"name"=>"Bob"}
person.to_json             # => "{\"name\":\"Bob\"}"

# Valid options
person.serializable_hash(only: 'name')
person.serializable_hash(include: :address)
person.serializable_hash(include: { address: { only: 'city' } })
