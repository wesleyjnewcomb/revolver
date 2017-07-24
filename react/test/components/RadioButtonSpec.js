import RadioButton from '../../src/components/RadioButton'

describe('RadioButton', () => {
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
      <RadioButton
        label={label}
        name={name}
        options={options}
      />
    )
  });

  it('should render the RadioButton component', () => {
    expect(wrapper.find(RadioButton)).toBePresent();
  })
  it('should render an input element', () => {
    expect(wrapper.find("input")).toBePresent();
  })
  it('renders the correct text next to each radio button', () => {
    for (let option of options) {
      expect(wrapper).toIncludeText(option.label)
    }
  })
  it('should render the label for user to see', () => {
    expect(wrapper.find("label")).toIncludeText(label);
  })
})
