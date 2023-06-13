#/-------------------------------------------------------------------------------------------------
#/ 4190.308 Computer Architecture                                                       Spring 2023
#/
#// @file
#// @brief Image blending (vector operations)
#//        This module implements a function that blends two images together filter (assembly 
#//        integer vector version)
#//
#//
#// @section changelog Change Log
#// 2023/MM/DD Your Name Comment
#//
#/-------------------------------------------------------------------------------------------------

    .option nopic
    .attribute unaligned_access, 0
    .attribute stack_align, 16

    .text
    .align 4
    .globl blend_asm
    .type  blend_asm, @function

# struct Image {                 Ofs
#     uint8 *data;                 0
#     int height;                  4
#     int width;                   8
#     int channels;               12
# };

# int blend_asm(                 Reg
#       struct Image *blended,    a0
#       struct Image *img1,       a1
#       struct Image *img2,       a2
#       int overlay,              a3
#       int alpha                 a4
#     )
blend_asm:



    ############# Check parameters  ################################
    

    li    t0, 1
    bne   a3, t0, .OverlayError   # if overlay != 1 goto .OverlayError

    lw    t1, 12(a1)              # t1 = img1->channels
    lw    t2, 12(a2)              # t2 = img2->channels
    li    t0, 4
    bne   t1, t0, .ChannelError   # if img1->channels != 4 goto .ChannelError
    bne   t2, t0, .ChannelError   # if img2->channels != 4 goto .ChannelError

    
    lw    t1, 4(a1) # Height
    lw    t2, 4(a2)
    bne   t1, t2, .DifferentDimensionsError
    beq   t1, x0, .ZeroLengthError
    lw    t2, 8(a1) # Width
    lw    t3, 8(a2)
    bne   t3, t2, .DifferentDimensionsError
    beq   t2, x0, .ZeroLengthError

    ############ Initialize blended image  ###########################
    lw  s4, 0(a1) # Address
    lw  s8, 0(a2)
    li  t6, 16
    sw  t1, 4(a0) # Save height
    sw  t2, 8(a0) # Save width

    lw  t3, 0(a0) # address of blended
    #lw  t6, -16(s4)
    #sw  t6, -16(t3)

    #lw  t6, -12(s4)
    #sw  t6, -12(t3)

    #w  t1, -8(t3)
    #sw  t2, -4(t3)

    
    li  a5, 4 # load 4 -> why?
    sw  a5, 12(a0) # save chanel

    
    mv  a7, a4         #move alpha
    

    ############# Blend  #################################################
    li    t5, 0    #current pixel index to t5 -> why use index?
    mul   t1, t1, t2 # height * width
    # blended img's address(a0) to a0 + width * height * 4 but it's not important  
    
    li    t4, 255 # what is it? -> fix to 256 may be...
    #ret
    
    j     .Calculate

    + 4 -> get rgba all and unpack 

.Loop: why 16?
    addi s4, s4, 16 # s4 address
    addi s8, s8, 16 # s8 address
    addi t3, t3, 16 # address
.Calculate:  
    lw      a4, 0(s4)
    slli    a4, a4, 16
    lw      a6, 4(s4)
    slli    a6, a6, 8
    or      a4, a4, a6
    lw      a6, 8(s4)
    or      a4, a4, a6
    svunpack s1, a4

    lw      a4, 0(s8)
    slli    a4, a4, 16
    lw      a6, 4(s8)
    slli    a6, a6, 8
    or      a4, a4, a6
    lw      a6, 8(s8)
    or      a4, a4, a6
    svunpack s2, a4
    

    lw      a1, 12(s4)      # 0X800002b0 dmem access error
    sw      a1, 12(t3)      # 0X8000ffff dmem access error
    
    
    lw       s9, 12(s8)    
    mul      s9, s9, a7      # alpha_combined
    srli     s9, s9, 8

    sub      s9, t4, s9      # 255 - alpha_combined
    svbrdcst s9, s9          # s9: alphaV
    svmul    s1, s1, s9      # vmul alphaV, vrgb1
    svmul    s2, s2, s9      # vmul alphaV, vrgb2

    svadd   s11, s1, s2
    svpack  s11, s11, x0

    ############## put colors into blended.data pixel
    andi    s10, s11, 255
    sw      s10, 8(t3)
    srli    s11, s11, 8
    
    andi    s10, s11, 255
    sw      s10, 4(t3)
    srli    s11, s11, 8

    andi    s10, s11, 255
    sw      s10, 0(t3)    

    addi t5, t5, 1 
    #beq  t5, t6, .Return
    bne  t5, t1, .Loop

.Return:
    ret

.OverlayError:
    li    a0, -1
    ret

.ChannelError:
    li    a0, -2
    ret

.DifferentDimensionsError:
    li    a0, -3
    ret

.ZeroLengthError:
    li    a0, -4
    ret
