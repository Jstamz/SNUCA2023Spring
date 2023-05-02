//-------------------------------------------------------------------------------------------------
// 4190.308 Computer Architecture                                                       Spring 2023
//
/// @file
/// @brief Image blurring (float)
///        This module implements a function that blurs an image with a filter (floating-point 
///        version). Note that CPython uses the 'double' data type for floating point numbers, 
///        so one may observe small differences in the output if the 'float' data type is used.
///
/// @author Your Name <your@email.com>
///
/// @section changelog Change Log
/// 2023/MM/DD Your Name Comment
///
//-------------------------------------------------------------------------------------------------

#include <stdlib.h>
#include "blur.h"

struct Image blur_float(struct Image image, int kernel_size)
{
    // TODO
    // Your work goes here
    struct Image blured = {
        .height   = image.height - (kernel_size - 1),
        .width    = image.width - (kernel_size - 1),
        .channels = image.channels
    };
    blured.data = malloc(blured.height*blured.width*blured.channels*sizeof(uint8));
    if (blured.data == NULL) abort();

    float *kernel = malloc(kernel_size*kernel_size*sizeof(float));

    for (size_t i = 0; i < kernel_size; i++) {
        for (size_t j = 0; j < kernel_size; j++) {
            kernel[j + kernel_size * i] = 1.0f / (kernel_size * kernel_size);
        }
    }
    
    for (size_t i = 0; i < blured.height; i++) {
        for (size_t j = 0; j < blured.width; j++) {
            for (size_t k = 0; k < blured.channels; k++) {
                float temp = 0;

                for (size_t kx = 0; kx < kernel_size; kx++) {
                    for (size_t ky = 0; ky < kernel_size; ky++) {
                        temp += kernel[ky + kernel_size * kx] * image.data[k + image.channels*(j + ky + (i + kx)*image.width)];
                    }
                }

                blured.data[k + blured.channels*(j + i*blured.width)] = (uint8)temp;
            }
        }
    }

    free(kernel);

    // For now, we simply return the input image.
    // Fix/adjust once you have implemented your solution.
    return blured;
}
