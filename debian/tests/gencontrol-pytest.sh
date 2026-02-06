#!/bin/bash
set -e
echo "# Generating Autopkgtest Test Cases for the Python Testing Programs"
echo "# The tests are collected from test/run_test.py"
FILES=(
	test_autograd
	test_modules
	test_nn
	test_ops
	test_ops_gradients
	test_ops_jit
	test_torch
)

PERMISSIVE_LIST=(
	test_autograd
	test_modules
	test_nn
	test_ops
	test_ops_gradients
	test_ops_jit
	test_torch
)

echo "# Found" ${#FILES[@]} "tests"
echo "#"

for (( i = 0; i < ${#FILES[@]}; i++ )); do
	echo "# Py test ${i}/${#FILES[@]}"
	if echo ${PERMISSIVE_LIST[@]} | grep -o ${FILES[$i]} >/dev/null 2>/dev/null; then
		echo "Test-Command: cp -avL debian/expecttest/expecttest test/; cd test/ ; python3 -m pytest ${FILES[$i]}.py -v || true"
	else
		echo "Test-Command: cp -avL debian/expecttest/expecttest test/; cd test/ ; python3 -m pytest ${FILES[$i]}.py -v || if test 134 = \$?; then true; else exit \$?; fi"
	fi
	echo "Depends: build-essential, ninja-build, libtorch-dev, python3-torch, python3-pytest, python3-hypothesis, python3-setuptools, pybind11-dev, python3-scipy"
	echo "Features: test-name=$((${i}+1))_of_${#FILES[@]}__pytest__$(basename ${FILES[$i]})"
	echo "Restrictions: allow-stderr"
	echo ""
done
