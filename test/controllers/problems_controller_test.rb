require 'test_helper'

class ProblemsControllerTest < ActionController::TestCase
  def invalid_problem_attributes
    { problem: { issue: '',
                 try: '' } }
  end

  def valid_problem_attributes
    { problem: { issue: 'How do I?',
                 try: 'I tried this' } }
  end

  context 'GET problems#index' do
    setup { get :index }

    should render_template('index')
    should respond_with(:ok)

    should 'show problems' do
      assert assigns[:problems], 'should load problems'
    end
  end

  context 'GET problems#show' do
    setup { get :show, id: problems(:one) }

    should render_template('show')
    should respond_with(:ok)

    should 'show problem' do
      assert assigns[:problem], 'should show specific problem'
    end
  end

  context 'GET problems#new' do
	  context 'if not logged in' do
	    setup { get :new }

	    should 'redirect to login page' do
	      assert_redirected_to new_login_path
	    end
	  end

	  context 'if logged in' do
		  setup { get :new, {}, logged_in_session }

		  should 'load problem' do
			  assert assigns[:problem], 'should load new problem'
		  end

		  should render_template('new')
	  end
  end

  context 'POST#create' do
    context 'when user is not logged in' do
      setup { post :create }

      should 'redirect to homepage' do
        assert_redirected_to new_login_path
      end
    end

    context 'when I send invalid information' do
      setup do
        post :create, invalid_problem_attributes, logged_in_session
      end

      should 're-render the form' do
        assert_template :new
      end

      should 'instantiate an invalid problem object' do
        assert assigns[:problem], 'Should have a problem'
        assert assigns[:problem].invalid?, 'Should have an invalid problem'
      end
    end

    context 'when I send valid information' do
      setup do
        post :create, valid_problem_attributes, logged_in_session
      end

      should 'create a problem' do
        assert assigns[:problem], 'Should have a problem'
        assert assigns[:problem].persisted?, 'Should save problem in DB'
      end

      should 'show problem' do
        assert_redirected_to assigns[:problem], 'Should redirect to show problem'
      end
    end
  end

	context 'PATCH problems#close' do
		setup do
			@problem = problems(:one)
			patch :close, { id: @problem, resolved: true }, logged_in_session
		end

		should 'load problem' do
			assert assigns[:problem], 'load problem'
		end

		should 'update problem to closed' do
			assert @problem.reload.resolved, 'should be marked close'
		end
	end
end
