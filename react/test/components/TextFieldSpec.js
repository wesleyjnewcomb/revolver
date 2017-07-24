import TextField from '../../src/components/TextField'

describe('TextField', () => {
  let wrapper;

  let label = 'Review'
  let name = 'body'
  let content = 'This is our test-review. Tester! Test! Testing!'

  beforeEach(() => {
    wrapper = mount(
      <TextField
        label={label}
        name={name}
        value={content}
      />
    )
  });

  it('should render the TextField component', () => {
    expect(wrapper.find(TextField)).toBePresent();
  })
  it('should render an input element', () => {
    expect(wrapper.find("input")).toBePresent();
  })
  it('should render the label for user to see', () => {
    expect(wrapper.find("label")).toIncludeText(label);
  })
})
