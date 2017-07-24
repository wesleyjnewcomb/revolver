import React from 'react';

const TextArea = ({ name, label, content, handleChange, rows }) => {
  return (
    <label>{label}
      <textarea name={name}
        value={content}
        rows={rows}
        onChange={handleChange}
      />
    </label>
  );
}

TextArea.defaultProps = {
  rows: 6
}

export default TextArea;
