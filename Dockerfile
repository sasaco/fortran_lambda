FROM amazonlinux:latest

# install fortran compiler
RUN yum -y install gcc-gfortran glibc-static

# install json-fortran
# RUN yum -y install git cmake make patch
# RUN mkdir /build
# RUN cd /build && git clone https://github.com/jacobwilliams/json-fortran.git
# RUN cd /build && \
#     cmake json-fortran || true && \
#     make && \
#     make install

# install LAPACK
# RUN yum -y install lapack-static blas-static

# build program
# COPY json_matrix.f90 linear_eq.f90 /
COPY hello.f90 /


# -c: コンパイルのみ。 実行可能ファイルを生成しません。

# RUN gfortran -I/usr/local/jsonfortran-gnu-6.10.0/lib -c json_matrix.f90
# RUN gfortran -I/usr/local/jsonfortran-gnu-6.10.0/lib -c linear_eq.f90
RUN gfortran -c hello.f90

# Fortranのような言語では、普通にコンパイル・リンクしたのでは共有ライブラリは別になってしまうため、
# 何らかの方法で関数パッケージにライブラリを含める必要があります。
# もっとも簡単な方法は、全てスタティックリンクしてしまう方法です。今回はこの方法でやりました。
# -static: ファイルサイズが大きくなりますが、実行時に必要となるライブラリ(DLL)を組み込む
# -o: 書き込むオブジェクト、ライブラリ、実行可能ファイルの名前を指定します。

# RUN gfortran -static -o linear_eq linear_eq.o json_matrix.o /usr/local/jsonfortran-gnu-6.10.0/lib/libjsonfortran.a -llapack -lblas
RUN gfortran -static -o hello hello.o

CMD /bin/bash
