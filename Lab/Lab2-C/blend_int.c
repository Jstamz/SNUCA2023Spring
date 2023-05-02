//-------------------------------------------------------------------------------------------------
// 4190.308 Computer Architecture                                                       Spring 2023
//
/// @file
/// @brief Image blending (int)
///        This module implements a function that blends two images together filter (integer
///        version)
///
/// @author Your Name <your@email.com>
///
/// @section changelog Change Log
/// 2023/MM/DD Your Name Comment
///
//-------------------------------------------------------------------------------------------------

#include <stdlib.h>
#include "blend.h"


struct Image blend_int(struct Image img1, struct Image img2, int overlay, int alpha)
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
                        uint8 overlay_ratio = img2.data[3 + blended.channels*(j + i*blended.width)] * alpha >> 8;
                            
                        blended.data[k + blended.channels*(j + i*blended.width)] = img1.data[k + blended.channels*(j + i*blended.width)] * (256 - overlay_ratio) >> 8;
                        blended.data[k + blended.channels*(j + i*blended.width)] += img2.data[k + blended.channels*(j + i*blended.width)] * overlay_ratio >> 8;
                    }
                    else {
                        blended.data[k + blended.channels*(j + i*blended.width)] = img1.data[k + blended.channels*(j + i*blended.width)];
                    }
                }
                else {
                    if(k != 3) {
                        blended.data[k + blended.channels*(j + i*blended.width)] = (img1.data[k + blended.channels*(j + i*blended.width)] 
                            * img1.data[3 + blended.channels*(j + i*blended.width)] * (256 - alpha)) >> 16;
                        blended.data[k + blended.channels*(j + i*blended.width)] += (img2.data[k + blended.channels*(j + i*blended.width)] 
                            * img2.data[3 + blended.channels*(j + i*blended.width)] * alpha) >> 16;
                    }
                    else {
                        blended.data[k + blended.channels*(j + i*blended.width)] = (img1.data[3 + blended.channels*(j + i*blended.width)] * (256 - alpha)) >> 8;
                        blended.data[k + blended.channels*(j + i*blended.width)] += (img2.data[3 + blended.channels*(j + i*blended.width)] * alpha) >> 8;
                    }
                }
            }
        }
    }

    return blended;
}
