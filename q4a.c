int arr[] = {0,0,0,0,0,0,0,0,0,0};
int *base = arr;

void add(int val, int offset){
    val = arr[offset] + val;
    arr[offset] = val;
}

void main(){
    int var1 = 1;
    int var2 = 2;
    add(3,4);
    add(var1,var2);
    for (int x = 0; x < 10; x++)
        printf("%d\n", arr[x]);
}

