#include <stdio.h>
#include <stdlib.h>

#define MAX_SIZE 100
#define NUM_BUCKETS 256
#define NUM_PASSES 4

void radix_sort(float arr[], int n) {
    unsigned int *int_view = (unsigned int *) arr; 
    float temp[MAX_SIZE]; 
    unsigned int *temp_int_view = (unsigned int *) temp;
    int count[NUM_BUCKETS];
    
    for (int pass = 0; pass < NUM_PASSES; pass++) {
        int shift = pass * 8;
        
        
        for (int i = 0; i < NUM_BUCKETS; i++)
            count[i] = 0;
        
        
        for (int i = 0; i < n; i++) {
            unsigned int bucket = (int_view[i] >> shift) & 0xFF;
            count[bucket]++;
        }
        
        
        for (int i = 1; i < NUM_BUCKETS; i++)
            count[i] += count[i - 1];
        
        
        for (int i = n - 1; i >= 0; i--) {
            unsigned int bucket = (int_view[i] >> shift) & 0xFF;
            temp_int_view[--count[bucket]] = int_view[i];
        }
        
        
        for (int i = 0; i < n; i++)
            int_view[i] = temp_int_view[i];
    }
    
    
    float sorted[MAX_SIZE];
    int index = 0;
    
    
    for (int i = n - 1; i >= 0; i--) {
        if (int_view[i] & 0x80000000) 
            sorted[index++] = arr[i];
    }
    for (int i = 0; i < n; i++) {
        if (!(int_view[i] & 0x80000000)) 
            sorted[index++] = arr[i];
    }
    
    
    for (int i = 0; i < n; i++)
        arr[i] = sorted[i];
}

int main() {
    int n;
    float arr[MAX_SIZE];
    
    
    printf("Enter the number of elements (max %d): ", MAX_SIZE);
    scanf("%d", &n);
    if (n <= 0 || n > MAX_SIZE) {
        printf("Invalid number of elements.\n");
        return 1;
    }
    
    
    printf("Enter %d numbers:\n", n);
    for (int i = 0; i < n; i++) {
        scanf("%f", &arr[i]);
    }
    
    
    radix_sort(arr, n);
    
    
    printf("\nSorted numbers:\n");
    for (int i = 0; i < n; i++) {
        printf("%.2f\n", arr[i]);
    }
    
    return 0;
}
