+++
title = "Dynamic Programming"
date = "2025-51-31"
[taxonomies]
tags = ["dsa","notes"]
+++

## 0/1 Knapsack

### Brute force
    Take the ith(from last) once and dont take it the other time.
    ```c
    int k(int w[], int v[], int i, int W){
            //BASE since recursion
            if(W == 0 || i < 0)
                return 0;
            
            // NOT TAKING iTH
            int exclude = k(w,v,i-1,W);

            //TAKING iTH
            int include = 0;
            if(w[i] < W)
                include = v[i] + knapsack(w,v,i-1,W-w[i]);

            return (include > exclude) ? include : exclude;
        }
    ```

### DP
    Know that 
    + [i-1] is the current element
    + j is the sack size for now j runs 0->W
    + i is how many items allowed to pickup runs 0->n
    ```c
    int k(int w[], int v[], int n, int W){
            int dp[n+1][W+1];

            for(int i = 0; i <= n; i++){
                for(int j = 0; j<= W; j++){
                    if( i==0 || j==0)
                        dp[i][j] = 0;
                    else if( w[i-1] < j)                // when ith weight is less than limit there j
                        dp[i][j] = max(v[i-1] + dp[i-1][j - w[i]] , dp[i-1][j]);
                    else
                        dp[i-1][j];
                }
            }

            return dp[n][W];
        }
    ```
