const price = () => {
    const item_price = document.getElementById("item-price");
    const add_tax_price = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    item_price.addEventListener("input", () => {
      const price = parseInt(item_price.value) || 0;
      const tax_price = price * 0.1;
      const expected_profit = price - tax_price;
      add_tax_price.textContent = Math.floor(tax_price); // 小数点以下を切り捨て
      profit.textContent = Math.floor(expected_profit);  // 小数点以下を切り捨て
    });
  };


window.addEventListener("turbo:load", price )
window.addEventListener("turbo:render", price)