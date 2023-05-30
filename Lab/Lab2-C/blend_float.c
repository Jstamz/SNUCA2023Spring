//-------------------------------------------------------------------------------------------------
// 4190.308 Computer Architecture                                                       Spring 2023
//
/// @file
/// @brief Image blending (float)
///        This module implements a function that blends two images together filter (floating-point
///        version). Note that CPython uses the 'double' data type for floating point numbers, 
///        so one may observe small differences in the output if the 'float' data type is used.
///
/// @author Bae Munsung <hamasoon@snu.ac.kr>
///
/// @section changelog Change Log
/// 2023/MM/DD Your Name Comment
///
//-------------------------------------------------------------------------------------------------

#include <stdlib.h>
#include "blend.h"


struct Image blend_float(struct Image img1, struct Image img2, int overlay, double alpha)
{
    if (img1.channels != 4) abort();


    // Initialize blended image
    struct Image blended = {
        .height   = img1.height,
        .width    = img1.width,
        .channels = img1.channels
    };
    blended.data = malloc(blended.height*blended.width*blended.channels*sizeof(uint8));
    if (blended.data == NULL) abort();


    for (size_t i = 0; i < blended.height; i++) {
        for (size_t j = 0; j < blended.width; j++) {
            for (size_t k = 0; k < blended.channels; k++) {
                if(overlay) {
                    if(k != 3) {
                        double overlay_ratio = img2.data[3 + blended.channels*(j + i*blended.width)] * alpha / 255.0;
                        double temp = img1.data[k + blended.channels*(j + i*blended.width)] * (1 - overlay_ratio);
                        temp += img2.data[k + blended.channels*(j + i*blended.width)] * overlay_ratio;
                            
                        blended.data[k + blended.channels*(j + i*blended.width)] = (uint8)(temp);
                    }
                    else {
                        blended.data[k + blended.channels*(j + i*blended.width)] = img1.data[k + blended.channels*(j + i*blended.width)];
                    }
                }
                else {
                    if(k != 3) {
                        double temp = (img1.data[k + blended.channels*(j + i*blended.width)] * img1.data[3 + blended.channels*(j + i*blended.width)] * (1 - alpha));
                        temp += (img2.data[k + blended.channels*(j + i*blended.width)] * img2.data[3 + blended.channels*(j + i*blended.width)] * alpha);
                        blended.data[k + blended.channels*(j + i*blended.width)] = (uint8)(temp / 255.0);
                    }
                    else {
                        double temp = (img1.data[3 + blended.channels*(j + i*blended.width)] * (1 - alpha));
                        temp += (img2.data[3 + blended.channels*(j + i*blended.width)] * alpha);
                        blended.data[k + blended.channels*(j + i*blended.width)] = (uint8)(temp);
                    }
                }
            }
        }
    }


    return blended;
}
