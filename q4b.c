int x[] = {1, 2, 3, -1, -2, 0, 184, 340057058};
int y[] = {0, 0, 0, 0, 0, 0, 0, 0};

int f(int val){
    int t = 0;
    int comp =  0x80000000;
    while(val != 0){
        int n = (comp & val);
        if(n != 0){
            t++;
        }
        val *= 2;
    }
    return t;
}
int main(){
    for(int i = 0; i < 8; i++){
        y[i] = f(x[i]);
    } 
    for(int k = 0; k < 16; k++){
        if(k < 8) {
           printf("%d\n", x[k]);
        } else {
           printf("%d\n", y[k-8]);
        }
    }
    return 0;
}