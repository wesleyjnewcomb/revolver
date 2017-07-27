import ReviewTile from '../../src/components/ReviewTile'

describe('ReviewTile', () => {
  let wrapper;
  let data = {
    user: {
      username: 'rustyshackleford',
      avatar: {
        url: 'https://google.com'
      }
    },
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
    expect(wrapper.find('.rating').text()).toEqual(`${data.rating}/10`)
  })
  it('should render the username', () => {
    expect(wrapper.find('.username').text()).toEqual(data.user.username)
  })
  it('should render the review body', () => {
    expect(wrapper.find('.review-body').text()).toEqual(data.body)
  })
})
