require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test '#index' do
    get :index, format: :json

    items = JSON.parse(response.body)
    first_item = items.first

    assert_response :success
    assert_equal "Trump",           first_item["name"]
    assert_equal "My hair is huge", first_item["description"]
  end

  test '#show' do

    get :show, format: :json, id: "1"

    item = JSON.parse(response.body)

    assert_response :success
    assert_equal "Trump", item["name"]
    assert_equal "My hair is huge", item["description"]
  end

  test '#create' do
    assert_difference("Item.count", 1) do
      post :create, format: :json, item: { name: "Jones", description: "loves guac" }
    end

    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Jones",      item[:name]
    assert_equal "loves guac", item[:description]
  end

  test '#update' do
    old_item = Item.create(name: "Hillary", description: "You've got mail")

    patch :update, format: :json, id: old_item.id, item: { name: "Bernie", description: "Feel the Bern" }

    item = Item.find(old_item.id)

    assert_response :success
    assert_equal "Hillary", old_item[:name]
    assert_equal "You've got mail", old_item[:description]

    assert_equal "Bernie", item[:name]
    assert_equal "Feel the Bern", item[:description]
  end
end
