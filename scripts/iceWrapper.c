#include <stdlib.h>
#include <stdio.h>

#define ICEWRITER "lib/elgal/elIce/iceWriter.pl" 

int main(int argc, char **argv) {
    int x = setuid(0);
    int y = seteuid(0);
    int z = execv(ICEWRITER, argv);
    return 1;
}
