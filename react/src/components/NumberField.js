import React from 'react';

const NumberField = ({ label, name, value, min, max, handleChange }) => {
  return (
    <label>{label}
      <input
        name={name}
        type="number"
        onChange={handleChange}
        value={value}
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
