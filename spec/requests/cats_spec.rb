require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
      Cat.create(
        name: 'Felix Da House Cat',
        age: 420,
        enjoys: 'Throwing down tunes',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )

      get '/cats'

      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end

/---------------------------------------------------------------------------------------------------------------------/

  describe "POST /create" do
    it "creates a cat" do
      cat_params = {
        cat: {
          name: 'Felix Da House Cat',
          age: 420,
          enjoys: 'Throwing down tunes',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }

      post '/cats', params: cat_params

      expect(response).to have_http_status(200)
      cat = Cat.first
      expect(cat.name).to eq 'Felix Da House Cat'
    end
    end

/---------------------------------------------------------------------------------------------------------------------/

  describe 'DELETE /destroy' do
    it 'deletes a cat from the DB' do
      Cat.create(
        name: 'Felix Da House Cat',
        age: 420,
        enjoys: 'Throwing down tunes',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )

      felix_da_house_cat = Cat.first

      delete "/cats/#{felix_da_house_cat.id}"

      expect(response).to  have_http_status(200)
      cats = Cat.all
      expect(cats).to be_empty
    end
  end

/---------------------------------------------------------------------------------------------------------------------/

  describe 'cannot create a cat without valid attributes'do
    it 'cannot create a cat without a name' do
      cat_params = {
        cat: {
          age: 420,
          enjoys: 'Throwing down tunes',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }

      post '/cats', params: cat_params

      json = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(json['name']).to include "can't be blank"
    end
    end

/---------------------------------------------------------------------------------------------------------------------/

  describe 'cannot create a cat without valid attributes'do
    it 'cannot create a cat without an age' do
      cat_params = {
        cat: {
          name: 'Felix Da House Cat',
          enjoys: 'Throwing down tunes',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }

      post '/cats', params: cat_params

      cat = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(cat['age']).to include "can't be blank"
    end
  end

/---------------------------------------------------------------------------------------------------------------------/

  describe 'cannot create a cat without valid attributes'do
    it 'cannot create a cat without an enjoys' do
      cat_params = {
        cat: {
          name: 'Felix Da House Cat',
          age: 420,
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }

      post '/cats', params: cat_params

      cat = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(cat['enjoys']).to include "can't be blank"
    end
    end

/---------------------------------------------------------------------------------------------------------------------/

  describe 'cannot create a cat without valid attributes'do
    it 'cannot create a cat without an enjoys that is less than 10 characters' do
      cat_params = {
        cat: {
          name: 'Felix Da House Cat',
          age: 420,
          enjoys: 'Throwing',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }

      post '/cats', params: cat_params

      cat = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(cat['enjoys']).to include "is too short (minimum is 10 characters)"
    end
    end

/---------------------------------------------------------------------------------------------------------------------/

  describe 'cannot create a cat without valid attributes'do
    it 'cannot create a cat without an image' do
      cat_params = {
        cat: {
          name: 'Felix Da House Cat',
          age: 420,
          enjoys: 'Throwing down tunes',
        }
      }

      post '/cats', params: cat_params

      cat = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(cat['image']).to include "can't be blank"
    end
    end
  end