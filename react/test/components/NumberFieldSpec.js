import NumberField from '../../src/components/NumberField'

describe('NumberField', () => {
  let wrapper;

  let label = 'Year Released'
  let name = 'year_released'
  let content = 1990

  beforeEach(() => {
    wrapper = mount(
      <NumberField
        label={label}
        name={name}
        value={content}
      />
    )
  });

  it('should render the NumberField component', () => {
    expect(wrapper.find(NumberField)).toBePresent();
  })
  it('should render an input element', () => {
    expect(wrapper.find("input")).toBePresent();
  })
  it('should render the label for user to see', () => {
    expect(wrapper.find("label")).toIncludeText(label);
  })
})
