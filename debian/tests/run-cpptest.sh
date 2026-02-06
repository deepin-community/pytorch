#!/bin/bash
echo "# Before running these tests, please make sure the testing binaries are installed via the package libtorch-test or libtorch-cuda-test"
echo "# Running C++ Testing Programs"
FILES=( $(find /usr/lib/libtorch-test/ -type f -executable 2>/dev/null && echo "[CPU version] Tests found." >/dev/stderr || echo "[CPU version] Tests not found." >/dev/stderr) )
FILES+=( $(find /usr/lib/libtorch-cuda-test/ -type f -executable 2>/dev/null && echo "[CUDA version] Tests found." >/dev/stderr || echo "[CUDA version] Tests not found." >/dev/stderr) )
echo "#"
echo "# Found" ${#FILES[@]} "tests"
echo "#"
sleep 1

failed=( )

for (( i = 0; i < ${#FILES[@]}; i++ )); do
	echo "# C++ test ${i}/${#FILES[@]} ${FILES[$i]}"
	${FILES[$i]}
	if test 0 != $?; then
		failed+=( ${FILES[$i]} )
	fi
	echo ""
done

echo
echo "# Printing failed tests ..."
for i in ${failed[@]}; do
	echo ${i}
done
