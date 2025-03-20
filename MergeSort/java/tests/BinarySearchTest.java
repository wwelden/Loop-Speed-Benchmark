import org.junit.Test;
import static org.junit.Assert.*;

public class BinarySearchTest {
    @Test
    public void testTargetInMiddle() {
        int[] arr = {1, 2, 3, 4, 5};
        assertEquals(2, BinarySearch.binarySearch(arr, 3));
    }

    @Test
    public void testTargetAtStart() {
        int[] arr = {1, 2, 3, 4, 5};
        assertEquals(0, BinarySearch.binarySearch(arr, 1));
    }

    @Test
    public void testTargetAtEnd() {
        int[] arr = {1, 2, 3, 4, 5};
        assertEquals(4, BinarySearch.binarySearch(arr, 5));
    }

    @Test
    public void testTargetNotPresent() {
        int[] arr = {1, 2, 3, 4, 5};
        assertEquals(-1, BinarySearch.binarySearch(arr, 6));
    }

    @Test
    public void testEmptyArray() {
        int[] arr = {};
        assertEquals(-1, BinarySearch.binarySearch(arr, 1));
    }

    @Test
    public void testSingleElement() {
        int[] arr = {1};
        assertEquals(0, BinarySearch.binarySearch(arr, 1));
    }

    @Test
    public void testNegativeNumbers() {
        int[] arr = {-5, -3, -1, 0, 2};
        assertEquals(1, BinarySearch.binarySearch(arr, -3));
    }

    @Test
    public void testDuplicateElements() {
        int[] arr = {1, 2, 2, 2, 3};
        assertEquals(1, BinarySearch.binarySearch(arr, 2));
    }

    @Test(expected = IllegalArgumentException.class)
    public void testNullArray() {
        BinarySearch.binarySearch(null, 1);
    }
}
