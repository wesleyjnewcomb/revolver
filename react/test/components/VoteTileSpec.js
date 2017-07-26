import VoteTile from '../../src/components/VoteTile'

describe('VoteTile', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = mount(
      <VoteTile
        score={13}
        currentValue={0}
      />
    )
  });

  it('should render the score', () => {
    expect(wrapper.find('.score').text()).toEqual('13')
  })
})
