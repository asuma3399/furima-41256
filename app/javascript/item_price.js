const pay = () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const taxValue = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = taxValue;
    const profitNumber = document.getElementById("profit");
    let profitValue = inputValue - taxValue;
    profitValue = Math.floor(profitValue);  
    profitNumber.innerHTML = profitValue;

    console.log(`Fetching /items/${itemId}.js`);
  })
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);