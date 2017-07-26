import Dropdown from '../../src/components/Dropdown'

describe('Dropdown', () => {
  let wrapper;

  let label = 'Rating';
  let name = 'rating';
  let options = [
    { label: '1', value: '1' },
    { label: '2', value: '2' },
    { label: '3', value: '3' },
    { label: '4', value: '4' },
    { label: '5', value: '5' },
    { label: '6', value: '6' },
    { label: '7', value: '7' },
    { label: '8', value: '8' },
    { label: '9', value: '9' },
    { label: '10', value: '10' }
  ]

  beforeEach(() => {
    wrapper = mount(
      <Dropdown
        label={label}
        name={name}
        options={options}
      />
    )
  });

  it('should render the Dropdown component', () => {
    expect(wrapper.find(Dropdown)).toBePresent();
  })
  it('should render a select element', () => {
    expect(wrapper.find("select")).toBePresent();
  })
  it('renders multiple option elements', () => {
    expect(wrapper.find('option').length).toEqual(10)
  })
  it('should render the label for user to see', () => {
    expect(wrapper.find("label")).toIncludeText(label);
  })
})
