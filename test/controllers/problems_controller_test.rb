require 'test_helper'

class ProblemsControllerTest < ActionController::TestCase
  context "GET problems#index" do
    setup { get :index }

    should render_template("index")
    should respond_with(:ok)

    should "show problems" do
      assert assigns[:problems], "should load problems"
    end
  end

  context "GET problems#show" do
	  setup { get :show, id: problems(:one) }

	  should render_template("show")
	  should respond_with(:ok)

	  should "show problem" do
		  assert assigns[:problem], "should show specific problem"
	  end
  end

  context "GET problems#new" do
    setup { get :new }

    should "redirect to login page" do
      assert_redirected_to new_login_path
    end
  end
end
