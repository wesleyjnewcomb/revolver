import ReviewsIndex from '../../src/containers/ReviewsIndex'
import ReviewTile from '../../src/components/ReviewTile'

describe('ReviewsIndex', () => {
  let wrapper;
  let reviewsData = [
    {
      id: 1,
      album_id: 1,
      user: {
        id: 1,
        username: 'rustyshackleford',
        email: 'test@test.test',
        avatar: {
          url: 'https://google.com'
        }
      },
      body: 'ugh',
      rating: 6
    },
    {
      id: 2,
      album_id: 1,
      user: {
        id: 2,
        username: 'bleh',
        email: 'i@love.you',
        avatar: {
          url: 'https://reddit.com'
        }
      },
      body: 'AH',
      rating: 3
    }
  ]

  beforeEach(() => {
    wrapper = mount(
      <ReviewsIndex
        reviewsData={reviewsData}
      />
    )
  });

  it('should render a review tile', () => {
    expect(wrapper.find(ReviewTile)).toBePresent()
  })
  it('should render the correct number of review tiles', () => {
    expect(wrapper.find(ReviewTile).length).toEqual(2)
  })
})
