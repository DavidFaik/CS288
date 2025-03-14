#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>

#define MAX_PATH 1000

int count_lines_in_file(const char *filepath) {
    FILE *file = fopen(filepath, "r");

    int lines = 0;
    char ch;
    while ((ch = fgetc(file)) != EOF) {
        if (ch == '\n') {
            lines++;
        }
    }
    fclose(file);
    return lines;
}

void traverse_directory(const char *dirpath, int *total_lines) {
    DIR *dir = opendir(dirpath);

    struct dirent *entry;
    struct stat path_stat;
    char fullpath[MAX_PATH];

    while ((entry = readdir(dir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }

	snprintf(fullpath, MAX_PATH, "%s/%s", dirpath, entry->d_name);

	if (stat(fullpath, &path_stat) == 0) {
            if (S_ISDIR(path_stat.st_mode)) {
                traverse_directory(fullpath, total_lines);
            } else if (S_ISREG(path_stat.st_mode) && strstr(entry->d_name, ".txt")) {
                *total_lines += count_lines_in_file(fullpath);
            }
        }
    }
    closedir(dir);
}

int main() {
    char dirpath[MAX_PATH];
    printf("Enter directory path: ");
    scanf("%999s", dirpath);
    
    int total_lines = 0;
    traverse_directory(dirpath, &total_lines);
    printf("Total lines across all .txt files: %d\n", total_lines);
    
    return 0;
}

