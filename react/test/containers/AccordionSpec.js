import Accordion from '../../src/containers/Accordion'

describe('Accordion', () => {
  let wrapper;
  let title = 'Click here';

  beforeEach(() => {
    wrapper = mount(
      <Accordion title={title}>
        <p>Body</p>
      </Accordion>
    )
  });

  it('should render the Accordion component', () => {
    expect(wrapper.find(Accordion)).toBePresent();
  })
  it('should display the title', () => {
    expect(wrapper.find('.title')).toHaveText(title);
  })
  it('should not render the body when', () => {
    expect(wrapper.find('p')).not.toBePresent();
  })
  it('should not render the body when', () => {
    wrapper.setState({ showing: true })
    expect(wrapper.find('p')).toBePresent();
  })
})
