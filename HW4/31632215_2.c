#include <stdio.h>
#define SIZE 100
#define RADIX 16 

void radix_sort_hex(unsigned int A[], unsigned int n) {
    unsigned int buckets[RADIX][SIZE];
    unsigned int bucket_counts[RADIX];
    unsigned int mask = 0xF;

    for (int d = 0; d < 8; d++) { 
        for (int i = 0; i < RADIX; i++) {
            bucket_counts[i] = 0; 
        }

        for (int i = 0; i < n; i++) {
            unsigned int digit = (A[i] >> (4 * d)) & mask;
            buckets[digit][bucket_counts[digit]++] = A[i];
        }

        int index = 0;
        for (int i = 0; i < RADIX; i++) {
            for (int j = 0; j < bucket_counts[i]; j++) {
                A[index++] = buckets[i][j];
            }
        }
    }
}

void radix_sort_signed_hex(int A[], int n) {
    int positive[SIZE], negative[SIZE];
    int pos_count = 0, neg_count = 0;

    for (int i = 0; i < n; i++) {
        if (A[i] >= 0) {
            positive[pos_count++] = A[i];
        } else {
            negative[neg_count++] = ~A[i]; 
        }
    }

    radix_sort_hex((unsigned int*)positive, pos_count);
    radix_sort_hex((unsigned int*)negative, neg_count);

    for (int i = neg_count - 1; i >= 0; i--) {
        A[neg_count - 1 - i] = ~negative[i]; 
    }
    for (int i = 0; i < pos_count; i++) {
        A[i + neg_count] = positive[i];
    }
}

int main() {
    int n;
    int A[SIZE];
    
    
    printf("Enter the number of elements (max %d): ", SIZE);
    scanf("%d", &n);
    if (n <= 0 || n > SIZE) {
        printf("Invalid number of elements.\n");
        return 1;
    }
    
    
    printf("Enter %d numbers:\n", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &A[i]);
    }
    
    
    radix_sort_signed_hex(A, n);
    
    
    printf("\nSorted numbers:\n");
    for (int i = 0; i < n; i++) {
        printf("%d\n", A[i]);
    }
    
    return 0;
}