
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <iostream>
#include <random>

#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/sort.h>
#include <thrust/random.h>
#include <thrust/unique.h>

#define MILLION             1'000'000
#define NUMBER_OF_ELEMENTS  10 * MILLION
#define NUMBER_OF_UNIQUE    1'000


int main(void)
{
    thrust::host_vector<int> h_vec(NUMBER_OF_ELEMENTS);

    std::random_device rd;
    thrust::default_random_engine rng(rd());
    thrust::uniform_int_distribution<int> dist(0, NUMBER_OF_UNIQUE);

    thrust::generate(h_vec.begin(), h_vec.end(), [&] { return dist(rng); });

    thrust::device_vector<int> d_vec = h_vec;

    thrust::sort(d_vec.begin(), d_vec.end());
    auto last = thrust::unique(d_vec.begin(), d_vec.end());

    std::cout << "Unique values: ";
    for (auto it = d_vec.begin(); it != last; ++it)
    {
        std::cout << *it << " ";
    }

    return 0;
}
