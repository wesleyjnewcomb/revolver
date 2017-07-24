import ReviewsIndex from '../../src/containers/ReviewsIndex'
import ReviewTile from '../../src/components/ReviewTile'

describe('ReviewsIndex', () => {
  let wrapper;
  let reviewsData = [
    {
      id: 1,
      album_id: 1,
      user_id: 1,
      user_email: 'test@test.test',
      username: 'yo-mammy',
      body: 'ugh',
      rating: 6
    },
    {
      id: 2,
      album_id: 1,
      user_id: 2,
      user_email: 'i@love.everyone',
      username: 'bleh',
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
