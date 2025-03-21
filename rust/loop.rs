use rand::Rng;
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Please provide a number as command line argument");
        std::process::exit(1);
    }

    let input: i32 = match args[1].parse() {
        Ok(num) => num,
        Err(_) => {
            eprintln!("Please provide a valid integer");
            std::process::exit(1);
        }
    };

    let mut rng = rand::thread_rng();
    let r = rng.gen_range(0..10000);           // Get a random number 0 <= r < 10k
    let mut a = vec![0i32; 10000];             // Array of 10k elements initialized to 0

    for i in 0..10000 {                        // 10k outer loop iterations
        for j in 0..100000 {                   // 100k inner loop iterations, per outer loop iteration
            a[i] = a[i] + (j % input as i32);  // Simple sum
        }
        a[i] += r;                             // Add a random value to each element in array
    }

    println!("{}", a[r as usize]);             // Print out a single element from the array
}
