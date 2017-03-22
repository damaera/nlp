var TestRunner = function (tests) {
    var self = this;

    self._tests = tests;
    self._failed = 0;

    self.run = function () {
        for (var i = 0; i < self._tests.length; i++) {
            var test = self._tests[i];
            test.run();
            self._printResult(test);
        }
        self._printSummary();
    }

    self._printResult = function (test) {
        if (test.passed == true) {
            console.log("PASS: " + test.name);
        }
        else {
            self._failed++;
            console.log("FAIL: " + test.name);
        }
    }

    self._printSummary = function () {
        console.log("");
        if (self._failed == 0) {
            console.log("All " + self._tests.length + " tests passed.");
        }
        else {
            console.log(self._failed + " of " + self._tests.length + " tests failed.");
        }
    }
}

var Test = function (name, test) {
    var self = this;

    self.name = name;
    self.test = test;
    self.passed = true;

    self.expect = function (result) {
        if (result != true) {
            self.passed = false;
        }
    }

    self.run = function () {
        self.test(self);
    }
}

var tests = [];
var r = require('../regexpbuilder');
tests.push(new Test("startOfLine", function (self) {
    var regex = r
        .startOfLine()
        .exactly(1).of("p")
        .getRegExp();

    self.expect(regex.test("p"));
    self.expect(!regex.test("qp"));
}));

tests.push(new Test("endOfLine", function (self) {
    var regex = r
        .exactly(1).of("p")
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("p"));
    self.expect(!regex.test("pq"));
}));

tests.push(new Test("eitherLike orLike", function (self) {
    var regex = r
        .startOfLine()
        .either(r.exactly(1).of("p"))
        .or(r.exactly(2).of("q"))
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("p"));
    self.expect(regex.test("qq"));
    self.expect(!regex.test("pqq"));
    self.expect(!regex.test("qqp"));
}));

tests.push(new Test("orLike chain", function (self) {
    var regex = r
        .either(r.exactly(1).of("p"))
        .or(r.exactly(1).of("q"))
        .or(r.exactly(1).of("r"))
        .getRegExp();

    self.expect(regex.test("p"));
    self.expect(regex.test("q"));
    self.expect(regex.test("r"));
    self.expect(!regex.test("s"));
}));

tests.push(new Test("either or", function (self) {
    var regex = r
        .either("p")
        .or("q")
        .getRegExp();

    self.expect(regex.test("p"));
    self.expect(regex.test("q"));
    self.expect(!regex.test("r"));
}));

tests.push(new Test("exactly", function (self) {
    var regex = r
        .startOfLine()
        .exactly(3).of("p")
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("ppp"));
    self.expect(!regex.test("pp"));
    self.expect(!regex.test("pppp"));
}));

tests.push(new Test("min", function (self) {
    var regex = r
        .startOfLine()
        .min(2).of("p")
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("pp"));
    self.expect(regex.test("ppp"));
    self.expect(regex.test("ppppppp"));
    self.expect(!regex.test("p"));
}));

tests.push(new Test("max", function (self) {
    var regex = r
        .startOfLine()
        .max(3).of("p")
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("p"));
    self.expect(regex.test("pp"));
    self.expect(regex.test("ppp"));
    self.expect(!regex.test("pppp"));
    self.expect(!regex.test("pppppppp"));
}));

tests.push(new Test("min max", function (self) {
    var regex = r
        .startOfLine()
        .min(3).max(7).of("p")
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("ppp"));
    self.expect(regex.test("ppppp"));
    self.expect(regex.test("ppppppp"));
    self.expect(!regex.test("pp"));
    self.expect(!regex.test("p"));
    self.expect(!regex.test("pppppppp"));
    self.expect(!regex.test("pppppppppppp"));
}));

tests.push(new Test("of", function (self) {
    var regex = r
        .startOfLine()
        .exactly(2).of("p p p ")
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("p p p p p p "));
    self.expect(!regex.test("p p p p pp"));
}));

tests.push(new Test("ofAny", function (self) {
    var regex = r
        .startOfLine()
        .exactly(3).ofAny()
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("pqr"));
}));

tests.push(new Test("ofGroup", function (self) {
    var regex = r
        .startOfLine()
        .exactly(3).of("p").asGroup()
        .exactly(1).of("q")
        .exactly(1).ofGroup(1)
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("pppqppp"));
}));

tests.push(new Test("from", function (self) {
    var someLetters = ["p", "q", "r"];
    var regex = r
        .startOfLine()
        .exactly(3).from(someLetters)
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("ppp"));
    self.expect(regex.test("qqq"));
    self.expect(regex.test("ppq"));
    self.expect(regex.test("rqp"));
    self.expect(!regex.test("pyy"));
}));

tests.push(new Test("notFrom", function (self) {
    var someLetters = ["p", "q", "r"];
    var regex = r
        .startOfLine()
        .exactly(3).notFrom(someLetters)
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("lmn"));
    self.expect(!regex.test("mnq"));
}));

tests.push(new Test("like", function (self) {
    var pattern = r
        .min(1).of("p")
        .min(2).of("q");

    var regex = r
        .startOfLine()
        .exactly(2).like(pattern)
        .endOfLine()
        .getRegExp();

    self.expect(regex.test("pqqpqq"));
    self.expect(!regex.test("qppqpp"));
}));

tests.push(new Test("reluctantly", function (self) {
    var regex = r
        .exactly(2).of("p")
        .min(2).ofAny().reluctantly()
        .exactly(2).of("p")
        .getRegExp();

    self.expect(regex.exec("pprrrrpprrpp")[0] == "pprrrrpp");
}));

tests.push(new Test("ahead", function (self) {
    var regex = r
        .exactly(1).of("dart")
        .ahead(r.exactly(1).of("lang"))
        .getRegExp();

    self.expect(regex.exec("dartlang")[0] == "dart");
    self.expect(!regex.test("dartpqr"));
}));

tests.push(new Test("notAhead", function (self) {
    var regex = r
        .exactly(1).of("dart")
        .notAhead(r.exactly(1).of("pqr"))
        .getRegExp();

    self.expect(regex.test("dartlang"));
    self.expect(!regex.test("dartpqr"));
}));

tests.push(new Test("asGroup", function (self) {
    var regex = r
        .min(1).max(3).of("p")
        .exactly(1).of("dart").asGroup()
        .exactly(1).from(["p", "q", "r"])
        .getRegExp();

    self.expect(regex.exec("pdartq")[1] == "dart");
}));

var testRunner = new TestRunner(tests);
testRunner.run();
