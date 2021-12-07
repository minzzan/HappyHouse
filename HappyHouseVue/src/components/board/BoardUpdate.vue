<template>
  <a-container class="bv-example-row mt-3">
    <a-row>
      <a-col>
        <h3>글수정</h3>
      </a-col>
    </a-row>
    <board-write-form type="modify" />
  </a-container>
</template>

<script>
import BoardWriteForm from "./child/BoardWriteForm.vue";

export default {
  name: "BoardUpdate",
  components: {
    BoardWriteForm,
  },
};
</script>

<style></style>
