package com.utils.wycode;

public class Fraction {
private Integer numerator; // 分子;
private Integer denominator; // 分母

/**
* 构造器
*/
public Fraction() {
}

public Fraction(Integer numerator, Integer denominator) {
this.numerator = numerator;
this.denominator = denominator;
}

public Integer getDenominator() {
return denominator;
}

public void setDenominator(Integer denominator) {
this.denominator = denominator;
}

public Integer getNumerator() {
return numerator;
}

public void setNumerator(Integer numerator) {
this.numerator = numerator;
}

/**
* 求最大公约数
* 
* @return
*/
private int getGCD(int a, int b) {
int max = Math.max(a, b);
int min = Math.min(a, b);
int mod = max % min;
if (mod == 0) {
return min;
} else {
return this.getGCD(mod, min);
}
}

/**
* 简化和约分
* 
* @return
*/
public Fraction simplify() {
// 格式化
if (this.numerator == 0) {
this.denominator = null;
return this;
} else if (this.denominator * this.numerator > 0
&& this.denominator < 0) {
this.denominator = Math.abs(this.denominator);
this.numerator = Math.abs(this.numerator);
return this;
} else if (this.denominator < 0) {
this.denominator = Math.abs(this.denominator);
this.numerator = -this.numerator;
return this;
}
// 约分
int gcd = this.getGCD(Math.abs(denominator), Math.abs(numerator));
if (gcd == 1) {
return this;
} else {
this.denominator = this.denominator / gcd;
this.numerator = this.numerator / gcd;
return this;
}
}

/**
* 加法
* 
* @param fraction
* @return
*/
public Fraction add(Fraction fraction) {
Integer resultDenominator = Math.abs(this.denominator)
* Math.abs(fraction.getDenominator());
Integer resultNumerator = this.numerator * fraction.getDenominator()
+ this.denominator * fraction.getNumerator();
Fraction result = new Fraction(resultNumerator, resultDenominator);
return result.simplify();
}

/**
* 减法
* 
* @param fraction
* @return
*/
public Fraction minus(Fraction fraction) {
Integer resultDenominator = Math.abs(this.denominator)
* Math.abs(fraction.getDenominator());
Integer resultNumerator = this.numerator * fraction.getDenominator()
- this.denominator * fraction.getNumerator();
Fraction result = new Fraction(resultNumerator, resultDenominator);
return result.simplify();
}

/**
* 乘法
* 
* @param fraction
* @return
*/
public Fraction multiply(Fraction fraction) {
Fraction result = null;
if (this.numerator == 0 || fraction.numerator == 0) {
result = new Fraction(0, null);
}
Integer resultDenominator = this.denominator
* fraction.getDenominator();
Integer resultNumerator = this.numerator * fraction.getNumerator();
result = new Fraction(resultNumerator, resultDenominator);
return result.simplify();
}

/**
*除法
* 
* @param fraction
* @return
*/
public Fraction divide(Fraction fraction) {
Fraction result = null;
if (this.numerator == 0) {
result = new Fraction(0, null);
}
Integer resultDenominator = this.denominator * fraction.getNumerator();
Integer resultNumerator = this.numerator * fraction.getDenominator();
result = new Fraction(resultNumerator, resultDenominator);
return result.simplify();
}

@Override
public String toString() {
return this.numerator + "/" + this.denominator;
}

/**
* 测试
* 
* @param args
*/
public static void main(String[] args) {
Fraction f1 = new Fraction(1, 2);
Fraction f2 = new Fraction(2, 4);
System.out.println(f1);
System.out.println(f2);
System.out.println(f2.simplify());
System.out.println(f1.add(f2));
System.out.println(f1.minus(f2));
System.out.println(f1.multiply(f2));
System.out.println(f1.divide(f2));
}
} 
