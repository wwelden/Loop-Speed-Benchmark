using System;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MergeSort.Tests
{
    [TestClass]
    public class MergeSortTests
    {
        private static bool IsSorted<T>(T[] arr) where T : IComparable<T>
        {
            for (int i = 1; i < arr.Length; i++)
            {
                if (arr[i - 1].CompareTo(arr[i]) > 0)
                    return false;
            }
            return true;
        }

        [TestMethod]
        public void TestEmptyArray()
        {
            int[] arr = Array.Empty<int>();
            var result = MergeSort<int>.Sort(arr);
            Assert.AreEqual(0, result.Length);
            Assert.IsTrue(IsSorted(result));
        }

        [TestMethod]
        public void TestSingleElement()
        {
            int[] arr = { 1 };
            var result = MergeSort<int>.Sort(arr);
            Assert.AreEqual(1, result.Length);
            Assert.AreEqual(1, result[0]);
            Assert.IsTrue(IsSorted(result));
        }

        [TestMethod]
        public void TestTwoElements()
        {
            int[] arr = { 2, 1 };
            var result = MergeSort<int>.Sort(arr);
            Assert.AreEqual(2, result.Length);
            Assert.AreEqual(1, result[0]);
            Assert.AreEqual(2, result[1]);
            Assert.IsTrue(IsSorted(result));
        }

        [TestMethod]
        public void TestMultipleElements()
        {
            int[] arr = { 5, 3, 8, 4, 2 };
            var result = MergeSort<int>.Sort(arr);
            int[] expected = { 2, 3, 4, 5, 8 };
            CollectionAssert.AreEqual(expected, result);
            Assert.IsTrue(IsSorted(result));
        }

        [TestMethod]
        public void TestDuplicateElements()
        {
            int[] arr = { 3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5 };
            var result = MergeSort<int>.Sort(arr);
            Assert.IsTrue(IsSorted(result));
        }

        [TestMethod]
        public void TestNegativeNumbers()
        {
            int[] arr = { -3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5 };
            var result = MergeSort<int>.Sort(arr);
            Assert.IsTrue(IsSorted(result));
        }

        [TestMethod]
        public void TestLargeArray()
        {
            var random = new Random();
            int[] arr = Enumerable.Range(0, 1000)
                .Select(_ => random.Next(1000))
                .ToArray();
            var result = MergeSort<int>.Sort(arr);
            Assert.IsTrue(IsSorted(result));
        }

        [TestMethod]
        public void TestStrings()
        {
            string[] arr = { "banana", "apple", "cherry", "date", "elderberry" };
            var result = MergeSort<string>.Sort(arr);
            Assert.IsTrue(IsSorted(result));
        }

        [TestMethod]
        public void TestNullArray()
        {
            int[] arr = null;
            var result = MergeSort<int>.Sort(arr);
            Assert.IsNull(result);
        }
    }
}
