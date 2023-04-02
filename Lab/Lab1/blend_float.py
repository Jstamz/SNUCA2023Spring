"""
4190.308 Computer Architecture                                                          Spring 2023

Image blending (float)

This module implements a function that blends two images together (floating point version)

@author:
    Your Name <your@email.com>

@changes:
    2023/MM/DD Your Name Comment

"""



def blend(img1, img2, height, width, channels, overlay, alpha):
    """
    Alpha-blends two images of size heightxwidth. The image data must contain an alpha
    channel, i.e., 'channels' must be four

    Args:
        img1:         image 1 data (multi-level list)
        img2:         image 2 data (multi-level list)
        height:       image height
        width:        image width
        channels:     number of channels (must be BGRA)
        overlay:      if 1, overlay the second image over the first
                      if 0, merge the two images
        alpha:        alpha blending factor (0.0-1.0)

    Returns:
        A tuple containing the following elements:
        - blended:    blended image data (multi-level list)
        - bheight:    blended image height (=height)
        - bwidth:     blended image width (=width)
        - bchannels:  blended image channels (=channels)

    """

    if channels != 4:
        raise ValueError('Invalid number of channels')


    # TODO
    # Your work goes here

    # For now, we simply copy the input parameters into the output parameters.
    # Fix/adjust once you have implemented your solution.
    bheight   = height
    bwidth    = width
    bchannels = channels
    blended   = [[[0 for c in range(bchannels)] for w in range(bwidth)] for h in range(bheight)]

    for h in range(height):
        for w in range(width):
            for c in range(channels):
                if overlay == 1:
                    if c != 3:
                        if img1[h][w][3] != 0:
                            atmp = img1[h][w][3] + (img2[h][w][3] - img1[h][w][3]) * alpha

                            multi1 = img1[h][w][c] * img1[h][w][3] * (1 - alpha)
                            multi2 = img2[h][w][c] * img2[h][w][3] * alpha
                            multi2 = (multi1 - multi2) * alpha  / (255 * 256)

                            blended[h][w][c] = (multi1 + multi2) / atmp
                        else:
                            blended[h][w][c] = 0
                    else:
                        blended[h][w][c] = int(img1[h][w][c])
                else:
                    if c != 3:
                        multi1 = img1[h][w][c] * img1[h][w][3] * (1 - alpha)
                        multi2 = img2[h][w][c] * img2[h][w][3] * alpha
                        blended[h][w][c] = (multi1 + multi2) / (255 * 256)
                    else:
                        blended[h][w][c] = ((img1[h][w][c] * (256 - alpha) + img2[h][w][c] * alpha) * 255.0) / (255 * 256)

                blended[h][w][c] = int(blended[h][w][c])

                if blended[h][w][c] > 255 | blended[h][w][c] < 0:
                    print(h, w, c, blended[h][w][c])
    return blended, bheight, bwidth, bchannels



