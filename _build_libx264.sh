function build_libx264 {
  echo "Building libx264 for android ..."

  test -d ${src_root}/libx264 || \
    git clone git clone git://git.videolan.org/x264.git ${src_root}/libx264 >> ${build_log} 2>&1 || \
    die "Couldn't clone libx264 repository!"

  cd ${src_root}/libx264

  prefix=${src_root}/libx264/libx264
  addi_cflags="-marm"
  addi_ldflags=""

  ./configure \
    --cross-prefix=${TOOLCHAIN}/bin/arm-linux-androideabi- \
    --sysroot=${SYSROOT} \
    --host="arm-linux" \
    --enable-pic \
    --disable-asm \
    --enable-static \
    --prefix=${prefix} \
    --disable-cli

  make install


  # copy the headers
  cp -r ${prefix}/include/* ${dist_include_root}/.    

  cd ${top_root}
}
