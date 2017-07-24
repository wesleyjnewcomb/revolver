import React from 'react'

const RadioButton = ({ label, name, value, options, handleChange }) => {
  let radioButtons = options.map(option => {
    if(options.value === value)
      return (
        <span key={option.value} className='radio-button'>
          <input name={name} type='radio'
            value={option.value}
            onChange={handleChange}
          />
          {option.label}
        </span>
      )
    else {
      return (
        <span key={option.value} className='radio-button'>
          <input name={name} type='radio'
            value={option.value}
            onChange={handleChange}
          />
          {option.label}
        </span>
      )
    }
  })
  return (
    <div className='radio'>
      <label htmlFor={name}>{label}</label>
      {radioButtons}
    </div>
  )
}

export default RadioButton;
