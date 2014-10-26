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

	  should "load notes too" do
		  assert assigns[:notes], "should show problems with notes"
	  end
  end

  context "GET problems#new" do

      should "open a new problem" do
        assert assigns[:problem], "Should show new problem"
      end
    end
end
