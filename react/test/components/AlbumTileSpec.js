import AlbumTile from '../../src/components/AlbumTile'

describe('AlbumTile', () => {
  let wrapper;
  let album = {
    id: 1,
    title: "Revolver",
    year_released: 1966,
    month_released: 7,
    artist: {
      id: 1,
      name: "The Beatles"
    }
  }
  beforeEach(() => {
    wrapper = mount(
      <AlbumTile
        album={album}
      />
    )
  });

  it('should render the album title', () => {
    expect(wrapper.find('.album-title').text()).toEqual('Revolver')
  })
  it('should render the artist name', () => {
    expect(wrapper.find('.album-artist').text()).toEqual('The Beatles')
  })
  it('should render the month and year released', () => {
    expect(wrapper.find('h4').text()).toEqual('Aug 1966')
  })
})
