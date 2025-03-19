#!/usr/bin/env node
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
exports.mergeSort = mergeSort;
/**
 * Merge sort implementation in TypeScript
 * Time complexity: O(n log n)
 * Space complexity: O(n)
 *
 * @param {number[]} arr The array to sort
 * @returns {number[]} The sorted array
 */
function mergeSort(arr) {
    if (arr.length <= 1)
        return arr;
    // Split array into two halves
    const mid = Math.floor(arr.length / 2);
    const left = arr.slice(0, mid);
    const right = arr.slice(mid);
    // Recursively sort both halves
    const sortedLeft = mergeSort(left);
    const sortedRight = mergeSort(right);
    // Merge the sorted halves
    return merge(sortedLeft, sortedRight);
}
/**
 * Helper function to merge two sorted arrays
 *
 * @param {number[]} left First sorted array
 * @param {number[]} right Second sorted array
 * @returns {number[]} Merged sorted array
 */
function merge(left, right) {
    const result = [];
    let i = 0;
    let j = 0;
    // Compare elements from both arrays and merge them
    while (i < left.length && j < right.length) {
        if (left[i] <= right[j]) {
            result.push(left[i]);
            i++;
        }
        else {
            result.push(right[j]);
            j++;
        }
    }
    // Copy remaining elements from left array
    result.push(...left.slice(i));
    // Copy remaining elements from right array
    result.push(...right.slice(j));
    return result;
}
// Check if file path is provided
if (process.argv.length < 3) {
    console.error("Please provide a file path as an argument");
    process.exit(1);
}
// Read numbers from file
const fs = __importStar(require("fs"));
const numbers = fs.readFileSync(process.argv[2], 'utf8')
    .split('\n')
    .filter((line) => line.trim())
    .map(Number);
// Sort the array
const sortedNumbers = mergeSort(numbers);
// Write sorted numbers back to file
fs.writeFileSync('sorted_data.txt', sortedNumbers.join('\n'));
