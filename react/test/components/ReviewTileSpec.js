import ReviewTile from '../../src/components/ReviewTile'

describe('ReviewTile', () => {
  let wrapper;
  let data = {
    user_email: 'test@test.test',
    username: 'rustyshackleford',
    body: 'It is alright, son',
    rating: 6
  }

  beforeEach(() => {
    wrapper = mount(
      <ReviewTile
        content={data}
      />
    )
  });

  it('should render the rating', () => {
    expect(wrapper.find('.rating').text()).toEqual(`Rating: ${data.rating}/10`)
  })
  it('should render the username', () => {
    expect(wrapper.find('.username').text()).toEqual(data.username)
  })
  it('should render the review body', () => {
    expect(wrapper.find('.review-body').text()).toEqual(data.body)
  })
})
