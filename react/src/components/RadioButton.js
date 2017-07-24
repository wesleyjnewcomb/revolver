import React from 'react'

const RadioButton = ({ name, options, handleChange }) => {
  let radioButtons = options.map(option => {
    return (
        <span key={option.value} className='radio-button'>
          <input name={name} type='radio' value={option.value} onChange={handleChange}/>
          {option.label}
        </span>
    )
  })
  return (
    <div className='radio'>
      {radioButtons}
    </div>
  )
}

export default RadioButton;
