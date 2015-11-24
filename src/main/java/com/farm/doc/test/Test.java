package com.farm.doc.test;

public class Test {
	public static void main(String[] args) {
		int a[] = { 12, 23, 435, 6, 2, 4, 543, 226, 595 };
		int i, j, n, temp;
		// 数组的长度
		n = a.length;
		for (j = 0; j < n; j++) {
			for (i = 0; i < n - j; i++) {
				// 把最大的交换到最后面去
				if (a[i] > a[i + 1]) {
					temp = a[i];
					a[i] = a[i + 1];
					a[i + 1] = temp;
				}
			}
		}
	}
}
