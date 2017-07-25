import React from 'react'

const Dropdown = ({ label, name, options, handleChange }) => {
  let optionElements = options.map(option => {
    return (
      <option key={`${option.label}-${option.value}`} value={option.value}>{option.label}</option>
    )
  })
  return (
    <label>{label}
      <select name={name} onChange={handleChange}>
        {optionElements}
      </select>
    </label>
  )
}

export default Dropdown;
