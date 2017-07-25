import React from 'react';

const NumberField = ({ label, name, content, min, max, handleChange }) => {
  return (
    <label>{label}
      <input
        name={name}
        type="number"
        onChange={handleChange}
        value={content}
        min={min}
        max={max}
      />
    </label>
  );
}

NumberField.defaultProps = {
  min: 0
}

export default NumberField;
