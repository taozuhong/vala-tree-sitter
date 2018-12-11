rm -rf build
meson build
ninja -v -C build

./build/src/tree-walker
