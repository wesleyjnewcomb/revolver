import TextArea from '../../src/components/TextArea'

describe('TextArea', () => {
  let wrapper;

  let label = 'Review'
  let name = 'body'
  let content = 'This is our test-review. Tester! Test! Testing!'

  beforeEach(() => {
    wrapper = mount(
      <TextArea
        label={label}
        name={name}
        content={content}
      />
    )
  });

  it('should render the TextArea component', () => {
    expect(wrapper.find(TextArea)).toBePresent();
  })
  it('should render a textarea element', () => {
    expect(wrapper.find("textarea")).toBePresent();
  })
  it('should render the content inside the textarea', () => {
    expect(wrapper.find("textarea").text()).toEqual(content);
  })
  it('should render the label for user to see', () => {
    expect(wrapper.find("label")).toIncludeText(label);
  })
})
