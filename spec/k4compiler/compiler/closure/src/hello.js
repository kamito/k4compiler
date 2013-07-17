(function() {

    var helloFunction = function() {
        this.var_ = "Hello Closure compiler";
    };

    helloFunction.prototype.alert = function() {
        alert(this.var_);
    };


    var h = new helloFunction();
    h.alert();

})();
