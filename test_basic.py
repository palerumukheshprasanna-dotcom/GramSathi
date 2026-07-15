import unittest
from app import create_app, db
from app.models import User, Scheme, Job

class GramSathiBasicTestCase(unittest.TestCase):
    def setUp(self):
        # Configure app for testing
        self.app = create_app()
        self.app.config['TESTING'] = True
        self.app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
        self.client = self.app.test_client()
        
        # Open app context and create memory tables
        self.app_context = self.app.app_context()
        self.app_context.push()
        db.create_all()
        
    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()
        
    def test_dashboard_route_anonymous(self):
        """Test dashboard accessibility without logging in"""
        response = self.client.get('/dashboard')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'GramSathi', response.data)
        
    def test_weather_api(self):
        """Test mock weather JSON endpoint"""
        response = self.client.get('/api/weather')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'temp', response.data)
        self.assertIn(b'humidity', response.data)
        self.assertIn(b'Nelakondapally Rural', response.data)
        
    def test_chat_api(self):
        """Test chatbot response JSON endpoint"""
        response = self.client.post('/api/chat', json={'message': 'hello'})
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'response', response.data)
        self.assertIn(b'language', response.data)

    def test_registration_and_login_flow(self):
        """Test registration and authentication sessions"""
        # 1. Register temporary details (returns redirect to verify-otp)
        response = self.client.post('/register', data={
            'name': 'Test User',
            'email': 'test@gmail.com',
            'phone': '1234567890',
            'password': 'password123',
            'confirm_password': 'password123',
            'role': 'user'
        })
        self.assertEqual(response.status_code, 302)
        
        # 2. Get OTP from session
        with self.client.session_transaction() as sess:
            otp = sess.get('reg_otp')
            self.assertIsNotNone(otp)
            
        # 3. Verify OTP
        response = self.client.post('/verify-otp', data={'otp': otp})
        self.assertEqual(response.status_code, 302)
        
        # 4. Verify user exists in database
        user = User.query.filter_by(email='test@gmail.com').first()
        self.assertIsNotNone(user)
        self.assertEqual(user.name, 'Test User')
        
        # 5. Log in
        response = self.client.post('/login', data={
            'email': 'test@gmail.com',
            'password': 'password123'
        })
        self.assertEqual(response.status_code, 302)
        
        # 6. Verify login session variables
        with self.client.session_transaction() as sess:
            self.assertEqual(sess.get('user_name'), 'Test User')
            self.assertEqual(sess.get('user_role'), 'user')

if __name__ == '__main__':
    unittest.main()
