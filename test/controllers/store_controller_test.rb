require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    # check qu'il y a au moins 4 lignes dans la colonne de gauche
    assert_select '#columns #side a', minimum: 4
    # check qu'il y a 3 produits creer par la fixture
    assert_select '#main .entry', 3
    # check que le tag <h3> contient la bonne valeur
    assert_select 'h3', 'Programming Ruby 1.9'
    # check que le price est formatter ok $1.23
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
