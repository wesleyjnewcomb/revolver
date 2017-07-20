import React from 'react';

const TextField = props => {
  return (
    <label>{props.label}
      <input
        name={props.name}
        type="text"
        onChange={props.handleChange}
        value={props.content}
      />
    </label>
  );
}

export default TextField;
