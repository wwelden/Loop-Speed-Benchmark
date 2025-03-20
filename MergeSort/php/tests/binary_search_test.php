<?php

use PHPUnit\Framework\TestCase;

class BinarySearchTest extends TestCase {
    private $binarySearch;

    protected function setUp(): void {
        require_once __DIR__ . '/../src/binary_search.php';
    }

    public function testTargetInMiddle() {
        $arr = [1, 2, 3, 4, 5];
        $this->assertEquals(2, binarySearch($arr, 3));
    }

    public function testTargetAtStart() {
        $arr = [1, 2, 3, 4, 5];
        $this->assertEquals(0, binarySearch($arr, 1));
    }

    public function testTargetAtEnd() {
        $arr = [1, 2, 3, 4, 5];
        $this->assertEquals(4, binarySearch($arr, 5));
    }

    public function testTargetNotPresent() {
        $arr = [1, 2, 3, 4, 5];
        $this->assertEquals(-1, binarySearch($arr, 6));
    }

    public function testEmptyArray() {
        $arr = [];
        $this->assertEquals(-1, binarySearch($arr, 1));
    }

    public function testSingleElement() {
        $arr = [1];
        $this->assertEquals(0, binarySearch($arr, 1));
    }

    public function testNegativeNumbers() {
        $arr = [-5, -3, -1, 0, 2];
        $this->assertEquals(1, binarySearch($arr, -3));
    }

    public function testDuplicateElements() {
        $arr = [1, 2, 2, 2, 3];
        $this->assertEquals(1, binarySearch($arr, 2));
    }

    public function testStringArray() {
        $arr = ['apple', 'banana', 'cherry', 'date', 'elderberry'];
        $this->assertEquals(2, binarySearch($arr, 'cherry'));
        $this->assertEquals(0, binarySearch($arr, 'apple'));
        $this->assertEquals(4, binarySearch($arr, 'elderberry'));
        $this->assertEquals(-1, binarySearch($arr, 'fig'));
    }

    public function testNullArray() {
        $this->expectException(TypeError::class);
        binarySearch(null, 1);
    }
}
