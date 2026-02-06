#!/bin/bash
set +e
set +x
echo "# Running Python Testing Programs"
if ! test -d debian; then
    echo Please run this script right outside of the debian/ directory.
fi
FILES_CORE=(
test_autograd
test_autograd_fallback,
test_modules
test_nn
test_ops
test_ops_gradients
test_ops_fwd_gradients,
test_ops_jit
test_torch
)
FILES_FINDALL=( $(cd test && find . -type f -name 'test_*.py' | sed -e 's@^./@@g' | sed -e 's@.py$@@g' | sort | uniq) )
FILES=()


# allow us to select the pytest subsets
while [[ $# -gt 0 ]]; do
  case $1 in
    --core)
      FILES=( ${FILES[@]} ${FILES_CORE[@]} )      
      shift
      ;;
    --all)
      FILES=( ${FILES[@]} ${FILES_FINDALL[@]} )
      shift
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done
FILES=( $(echo ${FILES[@]} | sort | uniq) )


echo "# Found" ${#FILES[@]} "tests"
echo "#"
sleep 1

failed=( )
cd test/
for (( i = 0; i < ${#FILES[@]}; i++ )); do
	echo
	echo
	echo "# Py test ${i}/${#FILES[@]} ${FILES[$i]}"
	echo "$(pwd)# /usr/bin/python3 -m pytest ${FILES[$i]}.py -v"
	/usr/bin/python3 -m pytest ${FILES[$i]}.py -v
	if test 0 != $?; then
		failed+=( ${Files[$i]} )
	fi
done

echo
echo "# listing failed tests ..."
for i in ${failed[@]}; do
	echo ${i}
done
