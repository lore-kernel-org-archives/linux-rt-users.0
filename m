From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Cyclictest compile error when cross compiling for AT91SAM9260
Date: Wed, 26 Sep 2012 12:34:17 -0700
Message-ID: <506358B9.7020007@am.sony.com>
References: <1481347384.3944129.1348651616613.JavaMail.root@zmail.sgconsulting.it>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Forconi <forconi@wavecomm.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:30384
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757681Ab2IZTeX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2012 15:34:23 -0400
In-Reply-To: <1481347384.3944129.1348651616613.JavaMail.root@zmail.sgconsulting.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/26/12 02:26, Forconi wrote:
> Hi, 
> I have compiled and installed an RT_PREEMPT patched kernel (2.6.33.7-rt29) on a AT91SAM9260 board.
> I'd like to test latencies using cyclictest software (obtained from git repository).

Is the git repository:

   git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

with current version:

   commit 857cdd5320ce1f293f5dbcbec79cc8fe22b0bebf
   Date:   Wed May 9 09:38:00 2012 -0500

> My cross compile environment is gcc-4.2.3 with glibc-2.3.3 (obtained from the producer of the board).
> 
> This is the error I get when I try to compile:
> 
> $ make CROSS_COMPILE=arm-unknown-linux-gnu- librttest.a 
> arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/lib/rt-utils.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2

That is somewhat surprising (unless you have modified the makefile).  If I
try that same command (but the proper CROSS_COMPILE value for my cross
tools), the cross gcc is not picked up.  But your example is clearly using
your cross gcc.  I instead use:

   make CC="${CROSS_COMPILE}gcc"

where CROSS_COMPILE is set for my cross tools:

  $ echo ${CROSS_COMPILE}
  arm-sony-linux-gnueabi-thumb2-

Everything builds ok, no need to make librttest.a and cyclictest individually.

I point out all of the above, because it does not seem like you have the
same source that I have, so I'm reluctant to dig any further.


> arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/lib/error.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
> arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/lib/rt-get_cpu.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
> ar rcs librttest.a rt-utils.o error.o rt-get_cpu.o
> 
> $ make CROSS_COMPILE=arm-unknown-linux-gnu- cyclictest
> arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/cyclictest/cyclictest.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
> In file included from /opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib/gcc/arm-unknown-linux-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-include/sys/sysinfo.h:25,
>                  from src/cyclictest/cyclictest.c:34:
> /opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib/gcc/arm-unknown-linux-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-include/linux/kernel.h:716:2: warning: #warning Attempt to use kernel headers from user space, see http:
> In file included from /opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib/gcc/arm-unknown-linux-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-include/sys/resource.h:25,
>                  from src/cyclictest/cyclictest.c:37:
> /opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib/gcc/arm-unknown-linux-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-include/bits/resource.h:35: error: expected identifier before numeric constant
> src/cyclictest/cyclictest.c: In function 'timerthread':
> src/cyclictest/cyclictest.c:703: warning: implicit declaration of function 'pthread_setaffinity_np'
> make: *** [cyclictest.o] Error 1
> 
> 
> 
> Thank you for any suggestions and help.
> 
> Regards,
> Samuele Forconi.


