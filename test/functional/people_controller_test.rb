require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post :create, person: { c_oksm: @person.c_oksm, contact: @person.contact, ddeath: @person.ddeath, dr: @person.dr, email: @person.email, fam: @person.fam, fiopr: @person.fiopr, im: @person.im, ot: @person.ot, phone: @person.phone, ss: @person.ss, true_dr: @person.true_dr, w: @person.w }
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test "should show person" do
    get :show, id: @person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person
    assert_response :success
  end

  test "should update person" do
    put :update, id: @person, person: { c_oksm: @person.c_oksm, contact: @person.contact, ddeath: @person.ddeath, dr: @person.dr, email: @person.email, fam: @person.fam, fiopr: @person.fiopr, im: @person.im, ot: @person.ot, phone: @person.phone, ss: @person.ss, true_dr: @person.true_dr, w: @person.w }
    assert_redirected_to person_path(assigns(:person))
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person
    end

    assert_redirected_to people_path
  end
end
