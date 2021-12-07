<template>
  <a-container class="bv-example-row mt-3">
    <a-row>
      <a-col>
        <h3>글작성</h3>
      </a-col>
    </a-row>
    <board-write-form type="register" />
  </a-container>
</template>

<script>
import BoardWriteForm from "./child/BoardWriteForm.vue";

export default {
  name: "BoardWrite",
  components: {
    BoardWriteForm,
  },
};
</script>

<style></style>
