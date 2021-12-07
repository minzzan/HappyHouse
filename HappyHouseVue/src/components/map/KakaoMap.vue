<template>
  <div id="container">
    <div class="map_wrap">
      <div id="map" ref="map"></div>

      <div id="menu_wrap" style="display: none" class="bg_white">
        <h1>관심매물</h1>
        <hr />
        <ul>
          <li
            v-for="(item, index) in interest"
            :key="index"
            @click="selectHouse(item)"
            class="interestList"
          >
            {{ item.아파트 }} {{ item.place_name }}
          </li>
          <hr />
        </ul>
        <div id="pagination"></div>
      </div>
      <a-button id="btnTraffic" icon="car" @click="displayTraffic"></a-button>
      <a-button
        id="btnInterest"
        icon="star"
        @click="displayInterest"
      ></a-button>
    </div>
  </div>
</template>

<script>
let kakao = window.kakao;
import { mapState, mapActions, mapMutations } from "vuex";
const houseStore = "houseStore";
const mapStore = "mapStore";
export default {
  props: ["options"],
  data() {
    return {
      mapInstance: null,
      markers: [],
      infoWindows: [],
      bounds: null,
      ps: null,
      flag: true,
      roadview: null,
      container: null,
    };
  },
  mounted() {
    kakao = kakao || window.kakao;

    var container = this.$refs.map;
    const { center, level } = this.options;
    this.mapInstance = new kakao.maps.Map(container, {
      center: new kakao.maps.LatLng(center.lat, center.lng),
      level: level,
    });
    // console.log(mapInstance);

    // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
    let mapTypeControl = new kakao.maps.MapTypeControl();

    // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
    // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
    this.mapInstance.addControl(
      mapTypeControl,
      kakao.maps.ControlPosition.TOPRIGHT
    );

    // 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성합니다
    let zoomControl = new kakao.maps.ZoomControl();
    this.mapInstance.addControl(
      zoomControl,
      kakao.maps.ControlPosition.BOTTOMRIGHT
    );

    this.bounds = new kakao.maps.LatLngBounds(); // 지도 범위 설정하는 객체 생성
    this.ps = new kakao.maps.services.Places(); // 장소 검색 객체 생성

    this.initMap();
  },
  watch: {
    houses: function (house) {
      this.removeMarkers();
      this.removeInfoWindow();
      for (let i = 0; i < house.length; i++) {
        this.findByAddress(
          house[i].법정동 + house[i].도로명 + house[i].도로명건물본번호코드
        );
      }
    },
    keyword: function (word) {
      // this.removeMarkers();
      // this.removeInfoWindow();
      this.ps.keywordSearch("주거시설 " + word, this.placesSearchCB);
    },
  },
  computed: {
    ...mapState(houseStore, ["houses", "interest"]),
    ...mapState(mapStore, ["keyword"]),

    // keyword: function (word) {
    //   this.ps.keywordSearch("주거시설 " + word, this.placesSearchCB);
    // },
  },
  methods: {
    ...mapMutations(houseStore, ["SET_HOUSE_LIST"]),
    ...mapActions(houseStore, [
      "detailHouse",
      "getHouseList",
      "getSearchHouseList",
    ]),
    // ...mapActions(mapStore, []),

    initMap() {
      // 현재 위치로 설정
      this.currentPlace();
    },

    displayTraffic() {
      if (this.flag) {
        this.mapInstance.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);
        this.flag = false;
        return;
      } else {
        this.mapInstance.removeOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);
        this.flag = true;
        return;
      }
    },

    displayMarker(markerPosition, msg) {
      let image = require("@/assets/marker.png");
      let imageSize = new kakao.maps.Size(24, 35);
      let markerImage = new kakao.maps.MarkerImage(image, imageSize);

      let marker = new kakao.maps.Marker({
        map: this.mapInstance,
        position: markerPosition,
        title: "marker title",
        image: markerImage,
      });
      this.markers.push(marker);
      this.bounds.extend(markerPosition);
      if (msg) {
        let iwContent = msg;
        let iwRemoveable = true;
        // 인포윈도우를 생성합니다.
        var infoWindow = new kakao.maps.InfoWindow({
          content: iwContent,
          removable: iwRemoveable,
        });
        this.infoWindows.push(infoWindow);
        // 인포 윈도우를 마커위에 표시
        infoWindow.open(this.mapInstance, marker);
      }
      // marker.setMap(map);
      this.setMarkers(this.mapInstance);
      this.mapInstance.setBounds(this.bounds);
    },
    displayCompass() {
      if (this.flag) {
        this.mapInstance.addOverlayMapTypeId(kakao.maps.MapTypeId.ROADMAP);
        this.flag = false;
        return;
      } else {
        this.mapInstance.removeOverlayMapTypeId(kakao.maps.MapTypeId.ROADMAP);
        this.flag = true;
        return;
      }
    },

    // setBounds(bound) {
    //   // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정
    //   // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다.
    // },
    findByAddress(address) {
      // 주소-좌표 변환 객체를 생성한다.
      let geocoder = new kakao.maps.services.Geocoder();
      geocoder.addressSearch(address, (result, status) => {
        // 정상적으로 검색이 된다면
        if (status === kakao.maps.services.Status.OK) {
          // console.log(result);
          let coords = new kakao.maps.LatLng(result[0].y, result[0].x);
          // let msg = "latlng : new kakao.maps.LatLng(" + result[0].y + ", ";
          // msg += result[0].x + ")";
          // console.log(msg);
          // var gridXY = self.dfs_xy_conv("toXY", result[0].y, result[0].x);
          // self.getWeather(gridXY);
          let infomsg = `<div style="width:150px;text-align:center;padding:5px 0;">${result[0].road_address.building_name}</div>`;
          this.displayMarker(coords, infomsg);
        }
      });
    },
    currentPlace() {
      // HTML5의 geolocation을 사용할 수 있다면
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition((position) => {
          let lat = position.coords.latitude; // 위도
          let lng = position.coords.longitude; // 경도
          let locPosition = new kakao.maps.LatLng(lat, lng);
          let msg = "";

          this.mapInstance.setCenter(locPosition);
          this.mapInstance.setLevel(4);
        });
      } else {
        // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정
        let locPosition = new kakao.maps.LatLng(33.450701, 126.570667);
        let msg = "geolocation을 사용할 수 없습니다";
        this.displayMarker(locPosition, msg);
      }
    },
    // 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수
    setMarkers(map) {
      for (let i = 0; i < this.markers.length; i++) {
        this.markers[i].setMap(map);
      }
    },
    removeMarkers() {
      for (let i = 0; i < this.markers.length; i++) {
        this.markers[i].setMap(null);
      }
      this.markers = [];
    },
    removeInfoWindow() {
      for (let i = 0; i < this.infoWindows.length; i++) {
        this.infoWindows[i].close();
      }
      this.infoWindows = [];
    },
    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
    placesSearchCB(data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {
        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        // displayPlaces(data);

        // // 페이지 번호를 표출합니다
        // displayPagination(pagination);

        this.getSearchHouseList(data);

        let category = [];
        for (let i = 0; i < data.length; i++) {
          let resultLat = data[i].y;
          let resultLon = data[i].x;
          let resultPosition = new kakao.maps.LatLng(resultLat, resultLon);
          category = data[i].category_name.split(">");
          if (category.includes(" 주거시설 ")) {
            this.displayMarker(resultPosition, "");
          }
        }
      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        alert("검색 결과가 존재하지 않습니다.");
        return;
      } else if (status === kakao.maps.services.Status.ERROR) {
        alert("검색 결과 중 오류가 발생했습니다.");
        return;
      }
    },
    displayInterest() {
      let menu = document.getElementById("menu_wrap");
      if (menu.style.display == "none") {
        menu.style.display = "block";
      } else {
        menu.style.display = "none";
      }
    },
    selectHouse(item) {
      // console.log("listRow : ", this.house);
      // this.$store.dispatch("getHouse", this.house);
      this.detailHouse(item);
    },
  },
};
</script>

<style scoped>
#map {
  width: 100%;
  height: 800px;
  position: relative;
  overflow: hidden;
}
#btnTraffic {
  font-size: 15px;
  width: 50px;
  height: 40px;
  z-index: 1;
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
  margin: 3px 0 30px 10px;
}
#btnInterest {
  font-size: 15px;
  width: 50px;
  height: 40px;
  z-index: 1;
  position: absolute;
  top: 0;
  left: 55px;
  bottom: 0;
  margin: 3px 0 30px 10px;
}

.map_wrap,
.map_wrap * {
  margin: 0;
  padding: 0;
  font-family: "Malgun Gothic", dotum, "돋움", sans-serif;
  font-size: 12px;
}
.map_wrap a,
.map_wrap a:hover,
.map_wrap a:active {
  color: #000;
  text-decoration: none;
}
.map_wrap {
  position: relative;
  width: 100%;
  height: 500px;
}
.map_wrap li {
  text-align: center;
}
#menu_wrap {
  position: absolute;
  top: 50px;
  left: 0;
  bottom: 0;
  width: 250px;
  margin: 10px 0 30px 10px;
  padding: 5px;
  overflow-y: auto;
  background: rgba(255, 255, 255, 0.7);
  z-index: 1;
  font-size: 12px;
  border-radius: 10px;
}
.bg_white {
  background: #fff;
}
#menu_wrap hr {
  display: block;
  height: 1px;
  border: 0;
  border-top: 2px solid #5f5f5f;
  margin: 3px 0;
}
#menu_wrap .option {
  text-align: center;
}
#menu_wrap .option p {
  margin: 10px 0;
}
#menu_wrap .option button {
  margin-left: 5px;
}
#placesList li {
  list-style: none;
}
#placesList .item {
  position: relative;
  border-bottom: 1px solid #888;
  overflow: hidden;
  cursor: pointer;
  min-height: 65px;
}
#placesList .item span {
  display: block;
  margin-top: 4px;
}
#placesList .item h5,
#placesList .item .info {
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}
#placesList .item .info {
  padding: 10px 0 10px 55px;
}
#placesList .info .gray {
  color: #8a8a8a;
}
#placesList .info .jibun {
  padding-left: 26px;
  background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
    no-repeat;
}
#placesList .info .tel {
  color: #009900;
}
#placesList .item .markerbg {
  float: left;
  position: absolute;
  width: 36px;
  height: 37px;
  margin: 10px 0 0 10px;
  background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
    no-repeat;
}

#pagination {
  margin: 10px auto;
  text-align: center;
}
#pagination a {
  display: inline-block;
  margin-right: 10px;
}
#pagination .on {
  font-weight: bold;
  cursor: default;
  color: #777;
}
.interestList {
  cursor: pointer;
}
</style>
