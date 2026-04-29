// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;


contract Demo {
    uint8 public myVal = 254;

    function inc() public {
        // myVal = myVal + 1;
        // myVal += 1;
        unchecked {
            myVal++; // myVal--
        }
    }
    // uint public maximum;

    // function demo() public {
    //     maximum = type(uint8).max;
    // }
  //  unsigned integers;
  // 2 ** 256

// uint8 public  mySmallUint = 2;
// 2 ** 8 = 256
// 0 ---> (256-1)
// uint 
//   function studentdiary(uint _inputUint) public {
//     uint localUint = 42;
//   }

//   //  signed integers;
//   int public myInt = -42;
//   localUint + 1;
//   localUint - 1;
//   localUint * 2;
//   localUint / 2;
//   localUint ** 3;
//   localUint % 3;
//   -myInt;

//   localUint == 1;
//   localUint != 1;
//   localUint > 1;
//   localUint >= 1;
//   localUint < 2;
//   lcoalUint <= 2;


  //  bool public myBool = true; // state

   // function myFunc(bool _inputBool) public {
     //  bool localBool = false; // local
      //  localBool && _inputBool
        //localBoot || _inputBool
        //localBoot == _inputBool
        //localBoot != _inputBool
        //!localBool
       // if(_inputBool || localBool) {

        //}
   // }

}
