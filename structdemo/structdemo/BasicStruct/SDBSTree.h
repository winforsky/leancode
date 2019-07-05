//
//  SDHeap.h
//  structdemo
//
//  Created by zsp on 2019/7/5.
//  Copyright © 2019 woop. All rights reserved.
//

#ifndef SDBSTree
#define SDBSTree

#include <stdio.h>

//C语言中没有Bool类型的替代方法
#define Bool int
#define true 1
#define false 0

//指定别名，便于理解 及 缩短代码量
typedef int BSDataType;
//定义结构体类型，同时指定别名
typedef struct BSTreeNode {
    struct BSTreeNode* _pLeft;
    struct BSTreeNode* _pRight;
    BSDataType _data;
}BSTNode;

//指针 也是变量的一种，由编译器负责分配内存空间，它存储的是变量的内存地址，而且只能存储内存地址
//*p
//& 取内存地址
//*p一级指针 p指向的是内存地址， *p是该内存地址上存储的值
//**p二级指针 **p是该指向的内存地址存储的内存地址上存储的值， *p是该指向的内存地址存储的内存地址值 p是该指向的内存地址值
//二级指针 得到的是指向地址的地址的值，常用于要修改一级指针的地址指向时
//数组作为函数的参数时，数组名自动退化成指针
//一维数组 *p
//二维数组 **p



void initBSTree(BSTNode** pRoot);
BSDataType insertBSTree(BSTNode** pRoot, BSDataType data);
Bool deleteBSTree(BSTNode** pRoot, BSDataType data);
BSTNode* findBSTree(BSTNode* pRoot, BSDataType data);
void destroyBSTree(BSTNode** pRoot);
void selfTest(void);
void pointTest(void);


#endif /* SDBSTree */
