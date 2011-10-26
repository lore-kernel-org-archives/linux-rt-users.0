From: HUNG BUI <buihung@gmail.com>
Subject: Linux RT patch for Pandaboard Omap 4 kernel 3.0.0-1205 error when compiling
Date: Thu, 27 Oct 2011 01:25:30 +0200
Message-ID: <CAF7pde80C8C=vfN34uR4rS2HZ2-pY0BBJ0EsWm612BgHgtfETw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58142 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab1JZXZc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Oct 2011 19:25:32 -0400
Received: by qyk27 with SMTP id 27so2439354qyk.19
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Oct 2011 16:25:31 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everybody,

I am trying to patch and compile realtime patch for kernel 3.0.0-1205
(TI-OMAP4) on Pandaboard. However I faced lots of error, and couldn't
finish the compiling process yet.

I followed the instruction of compiling Pandaboard kernel from here

http://adventuresinsilicon.blogspot.com/2011/02/pandaboard-ubuntu-how-t=
o-recompile.html
http://www.omappedia.com/wiki/Ubuntu_kernel_for_OMAP4

My kernel was downloaded with the command :

sudo apt-get build-dep linux-image-$(uname -r)

which is arm-linux-3.0.0-1205-omap4 or linux-ti-omap4
tar file : linux-ti-omap4_3.0.0-1205.10.tar.gz
The patch I used is :=A0patch-3.0-rt6.patch.bz2

Pandaboard running on Ubuntu=A0Oneiric Desktop. GCC 4.6

I tried the following commands :

patch -p1 < ../patch-3.0-rt6.patch
fakeroot debian/rules editconfigs
(#=A0Kernel Features -> Preemption Model -> Fully Preemptible Kernel (R=
T) )
fakeroot debian/rules clean
dpkg-buildpackage -B -uc -us

=46irst the patch showed that there are some :

Reversed (or previously applied) patch detected! Assume - R =A0Apply
anyway n] with 2 files :
drivers/rtc/interface.c
drivers/rtc/rtc-tegra.c

(Don't have this problem if i apply rt8 or latter However they are for
kernel 3.0.1 which I don;t know how to get)

I answer No for both assume =A0-r and Apply anyway , I am not sure it's
correct or not

Also the patch showed that there are some hunk failed with 3 files :

arch/arm/mm/cache-l2x0.c
init/main.c
kernel/stop_machine.c
I tried to fix this manually with the .rej files (otherwise it will
cause this error when compile:

kernel/stop_machine.c:176:2: note: each undeclared identifier is
reported only once for each function it appears in
kernel/stop_machine.c: In function =91cpu_stopper_thread=92:
kernel/stop_machine.c:290:3: error: =91stopper_lock=92 undeclared (firs=
t
use in this function)


Then when I compile the kernel, i got some more errors which i can
search and find the way to fix them however when it come to the
following error, I couldn't find the solution for it=A0:

drivers/dsp/syslink/multicore_ipc/transportshm.c:261:2: error: request
for member =91lock=92 in something not a structure or union
drivers/dsp/syslink/multicore_ipc/transportshm.c:261:2: warning:
dereferencing =91void *=92 pointer [enabled by default]
drivers/dsp/syslink/multicore_ipc/transportshm.c:261:2: error: request
for member =91lock=92 in something not a structure or union
make[2]: *** [drivers/dsp/syslink/multicore_ipc/transportshm.o] Error 1

I am not sure if the patch (3.0 rt6), kernel(linux-ti-omap4 3.0.0) ,
gcc (4.6), and the commands i am using is correct, or there is some
mismatches between them that make more and more errors happened when
compiling.

Thanks in advance,

Hung Bui
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
