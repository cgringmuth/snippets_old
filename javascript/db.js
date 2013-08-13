////////////////////////////////////////////////////////////////////////////////////////////////
// Self executing/invoking anonymous function
////////////////////////////////////////////////////////////////////////////////////////////////
(function() {
    alert(test)
})();


(function(window, document, undefined) {
    alert(test)
})(this, window); // this refers to the global object -> in global scope the window


////////////////////////////////////////////////////////////////////////////////////////////////
// don't this! setInterval is bad
////////////////////////////////////////////////////////////////////////////////////////////////
setInterval(function() {
    doStuff();
}, 100);

// better do this:
(function mainloop() {

    doStuff();

    setTimeout(mainloop, 100); // wait until doStuff is finished

})();


////////////////////////////////////////////////////////////////////////////////////////////////
// Use || operator to fill in a default value. NOTE: The variable has to be undefined!
////////////////////////////////////////////////////////////////////////////////////////////////
(function (b) {
    var a = b || "default";	// ok
    // var c = q || "default"; // error!

    alert(a);
})();


////////////////////////////////////////////////////////////////////////////////////////////////
// Object propertie retreival by . or by []
////////////////////////////////////////////////////////////////////////////////////////////////
var test = {foo: 'bar'};

test.foo	=== 'bar'	// true
test['foo'] === 'bar'	// true



////////////////////////////////////////////////////////////////////////////////////////////////
// Attempting retrieve value from undefined throws TypeError exception
////////////////////////////////////////////////////////////////////////////////////////////////
var obj = {}, defaultName = "Default name: Christoph";

obj.person 	// undefined
obj.person.name // throw "TypeError"
obj.person && obj.person.name // undefined

// ->
try { 
    var name = obj.person && obj.person.name;
    var nameStr = name || defaultName;
    alert("obj.test1.test: "+nameStr);
} catch (e) {
    alert(">>>>error thrown: "+e);
}


////////////////////////////////////////////////////////////////////////////////////////////////
// Object always used as reference:
////////////////////////////////////////////////////////////////////////////////////////////////
var a={}, b={}, c={}; // a,b,c refer to different objects

var a = b = c = {}; // a,b,c are referring to the same object


////////////////////////////////////////////////////////////////////////////////////////////////
// Minimize number of global variables creating one global Object which holds all content
////////////////////////////////////////////////////////////////////////////////////////////////
var MYAPP = {};

MYAPP = {
	varname1: 'foobar',
	varname2: 200,
	doSomething: function() {
		alert(this.varname2);
	},
	print: function() {
		alert("varname1: " + this.varname1 + ", varname2:" + this.varname2);
	}
};

MYAPP.doSomething();
MYAPP.print();


////////////////////////////////////////////////////////////////////////////////////////////////
// Adding object to global Object literal (Can be distributed to multiple files)
////////////////////////////////////////////////////////////////////////////////////////////////
MYAPP.myObject = {
    value: 0,
    increment: function (inc) {
        this.value += typeof inc === 'number' ? inc : 1;
    },
    print: function () {
        alert("value: "+this.value);
    }
};

MYAPP.myObject.increment();
MYAPP.myObject.print();	// -> 1
MYAPP.myObject.increment(2);
MYAPP.myObject.print();	// -> 3


////////////////////////////////////////////////////////////////////////////////////////////////
// Function Invocation Patter:
////////////////////////////////////////////////////////////////////////////////////////////////
// Problem:
var sum = add(3,4); // this in function add() is bounded to the global space!
// Thus no inner function has access to object

// easy workaround save "this" in local variable which is accessible to inner function ->
MYAPP.myObject.double = function () {
	var that = this; 	// workaround to provide access for inner helping function

	var helper = function () {
		// this -> refers to the global scope (often window), not to the object ("myObject")
		that.value += that.value;
	}

	helper();
}

MYAPP.myObject.double();
MYAPP.myObject.print();	// -> 6


////////////////////////////////////////////////////////////////////////////////////////////////
// Example of traversing the DOM tree by means of a recursive function
////////////////////////////////////////////////////////////////////////////////////////////////

// Define a walk_the_DOM function that visits every
// node of the tree in HTML source order, starting
// from some given node. It invokes a function,
// passing it each node in turn. walk_the_DOM calls
// itself to process each of the child nodes.

var walk_the_DOM = function walk(node, func) {
    func(node);
    node = node.firstChild;
    while (node) {
        walk(node, func);
        node = node.nextSibling;
    }
};

// Define a getElementsByAttribute function. It
// takes an attribute name string and an optional
// matching value. It calls walk_the_DOM, passing it a
// function that looks for an attribute name in the
// node. The matching nodes are accumulated in a
// results array.

var getElementsByAttribute = function (att, value) {
    var results = [];

    walk_the_DOM(document.body, function (node) {
        var actual = node.nodeType === 1 && node.getAttribute(att);
        if (typeof actual === 'string' &&
                (actual === value || typeof value !== 'string')) {
            results.push(node);
        }
    });

    return results;
};