using System;
using Xunit;

namespace BinarySearch.Tests
{
    public class BinarySearchTests
    {
        [Fact]
        public void TestTargetInMiddle()
        {
            int[] arr = { 1, 2, 3, 4, 5 };
            Assert.Equal(2, BinarySearch.Search(arr, 3));
        }

        [Fact]
        public void TestTargetAtStart()
        {
            int[] arr = { 1, 2, 3, 4, 5 };
            Assert.Equal(0, BinarySearch.Search(arr, 1));
        }

        [Fact]
        public void TestTargetAtEnd()
        {
            int[] arr = { 1, 2, 3, 4, 5 };
            Assert.Equal(4, BinarySearch.Search(arr, 5));
        }

        [Fact]
        public void TestTargetNotPresent()
        {
            int[] arr = { 1, 2, 3, 4, 5 };
            Assert.Equal(-1, BinarySearch.Search(arr, 6));
        }

        [Fact]
        public void TestEmptyArray()
        {
            int[] arr = Array.Empty<int>();
            Assert.Equal(-1, BinarySearch.Search(arr, 1));
        }

        [Fact]
        public void TestSingleElement()
        {
            int[] arr = { 1 };
            Assert.Equal(0, BinarySearch.Search(arr, 1));
        }

        [Fact]
        public void TestNegativeNumbers()
        {
            int[] arr = { -5, -3, -1, 0, 2 };
            Assert.Equal(1, BinarySearch.Search(arr, -3));
        }

        [Fact]
        public void TestDuplicateElements()
        {
            int[] arr = { 1, 2, 2, 2, 3 };
            Assert.Equal(1, BinarySearch.Search(arr, 2));
        }

        [Fact]
        public void TestNullArray()
        {
            Assert.Throws<ArgumentNullException>(() => BinarySearch.Search(null, 1));
        }
    }
}
