From: "$rik@nth " <srikanth007m@gmail.com>
Subject: failed to compile rt-sched
Date: Mon, 28 Nov 2016 15:13:02 +0530
Message-ID: <CANKSX+FhtJFu=wifY-ppnSGkhWrwxJGS5sZw04ujPHH5-r+P=g@mail.gmail.com>
Reply-To: srikanth007m@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35523 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932294AbcK1JnE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Nov 2016 04:43:04 -0500
Received: by mail-qk0-f194.google.com with SMTP id n204so12466433qke.2
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Nov 2016 01:43:03 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I am trying to cross compile rt-tests on Ubuntu with 64bit cross gcc
tool chain and ended up with below error (Able to compile successfully
with 32bit tool chain). Can someone help clarifying the below error?
Is this the issue with syscalls or with linux kernel version. How to
get it compile successfully for 64bit ARCH.

aarch64-linux-gnu-gcc-4.8 -D VERSION=3D1.0 -c src/lib/rt-sched.c -Wall
-Wno-nonnull -O2 -D_GNU_SOURCE -Isrc/include -o bld/rt-sched.o
src/lib/rt-sched.c: In function =C3=A2sched_setattr=C3=A2:
src/lib/rt-sched.c:34:17: error: =C3=A2__NR_sched_setattr=C3=A2 undeclared
(first use in this function)
  return syscall(__NR_sched_setattr, pid, attr, flags);
                 ^
src/lib/rt-sched.c:34:17: note: each undeclared identifier is reported
only once for each function it appears in
src/lib/rt-sched.c: In function =C3=A2sched_getattr=C3=A2:
src/lib/rt-sched.c:42:24: error: =C3=A2__NR_sched_getattr=C3=A2 undeclared
(first use in this function)
         return syscall(__NR_sched_getattr, pid, attr, size, flags);
                        ^
src/lib/rt-sched.c: In function =C3=A2sched_setattr=C3=A2:
src/lib/rt-sched.c:35:1: warning: control reaches end of non-void
function [-Wreturn-type]
 }
 ^
src/lib/rt-sched.c: In function =C3=A2sched_getattr=C3=A2:
src/lib/rt-sched.c:43:1: warning: control reaches end of non-void
function [-Wreturn-type]
 }
 ^
make: *** [bld/rt-sched.o] Error 1


--=20
Thanks & Regards,
M.Srikanth Kumar.
