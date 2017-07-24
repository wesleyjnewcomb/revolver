import React from 'react';

const TextField = ({ label, name, content, handleChange }) => {
  return (
    <label>{label}
      <input
        name={name}
        type="text"
        onChange={handleChange}
        value={content}
      />
    </label>
  );
}

export default TextField;
