<template>
  <a-container class="bv-example-row mt-3">
    <a-row>
      <a-col>
        <h3>답변 작성</h3>
      </a-col>
    </a-row>
    <answer-write-form type="register" />
  </a-container>
</template>

<script>
import AnswerWriteForm from "./child/AnswerWriteForm.vue";

export default {
  name: "AnswerWrite",
  components: {
    AnswerWriteForm,
  },
};
</script>

<style></style>
