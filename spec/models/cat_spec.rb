require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should validate name" do
    cat = Cat.create age:420, enjoys: 'Throwing down tunes', image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
    p cat.errors[:name]
    expect(cat.errors[:name]).to_not be_empty
  end

/---------------------------------------------------------------------------------------------------------------------/

  it 'wont create a cat in the database without an age' do
    cat = Cat.create name: 'Felix Da Housecat', enjoys: 'Throwing down tunes', image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
    p cat.errors[:age]
    expect(cat.errors[:age]).to_not be_empty
  end

/---------------------------------------------------------------------------------------------------------------------/

  it 'wont create a cat in the database without an enjoys' do
    cat = Cat.create name: 'Felix Da Housecat', age: 420,  image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg'
    p cat.errors[:enjoys]
    expect(cat.errors[:enjoys]).to_not be_empty
  end

/---------------------------------------------------------------------------------------------------------------------/

  it 'wont create a cat in the database without an enjoys that is ten characters long' do
    cat = Cat.create name: 'Felix Da Housecat', age: 420, image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
    p cat.errors[:enjoys]
    expect(cat.errors[:enjoys]).to_not be_empty
  end

/---------------------------------------------------------------------------------------------------------------------/

  it 'wont create a cat in the database without an image' do
    cat = Cat.create name: 'Felix Da Housecat', age: 420, enjoys: 'Throwing down tunes'
    p cat.errors[:image]
    expect(cat.errors[:image]).to_not be_empty
  end

/---------------------------------------------------------------------------------------------------------------------/
end

