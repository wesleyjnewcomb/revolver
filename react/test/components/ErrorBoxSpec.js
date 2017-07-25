import ErrorBox from '../../src/components/ErrorBox'

describe('ErrorBox', () => {
  let wrapper;
  let errors = ['Test error', 'Second Test Error'];


  beforeEach(() => {
    wrapper = mount(
      <ErrorBox
        errors={errors}
      />
    )
  });

  it('should render the ErrorBox component', () => {
    expect(wrapper.find(ErrorBox)).toBePresent();
  })
  it('should display the error messages', () => {
    expect(wrapper).toIncludeText(errors[0]);
    expect(wrapper).toIncludeText(errors[1]);
  })
  it('should render an element with alert class', () => {
    expect(wrapper.find('.alert')).toBePresent();
  })
})
