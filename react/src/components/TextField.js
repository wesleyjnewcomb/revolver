import React from 'react';

const TextField = props => {
  return (
    <input
      name={props.name}
      type="text"
      placeholder={props.label}
      onChange={props.handleChange}
      value={props.content}
    />
  );
}

export default TextField;
