import { RECEIVE_DOCTOR } from '../actions/doctor_actions';
import { merge } from 'lodash';

const doctorsReducer = (state = {}, action) => {
  Object.freeze(state);
  let newState;
  switch(action.type) {
    case RECEIVE_DOCTOR:
      const newDoc = action.doctor;
      newState = { [newDoc.id]: newDoc };
      return merge({}, state, newState);
    default:
      return state;
  }
};

export default doctorsReducer;
