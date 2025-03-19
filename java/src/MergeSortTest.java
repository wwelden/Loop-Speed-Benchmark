import org.junit.Test;
import static org.junit.Assert.*;

public class MergeSortTest {

    @Test
    public void testEmptyArray() {
        int[] arr = {};
        assertArrayEquals(new int[]{}, MergeSort.mergeSort(arr));
    }

    @Test
    public void testSingleElement() {
        int[] arr = {1};
        assertArrayEquals(new int[]{1}, MergeSort.mergeSort(arr));
    }

    @Test
    public void testTwoElements() {
        int[] arr = {2, 1};
        assertArrayEquals(new int[]{1, 2}, MergeSort.mergeSort(arr));
    }

    @Test
    public void testMultipleElements() {
        int[] arr = {5, 3, 8, 4, 2};
        assertArrayEquals(new int[]{2, 3, 4, 5, 8}, MergeSort.mergeSort(arr));
    }

    @Test
    public void testDuplicateElements() {
        int[] arr = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5};
        assertArrayEquals(new int[]{1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9}, MergeSort.mergeSort(arr));
    }

    @Test
    public void testNegativeNumbers() {
        int[] arr = {-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5};
        assertArrayEquals(new int[]{-5, -5, -5, -4, -3, -2, 1, 1, 3, 6, 9}, MergeSort.mergeSort(arr));
    }

    @Test
    public void testLargeArray() {
        int[] arr = new int[1000];
        for (int i = 0; i < arr.length; i++) {
            arr[i] = (int)(Math.random() * 1000);
        }
        int[] sortedArr = MergeSort.mergeSort(arr);
        for (int i = 1; i < sortedArr.length; i++) {
            assertTrue(sortedArr[i-1] <= sortedArr[i]);
        }
    }
}
