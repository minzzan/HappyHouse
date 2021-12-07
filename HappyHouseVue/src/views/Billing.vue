<!-- 
	This is the billing page, it uses the dashboard layout in: 
	"./layouts/Dashboard.vue" .
 -->

<template>
  <div>
    <a-row type="flex" :gutter="24">
      <!-- Billing Information Column -->
      <a-col :span="24" :md="12" class="mb-24">
        <!-- Billing Information Card -->
        <CardBillingInfo></CardBillingInfo>
        <!-- / Billing Information Card -->
      </a-col>
      <!-- Billing Information Column -->

      <!-- Your Transactions Column -->
      <a-col :span="24" :md="12" class="mb-24">
        <a-row :span="12" :md="12">
          <CardTransactions :data="transactionsData"></CardTransactions>
        </a-row>
        <a-row :span="12" :md="12" class="mt-40">
          <house-list class="mt-20" />
        </a-row>
        <!-- Your Transactions Card -->

        <!-- / Your Transactions Card -->
      </a-col>
      <!-- / Your Transactions Column -->
    </a-row>
    <house-info class="mt-20" />
  </div>
</template>

<script>
import CardBillingInfo from "@/components/Cards/CardBillingInfo";
import CardTransactions from "@/components/Cards/CardTransactions";
import HouseList from "@/components/Cards/HouseList.vue";
import HouseInfo from "@/components/Cards/HouseInfo.vue";
// Salary cards data

export default {
  components: {
    CardBillingInfo,
    CardTransactions,
    HouseInfo,
    HouseList,
  },
  data() {
    return {};
  },
};
</script>

<style lang="scss"></style>
