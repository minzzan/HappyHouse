<template>
  <!-- Billing Information Card -->
  <a-card
    :bordered="false"
    class="header-solid h-full"
    :bodyStyle="{ paddingTop: '16px', paddingBottom: '16px' }"
  >
    <a-row :gutter="[24, 24]">
      <a-col :span="24">
        <!-- 지도를 여따가 넣으면 댐 -->
        <kakao-map ref="kmap" :options="mapOption" />
      </a-col>
    </a-row>
  </a-card>
</template>

<script>
import KakaoMap from "@/components/map/KakaoMap.vue";
import MarkerHandler from "@/components/map/marker-handler";
import { mapState, mapActions, mapMutations } from "vuex";
const houseStore = "houseStore";
const mapStore = "mapStore";
// const mapStore = "mapStore";
export default {
  components: {
    KakaoMap,
  },
  data() {
    return {
      mapOption: {
        center: {
          lat: 33.450701,
          lng: 126.570667,
        },
        level: 8,
      },
      word: "",

      infowindow: null,

      listStr: "",
    };
  },
  mounted() {
    // if (window.kakao && window.kakao.maps) {
    //   this.initMap();
    // } else {
    //   const script = document.createElement("script");
    //   script.src =
    //     "//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=" +
    //     process.env.VUE_APP_KAKAO_API_KEY +
    //     "&libraries=services,clusterer,drawing";
    //   script.onload = () => kakao.maps.load(this.initMap);
    //   document.head.appendChild(script);
    // }
    // const vueKakaoMap = this.$refs.kmap;
    // this.marker = new markerHanlder(vueKakaoMap, {
    //   markerClicked: (markers) => {
    //     console.log("[clicked]", harbor);
    //   },
    // });
    var mapContainer = document.getElementById("map"); // 지도를 표시할 div
    var mapOption = {
      center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
      level: 3, // 지도의 확대 레벨
    };

    this.infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
  },
  computed: {
    ...mapState(houseStore, ["houses"]),
    ...mapState(mapStore, ["keyword"]),
  },
  watch: {},
  created() {},
  methods: {
    // 검색 결과 목록과 마커를 표출하는 함수입니다
    displayPlaces(places) {
      var listEl = document.getElementById("placesList");
      var menuEl = document.getElementById("menu_wrap");
      var fragment = document.createDocumentFragment();
      this.bounds = new kakao.maps.LatLngBounds();

      // 검색 결과 목록에 추가된 항목들을 제거합니다
      this.removeAllChildNods(listEl);

      // 지도에 표시되고 있는 마커를 제거합니다
      this.removeMarker();

      for (var i = 0; i < places.length; i++) {
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x);
        var marker = this.addMarker(placePosition, i);
        var itemEl = this.getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        this.bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function (marker, title) {
          kakao.maps.event.addListener(marker, "mouseover", function () {
            displayInfowindow(marker, title);
          });

          kakao.maps.event.addListener(marker, "mouseout", function () {
            this.infowindow.close();
          });

          itemEl.onmouseover = () => {
            this.displayInfowindow(marker, title);
          };

          itemEl.onmouseout = () => {
            this.infowindow.close();
          };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
      }

      // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
      listEl.appendChild(fragment);
      menuEl.scrollTop = 0;

      // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
      map.setBounds(this.bounds);
    },

    // 검색결과 항목을 Element로 반환하는 함수입니다
    getListItem(index, places) {
      var el = document.createElement("li"),
        itemStr =
          '<span class="markerbg marker_' +
          (index + 1) +
          '"></span>' +
          '<div class="info">' +
          "   <h5>" +
          places.place_name +
          "</h5>";

      if (places.road_address_name) {
        itemStr +=
          "    <span>" +
          places.road_address_name +
          "</span>" +
          '   <span class="jibun gray">' +
          places.address_name +
          "</span>";
      } else {
        itemStr += "    <span>" + places.address_name + "</span>";
      }

      itemStr += '  <span class="tel">' + places.phone + "</span>" + "</div>";

      el.innerHTML = itemStr;
      el.className = "item";

      return el;
    },

    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    addMarker(position, idx, title) {
      var imageSrc =
        "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"; // 마커 이미지 url, 스프라이트 이미지를 씁니다
      var imageSize = new kakao.maps.Size(36, 37); // 마커 이미지의 크기
      var imgOptions = {
        spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
        spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
        offset: new kakao.maps.Point(13, 37), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
      };
      var markerImage = new kakao.maps.MarkerImage(
        imageSrc,
        imageSize,
        imgOptions
      );
      var marker = new kakao.maps.Marker({
        position: position, // 마커의 위치
        image: markerImage,
      });

      marker.setMap(map); // 지도 위에 마커를 표출합니다
      this.markers.push(marker); // 배열에 생성된 마커를 추가합니다

      return marker;
    },

    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    removeMarker() {
      for (var i = 0; i < this.markers.length; i++) {
        this.markers[i].setMap(null);
      }
      this.markers = [];
    },

    // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
    displayPagination(pagination) {
      var paginationEl = document.getElementById("pagination");
      var fragment = document.createDocumentFragment();
      var i;

      // 기존에 추가된 페이지번호를 삭제합니다
      while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild(paginationEl.lastChild);
      }

      for (i = 1; i <= pagination.last; i++) {
        var el = document.createElement("a");
        el.href = "#";
        el.innerHTML = i;

        if (i === pagination.current) {
          el.className = "on";
        } else {
          el.onclick = (i) => {
            return () => {
              pagination.gotoPage(i);
            };
          };
        }

        fragment.appendChild(el);
      }
      paginationEl.appendChild(fragment);
    },

    // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
    // 인포윈도우에 장소명을 표시합니다
    displayInfowindow(marker, title) {
      var content = '<div style="padding:5px;z-index:1;">' + title + "</div>";

      this.infowindow.setContent(content);
      this.infowindow.open(map, marker);
    },

    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    removeAllChildNods(el) {
      while (el.hasChildNodes()) {
        el.removeChild(el.lastChild);
      }
    },
  },
};
</script>
<style lang="scss"></style>
