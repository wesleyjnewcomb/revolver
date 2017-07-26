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
    expect(wrapper.find('p').text()).toEqual('13')
  })
})
