function paystackPopUp( pkTest, email, amount, ref, onClosed, callback){
    let handler = PaystackPop.setup({
       key: pkTest,
       email: email,
       amount: amount,
       onClose: function(){
            alert("Transaction cancelled!.");
            onClosed();
        },
       callback: function (response){
            callback();
            let message = "Payment successful!";
            alert(message);
        }
    });
    return handler.openIframe();
}