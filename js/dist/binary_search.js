"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.binarySearch = binarySearch;
const fs = __importStar(require("fs"));
/**
 * Performs binary search to find the index of target in a sorted array.
 * @param {number[]} arr - A sorted array of integers
 * @param {number} target - The value to search for
 * @returns {number} The index of target if found, -1 otherwise
 *
 * @example
 * const arr = [1, 2, 3, 4, 5];
 * binarySearch(arr, 3); // returns 2
 * binarySearch(arr, 6); // returns -1
 *
 * @complexity
 * Time: O(log n)
 * Space: O(1)
 */
function binarySearch(arr, target) {
    if (!arr || arr.length === 0) {
        return -1;
    }
    let left = 0;
    let right = arr.length - 1;
    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] === target) {
            return mid;
        }
        else if (arr[mid] < target) {
            left = mid + 1;
        }
        else {
            if (mid === 0) {
                break;
            }
            right = mid - 1;
        }
    }
    return -1;
}
// Read test data from file
function main() {
    const filename = process.argv[2] || 'test_data.txt';
    const data = fs.readFileSync(filename, 'utf8')
        .split('\n')
        .map(Number)
        .filter((n) => !isNaN(n));
    // Test with a few values
    const testValues = [
        data[Math.floor(data.length / 2)], // Middle value
        data[0], // First value
        data[data.length - 1], // Last value
        -999999, // Value not in array
    ];
    for (const target of testValues) {
        const result = binarySearch(data, target);
        console.log(`Target: ${target}, Result: ${result}`);
    }
}
// Only run main if this file is being run directly
if (require.main === module) {
    main();
}
