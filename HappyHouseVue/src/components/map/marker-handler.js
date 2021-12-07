const kakao = window.kakao;
class MarkerHandler {
  constructor(vuekakaoMap, options) {
    this.vueMap = vuekakaoMap;
    this.options = options;
  }
  add(userData, fnConv) {
    userData.forEach((data) => {
      const option = fnConv(data);

      const markerInstance = new kakao.maps.Marker({
        map: this.vueMap.mapInstance,
        positin: new kakao.maps.LatLng(option.lat, option.lng),
      });
      markerInstacne.$$ = {
        data, // reference to user data
      };
      if (this.options.markerClicked) {
        kakao.maps.addListener(markerInstacne, "click", () => {
          this.options.markerClicked(markerInstance.$$.data);
        });
      }
      console.log(markerInstance);
    });
  }
}

export default MarkerHandler;
