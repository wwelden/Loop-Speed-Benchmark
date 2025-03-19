use rand::Rng;

fn merge(arr: &mut [i32], left: &[i32], right: &[i32]) {
    let mut i = 0;
    let mut j = 0;
    let mut k = 0;

    while i < left.len() && j < right.len() {
        if left[i] <= right[j] {
            arr[k] = left[i];
            i += 1;
        } else {
            arr[k] = right[j];
            j += 1;
        }
        k += 1;
    }

    while i < left.len() {
        arr[k] = left[i];
        i += 1;
        k += 1;
    }

    while j < right.len() {
        arr[k] = right[j];
        j += 1;
        k += 1;
    }
}

fn merge_sort(arr: &mut [i32]) {
    if arr.len() <= 1 {
        return;
    }

    let mid = arr.len() / 2;
    let mut temp = vec![0; arr.len()];
    temp[..].copy_from_slice(arr);

    let (left, right) = temp.split_at_mut(mid);

    merge_sort(left);
    merge_sort(right);

    merge(arr, left, right);
}

fn generate_random_array(size: usize) -> Vec<i32> {
    let mut rng = rand::thread_rng();
    (0..size).map(|_| rng.gen_range(0..10000)).collect()
}

fn main() {
    const ARRAY_SIZE: usize = 1000;
    const ITERATIONS: usize = 100;

    for _ in 0..ITERATIONS {
        let mut arr = generate_random_array(ARRAY_SIZE);
        merge_sort(&mut arr);
    }
}
