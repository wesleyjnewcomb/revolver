import React from 'react'

const Dropdown = ({ label, value, name, options, handleChange }) => {
  let optionElements = options.map(option => {
    return (
      <option key={`${option.label}-${option.value}`} value={option.value}>{option.label}</option>
    )
  })
  return (
    <label>{label}
      <select name={name} value={value} onChange={handleChange}>
        {optionElements}
      </select>
    </label>
  )
}

export default Dropdown;
