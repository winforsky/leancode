//
//  SDHeap.c
//  structdemo
//
//  Created by zsp on 2019/7/5.
//  Copyright © 2019 woop. All rights reserved.
//

#include "SDBSTree.h"
//xcode 中使用标准C的函数时使用
#include <stdlib.h>

/**
 初始化

 @param pRoot <#pRoot description#>
 */
void initBSTree(BSTNode** pRoot) {
    *pRoot=NULL;
}


/**
 构建数据节点

 @param data <#data description#>
 @return <#return value description#>
 */
BSTNode* buildBSTNode(BSDataType data) {
    BSTNode* node = malloc(sizeof(BSTNode));
    if (NULL == node) {
        printf("创建节点失败");
        return NULL;
    }
    node->_data=data;
    node->_pLeft=NULL;
    node->_pRight=NULL;
    return node;
}


/**
 插入数据

 @param pRoot <#pRoot description#>
 @param data <#data description#>
 @return <#return value description#>
 */
Bool insertBSTree(BSTNode** pRoot, BSDataType data) {
    if (*pRoot == NULL) {
        (*pRoot) = buildBSTNode(data);
        return true;
    }else{
        BSTNode* pCur = *pRoot;
        BSTNode* pParent = NULL;
        
        while (pCur) {
            pParent = pCur;
            if (pCur->_data == data) {
                return false;
            }else if (pCur->_data > data) {
                pCur = pCur->_pLeft;
            }else{
                pCur = pCur->_pRight;
            }
        }
        
        if (data > pParent->_data) {
            pParent->_pRight = buildBSTNode(data);
            return true;
        }
        if (data < pParent->_data) {
            pParent->_pLeft = buildBSTNode(data);
            return true;
        }
    }
    return false;
}


/**
 中序遍历

 @param pRoot <#pRoot description#>
 */
void inOrder(BSTNode* pRoot) {
    if (NULL == pRoot) {
        return;
    }
    
    inOrder(pRoot->_pLeft);
    printf("%d", pRoot->_data);
    inOrder(pRoot->_pRight);
}


/**
 删除数据

 @param pRoot <#pRoot description#>
 @param data <#data description#>
 @return <#return value description#>
 */
Bool deleteBSTree(BSTNode** pRoot, BSDataType data) {
    BSTNode* pCur = NULL;
    BSTNode* pParent = NULL;
    if (NULL == *pRoot) {
        return false;
    }else {
        pCur = *pRoot;
        while (pCur) {
            if (data > pCur->_data) {
                pParent = pCur;
                pCur = pCur->_pRight;
            }else if (data < pCur->_data) {
                pParent = pCur;
                pCur = pCur->_pLeft;
            }else{
                break;
            }
        }
        
        if (NULL == pCur->_pLeft) {
            if (pCur == *pRoot) {
                *pRoot = pCur->_pRight;
            }else if (pCur == pParent->_pLeft){
                pParent->_pLeft = pCur->_pRight;
            }else{
                pParent->_pRight = pCur->_pRight;
            }
        }else if (NULL == pCur->_pRight) {
            if (pCur == *pRoot) {
                *pRoot = pCur->_pLeft;
            }else if (pCur == pParent->_pLeft){
                pParent->_pLeft = pCur->_pLeft;
            }else{
                pParent->_pRight = pCur->_pLeft;
            }
        }else{
            BSTNode* inOrder = pCur->_pRight;
            while (inOrder->_pLeft) {
                pParent = inOrder;
                inOrder=inOrder->_pLeft;
            }
            pCur->_data = inOrder->_data;
            if (inOrder == pParent->_pLeft) {
                pParent->_pLeft = inOrder->_pRight;
            }else if (inOrder == pParent->_pRight) {
                pParent->_pRight=inOrder->_pRight;
            }
            pCur=inOrder;
        }
    }
    free(pCur);
    pCur = NULL;
    return true;
}


/**
 查找数据

 @param pRoot <#pRoot description#>
 @param data <#data description#>
 @return <#return value description#>
 */
BSTNode* findBSTree(BSTNode* pRoot, BSDataType data) {
    BSTNode* pCur = NULL;
    if (NULL == pRoot) {
        return NULL;
    }
    
    pCur = pRoot;
    while (pCur) {
        if (pCur->_data == data) {
            return pCur;
        }else if(pCur->_data > data) {
            pCur=pCur->_pLeft;
        }else {
            pCur=pCur->_pRight;
        }
    }
    return NULL;
}


/**
 销毁

 @param pRoot <#pRoot description#>
 */
void destroyBSTree(BSTNode** pRoot) {
    if (*pRoot) {
        destroyBSTree(&(*pRoot)->_pLeft);
        destroyBSTree(&(*pRoot)->_pRight);
        free(pRoot);
        *pRoot=NULL;
    }
}


/**
 自测
 */
void selfTest() {
    BSTNode* pRoot;
    initBSTree(&pRoot);
    int i;
    for(i=0; i<5; i++){
        insertBSTree(&pRoot, i);
    }
    
    inOrder(pRoot);
    
    BSTNode* ret = findBSTree(pRoot, 4);
    printf("\n");
    if (ret) {
        printf("该元素在树中\n");
    }else{
        printf("该元素不在树中\n");
    }
    printf("\n");
    deleteBSTree(&pRoot, 3);
    inOrder(pRoot);
    printf("\n");
}

void pointTest(void) {
    int a=80;
    printf("a = %d\n", a);
    
    int *b;
    b=&a;
    *b=100;
    printf("a = %d\n", a);
    
    int **c;
    c=&b;
    **c = 121;
    printf("a = %d\n", a);
}
