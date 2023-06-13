# Virtual Memory

## Introduction

## Basic Concepts
- Virtual address (VA) = abstract of physical address (PA)

#### Terms
- Block &harr; Page
- Cache miss &harr; Page fault

#### Implementation of Virtual Memory
- Translation : indirect mapping from VA to PA
  - Physical Address = Page Table[Virtual Address/Page Size] + Virtual Address % Page Size
  - Very Simple!

#### MMU(Memory Management Unit)
- Main process is translation : VA &rarr; PA
  - *Hardware unit* that performing translation
- Based on *Page Table*
  - Page Table is stored in *main memory*
    - PTBR(Page Table Base Register) : register that stores the address of the page table
  - Page Table is *cache* in MMU : TLB(Translation Lookaside Buffer)

## Feature of Virtual Memory

#### Address Space Isolation
- Each process has its own virtual address space
  - Process A cannot access process B's address space

#### Shared Memory
- If two processes share the same code or data, use the same physical address
  - *Shared library*

#### Decoupling of Virtual from Physical Memory Space

#### Physical Memory as Cache

#### Memory Protection(Permission)

## On-Demand Paging