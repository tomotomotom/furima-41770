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
    e.preventDefault();
      payjp.createToken(numberElement).then(function (response) {
        if (response.error) {
        console.error(response.error.message);
        } else {
          const token = response.id;
        console.log("Generated token:", token); // トークンの値を確認

        const tokenObj = document.createElement('input');
        tokenObj.setAttribute('type', 'hidden');
        tokenObj.setAttribute('name', 'order_form[token]');
        tokenObj.setAttribute('value', token);
        form.appendChild(tokenObj);

        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        form.submit();
      }
    });
  });
};
  window.addEventListener("turbo:load", pay);
  window.addEventListener("turbo:render", pay);