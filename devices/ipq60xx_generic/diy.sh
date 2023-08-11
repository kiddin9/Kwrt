#!/bin/bash
shopt -s extglob

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ipq60xx target/linux/ipq60xx

svn co https://github.com/coolsnowwolf/lede/trunk/package/qca package/qca

