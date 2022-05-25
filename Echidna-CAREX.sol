// SPDX-License-Identifier: BSD-4-Clause
pragma solidity ^0.8.1;

import "ABDKMath64x64.sol";

contract Test {
    int128 internal zero = ABDKMath64x64.fromInt(0);
    int128 internal one = ABDKMath64x64.fromInt(1);
    int128 internal two = ABDKMath64x64.fromInt(2);
    int128 internal oneNegative = ABDKMath64x64.fromInt(-1);

    int128 internal constant MIN_64x64 = -0x80000000000000000000000000000000;
    int128 internal constant MAX_64x64 = 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

    event Value(string, int256);

    /*
     * Start wrapper functions
     */
    function add(int128 x, int128 y) public returns (int128) {
        return ABDKMath64x64.add(x, y);
    }

    function sub(int128 x, int128 y) public returns (int128) {
        return ABDKMath64x64.sub(x, y);
    }

    function mul(int128 x, int128 y) public returns (int128) {
        return ABDKMath64x64.mul(x, y);
    }

    function div(int128 x, int128 y) public returns (int128) {
        return ABDKMath64x64.div(x, y);
    }

    function neg(int128 x) public returns (int128) {
        return ABDKMath64x64.neg(x);
    }

    function abs(int128 x) public returns (int128) {
        return ABDKMath64x64.abs(x);
    }

    function inv(int128 x) public returns (int128) {
        return ABDKMath64x64.inv(x);
    }

    function avg(int128 x, int128 y) public returns (int128) {
        return ABDKMath64x64.avg(x, y);
    }

    function pow(int128 x, uint256 y) public returns (int128) {
        return ABDKMath64x64.pow(x, y);
    }

    function sqrt(int128 x) public returns (int128) {
        return ABDKMath64x64.sqrt(x);
    }

    function log_2(int128 x) public returns (int128) {
        return ABDKMath64x64.log_2(x);
    }

    function ln(int128 x) public returns (int128) {
        return ABDKMath64x64.ln(x);
    }

    function exp_2(int128 x) public returns (int128) {
        return ABDKMath64x64.exp_2(x);
    }

    function exp(int128 x) public returns (int128) {
        return ABDKMath64x64.exp(x);
    }

    function muli(int128 x, int256 y) public returns (int256) {
        return ABDKMath64x64.muli(x, y);
    }

    function mulu(int128 x, uint256 y) public returns (uint256) {
        return ABDKMath64x64.mulu(x, y);
    }

    function divi(int256 x, int256 y) public returns (int128) {
        return ABDKMath64x64.divi(x, y);
    }

    function divu(uint256 x, uint256 y) public returns (int128) {
        return ABDKMath64x64.divu(x, y);
    }

    function gavg(int128 x, int128 y) public returns (int128) {
        return ABDKMath64x64.gavg(x, y);
    }

    function fromInt(int256 x) public returns (int128) {
        return ABDKMath64x64.fromInt(x);
    }

    function toInt(int128 x) public returns (int64) {
        return ABDKMath64x64.toInt(x);
    }

    function fromUInt(uint256 x) public returns (int128) {
        return ABDKMath64x64.fromUInt(x);
    }

    function toIntRoundToZero(int128 x) public returns (int64) {
        if (x >= 0) return ABDKMath64x64.toInt(x);
        else return -ABDKMath64x64.toInt(neg(x));
    }

    /*
     * End wrapper functions
     */

    /*
     * @dev testing add function
     * @param x signed 64.64-bit fixed point number
     * @param y signed 64.64-bit fixed point number
     * @audit success
     */
    function testAdd(int128 x, int128 y) public {
        int128 xAddY = add(x, y);
        int128 yAddX = add(y, x);
        assert(xAddY == yAddX);
        assert(xAddY == x + y);
    }

    /*
     * @dev testing sub function
     * @param x signed 64.64-bit fixed point number
     * @param y signed 64.64-bit fixed point number
     * @audit success
     */
    function testSub(int128 x, int128 y) public {
        int128 xAddY = sub(x, y);
        assert(xAddY == x - y);
    }

    /*
     * @dev testing mul function
     * @param x signed 64.64-bit fixed point number
     * @param y signed 64.64-bit fixed point number
     * @audit success
     */
    function testMul(int128 x, int128 y) public {
        int128 xMulY = mul(x, y);
        int128 yMulX = mul(y, x);
        assert(xMulY == yMulX);

        int128 absMul = abs(xMulY);
        int128 absX = abs(x);
        int128 absY = abs(y);

        if (x == zero || y == zero) {
            assert(xMulY == 0);
        } else if (absX >= one) {
            //x >= 1
            if (absY >= one) {
                assert(absMul >= absX);
                assert(absMul >= absY);
            } else {
                assert(absMul <= absX);
                assert(absMul >= absY);
            }
        } else {
            // 0 < x < 1
            if (absY >= one) {
                // y > 0
                assert(absMul >= absX);
                assert(absMul <= absY);
            } else {
                assert(absMul <= absX);
                assert(absMul <= absY);
            }
        }
    }

    /*
     * @dev testing div function
     * @param x signed 64.64-bit fixed point number
     * @param y signed 64.64-bit fixed point number
     * @audit success
     */
    function testDiv(int128 x, int128 y) public {
        int128 xDivOne = div(x, one);
        assert(xDivOne == x);

        int128 zeroDivX = div(0, x);
        assert(zeroDivX == 0);

        int128 xDivOneNegative = mul(x, oneNegative);
        assert(xDivOneNegative == sub(0, x));
    }

    /*
     * @dev testing neg function
     * @param x signed 64.64-bit fixed point number
     * @audit success
     */
    function testNeg(int128 x) public {
        int128 negX = neg(x);
        assert(negX == mul(x, oneNegative));
    }

    /*
     * @dev testing abs function
     * @param x signed 64.64-bit fixed point number
     * @audit success
     */
    function testAbs(int128 x) public {
        int128 absX = abs(x);
        if (x < 0) {
            assert(absX == mul(x, oneNegative));
        } else {
            assert(absX == x);
        }
    }

    /*
     * @dev testing inv function
     * @param x signed 64.64-bit fixed point number
     * @audit success
     */
    function testInv(int128 x) public {
        int128 invX = inv(x);
        emit Value("invX", invX);
        if (x >= 0) {
            if (x < one) {
                assert(invX > x);
            } else {
                assert(invX <= x);
            }
        } else {
            if (x >= oneNegative) {
                emit Value("Aqui", invX);
                assert(invX <= x);
            } else {
                assert(invX > x);
            }
        }
    }

    /*
     * @dev testing avg function
     * @param x signed 64.64-bit fixed point number
     * @param y signed 64.64-bit fixed point number
     * @audit Call sequence:
     * 1.testAvg(-1,0)
     * Event sequence:
     * Panic(1)
     * Value("xAvgY", -1)
     * Value("(X+Y)/2", 0)
     * Issue caused by precision loss in calculating because of rounding down
     */
    function testAvg(int128 x, int128 y) public {
        int128 xAvgY = avg(x, y);
        int128 yAvgX = avg(y, x);
        emit Value("xAvgY", xAvgY);
        emit Value("(X+Y)/2", div(add(x, y), two));

        assert(xAvgY == yAvgX);
        assert(xAvgY == div(add(x, y), two));
    }

    /*
     * @dev testing pow function
     * @param x signed 64.64-bit fixed point number
     * @param y signed uint 256-bit number
     * @audit success
     */
    function testPow(int128 x, uint256 y) public {
        int128 xPowY = pow(x, y);

        emit Value("xPowY", xPowY);
        emit Value("x", x);
        emit Value("y", int256(y));
        if (y == 0) {
            assert(xPowY == one);
        } else {
            if (x >= 0) {
                if (x == 0) {
                    assert(xPowY == zero);
                } else if (x > 0 && x < one) {
                    assert(xPowY <= x);
                } else {
                    assert(xPowY >= x);
                }
            } else {
                int128 xAbs = abs(x);
                int128 powAbs = abs(xPowY);
                if (x < 0 && x > oneNegative) {
                    assert(powAbs <= xAbs);
                } else if (x <= oneNegative) {
                    assert(powAbs >= xAbs);
                }
            }
        }
    }

    /*
     * @dev testing sqrt function
     * @param x signed 64.64-bit fixed point number
     * @audit Call sequence:
     * 1.testSqrt(2)
     * Event sequence:
     * Panic(1)
     * Value("xSqrtY", 6074000999)
     * Value("xPow", 1)
     * Issue caused by precision loss in calculating because of rounding down
     */
    function testSqrt(int128 x) public {
        int128 xSqrtY = sqrt(x);
        int128 sqrtPow = pow(xSqrtY, 2);

        emit Value("xSqrtY", xSqrtY);
        emit Value("sqrtPow", sqrtPow);
        assert(sqrtPow == x);
    }

    /*
     * @dev testing log2 function
     * @param x signed 64.64-bit fixed point number
     * @audit success
     */
    function testLog2(int128 x) public {
        int128 xLog = log_2(x);
        if (x == one) {
            assert(xLog == zero);
        } else if (x < one) {
            assert(xLog < zero);
        } else {
            assert(xLog <= x);
        }
    }

    /*
     * @dev testing ln function
     * @param x signed 64.64-bit fixed point number
     * @audit success
     */
    function testLn(int128 x) public {
        int128 xLn = ln(x);
        if (x == one) {
            assert(xLn == zero);
        } else if (x < one) {
            assert(xLn < zero);
        } else {
            assert(xLn <= x);
        }
    }

    /*
     * @dev testing exp2 function
     * @param x signed 64.64-bit fixed point number
     * @audit success
     */
    function testExp2(int128 x) public {
        int128 xExp = exp_2(x);
        emit Value("xExp", xExp);
        if (x == zero) {
            assert(xExp == one);
        } else if (x < zero) {
            assert(xExp < one);
        } else {
            assert(xExp >= x);
        }
    }

    /*
     * @dev testing exp function
     * @param x signed 64.64-bit fixed point number
     * @audit success
     */
    function testExp(int128 x) public {
        int128 xExp = exp(x);
        emit Value("xExp", xExp);
        if (x == zero) {
            assert(xExp == one);
        } else if (x < zero) {
            assert(xExp < one);
        } else {
            assert(xExp >= x);
        }
    }

    /*
     * @dev testing muli function
     * @param x signed 64.64-bit fixed point number
     * @param y signed 256-bit number
     * @audit success
     */
    function testMuli(int128 x, int256 y) public {
        int256 xMuliY = muli(x, y);
        int256 xInt = int256(toIntRoundToZero(x));

        if (x == 0 || y == 0) {
            assert(xMuliY == 0);
        } else if (x > zero) {
            if (y > 0) {
                assert(xMuliY >= xInt);
            } else {
                assert(-xMuliY >= xInt);
            }
        } else {
            if (y > 0) {
                assert(xMuliY <= xInt);
            } else {
                assert(xMuliY >= -xInt);
            }
        }
    }

    /*
     * @dev testing mulu function
     * @param x signed 64.64-bit fixed point number
     * @param y unsigned 256-bit integer number
     * @audit success
     */
    function testMulu(int128 x, uint256 y) public {
        uint256 xMuluY = mulu(x, y);
        int128 absX = abs(x);
        uint256 xInt = uint256(int256(toIntRoundToZero(absX)));

        if (x == zero || y == 0) {
            assert(xMuluY == 0);
        } else if (x >= one) {
            assert(xMuluY >= xInt);
        } else {
            if (y == 1) {
                assert(xMuluY == xInt);
            }
        }
    }

    /*
     * @dev testing divi function
     * @param x signed 256-bit integer number
     * @param y signed 256-bit integer number
     * @audit success
     */
    function testDivi(int256 x, int256 y) public {
        int128 xDivY = divi(x, y);
        int256 divInt = toIntRoundToZero(xDivY);
        if (x == 0) {
            assert(xDivY == 0);
        }
    }

    /*
     * @dev testing divu function
     * @param x unsigned 256-bit integer number
     * @param y unsigned 256-bit integer number
     * @audit success
     */
    function testDivu(uint256 x, uint256 y) public {
        int128 xDivOne = divu(x, 1);
        int128 xInt = fromUInt(x);
        emit Value("xInt", xInt);
        emit Value("xDivOne", xDivOne);

        assert(xDivOne == xInt);

        int128 zeroDivX = divu(0, x);
        assert(zeroDivX == 0);
    }

    /*
     * @dev testing gavg function
     * @param x signed 64.64-bit fixed point number
     * @param y signed 64.64-bit fixed point number
     * @audit Call sequence:
     * 1.testGavg(1,1)
     * Event sequence:
     * Panic(1)
     * Value("xGavgOne", 1)
     * Value("xMulY", 0)
     * Value("avg", 0)
     * Issue caused by precision loss in calculating because of rounding down
     */
    function testGavg(int128 x, int128 y) public {
        int128 xGavgOne = gavg(x, y);

        int128 xMulY = mul(x, y);
        int128 resultAvg = sqrt(xMulY);

        emit Value("xGavgOne", xGavgOne);
        emit Value("xMulY", xMulY);
        emit Value("resultAvg", resultAvg);

        assert(xGavgOne == resultAvg);
    }
}
