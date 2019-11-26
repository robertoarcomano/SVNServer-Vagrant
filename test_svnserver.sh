#!/usr/bin/env bats

@test "Random auto generated number check" {
  # 1. Create file random
  N=$((RANDOM%100))

  # 2. Put random data to file
  echo $N > /tmp/random

  # 3. Import the random file to svn
  svn import /tmp/random file:///var/lib/svn/myrepo/random -m "Add random file"

  # 4. Download random file via WebDav SVN
  M=$(wget http://localhost/svn/myrepo/random --http-user=admin --http-password=password -O - 2>/dev/null)
  [ "$M" = "$N" ]
}
