# Nerual Network Accelerator Architecture

#### What is NN accelerator?
- NN accelerator is a hardware that is optimized for NN computation.

- Depending on popular ML models
  - Current : CNN &rarr; GPT(Large Langauge Model)

- Two important factors
  - Memory Bandwidth
  - Massive Parallelism

#### GPU: Nvidia Tesla
- Unified Shader + CUDA + Warp

- TPT: Tensor Processing Unit
  - 2 SMs
  - 24 Warps in SM

#### GPU Workflows
1. Copy data from Main memory to GPU memory
2. Instruction processing
3. Execute parallel instructions in Different Core
