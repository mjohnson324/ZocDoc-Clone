import React from 'react';
import { Link } from 'react-router-dom';

class SignupForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      email: '',
      password: '',
      firstName: '',
      lastName: ''
    };

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  update(field) {
    return e => this.setState({
      [field]: e.currentTarget.value
    });
  }

  handleSubmit(e) {
    e.preventDefault();
    const user = this.state;
    this.props.signUp({user})
    .then(currentUser => this.props.history.push('/'));
  }

  renderErrors() {
    return(
      <ul>
        {this.props.errors.map((error, i) => (
          <li key={`error-${i}`}>
            {error}
          </li>
        ))}
      </ul>
    );
  }

  render() {
    return(
      <div>
        <h3>"Create an account"</h3>
        <Link to="/signin">Already have one? Sign in.</Link>

        <form onSubmit={this.handleSubmit}>
          {this.renderErrors()}
          <br/>

          <h4>Enter your email</h4>
          <input type="text"
            placeholder="Email address"
            value={this.state.email}
            onChange={this.update('email')}
          />
          <br/>

          <h4>Create a password</h4>
          <input type="password"
            placeholder="At least 12 characters long"
            value={this.state.firstName}
            onChange={this.update('password')}
          />
          <br/>

          <h4>Your name</h4>
          <input type="text"
            placeholder="First"
            value={this.state.lastName}
            onChange={this.update('firstName')}
          />
          <input type="text"
            placeholder="Last"
            value={this.state.password}
            onChange={this.update('lastName')}
          />
          <br/>

          <input type="submit" value="Sign Up" />
        </form>
      </div>
    );
  }
}

export default SignupForm;
