const pay = () => {
    const publicKey = gon.public_key
    const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');
  
    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');
    const form = document.getElementById('charge-form')

    form.addEventListener("submit", (e) => {
      payjp.createToken(numberElement).then(function (response) {
        if (response.error) {
        }else{
        const token = response.id;
        const tokenObj = document.createElement('input');
        tokenObj.setAttribute('type', 'hidden');
        tokenObj.setAttribute('name', 'order_form[token]');
        tokenObj.setAttribute('value', token);
        renderDom.insertAdjacentHTML(tokenObj);
        }
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        document.getElementById("charge-form").submit();
    });
    e.preventDefault();
  });
};
window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);