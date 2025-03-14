#include <stdio.h>
#include <stdlib.h>

#define MAX_DIM 100

int main() {
    FILE *file1, *file2, *file_out;
    int n1, n2, n;
    
    // Open matrix1.bin and matrix2.bin for reading
    file1 = fopen("matrix1.bin", "rb");
    file2 = fopen("matrix2.bin", "rb");
    
    // Read the dimension of the matrices
    fread(&n1, sizeof(int), 1, file1);
    fread(&n2, sizeof(int), 1, file2);
    
    if (n1 != n2 || n1 > MAX_DIM) {
        printf("Error: Incompatible matrix dimensions or exceeding maximum allowed size.\n");
        fclose(file1);
        fclose(file2);
        return 1;
    }
    
    n = n1;
    int matrix1[n][n][n], matrix2[n][n][n], result_matrix[n][n][n];
    
    // Read the elements of the matrices
    fread(matrix1, sizeof(int), n * n * n, file1);
    fread(matrix2, sizeof(int), n * n * n, file2);
    
    // Close the input files
    fclose(file1);
    fclose(file2);
    
    // Perform element-wise multiplication
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < n; k++) {
                result_matrix[i][j][k] = matrix1[i][j][k] * matrix2[i][j][k];
            }
        }
    }
    
    // Open result.bin for writing
    file_out = fopen("result.bin", "wb");
     
    // Write the dimension of the result_matrix
    fwrite(&n, sizeof(int), 1, file_out);
    
    // Write the elements of the result_matrix
    fwrite(result_matrix, sizeof(int), n * n * n, file_out);
    
    // Close the output file
    fclose(file_out);
    
    printf("Matrix multiplication completed. Result saved in result.bin.\n");
    return 0;
}

