import React from 'react'

class Accordion extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      showing: false
    }
    this.toggleShow = this.toggleShow.bind(this)
  }
  toggleShow() {
    let new_showing = !this.state.showing
    this.setState({ showing: new_showing })
  }
  render() {
    let body;
    if(this.state.showing) {
      body = <div className='contents'>{this.props.children}</div>
    }
    return (
      <div className='react-accordion'>
        <div className='title' onClick={this.toggleShow}>{this.props.title}</div>
        {body}
      </div>
    )
  }
}

export default Accordion;
