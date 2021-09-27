program hello
  implicit none

  ! コマンドライン引数を取得
  character(2048):: json_str
  call getarg(1, json_str)

  write(*,*) json_str
  stop
end program hello