From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Cyclictest compile error when cross compiling for AT91SAM9260
Date: Thu, 27 Sep 2012 12:02:18 -0700
Message-ID: <5064A2BA.6040500@am.sony.com>
References: <205356936.3972629.1348734210351.JavaMail.root@zmail.sgconsulting.it>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Forconi <forconi@wavecomm.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [65.55.88.10] ([65.55.88.10]:50350 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751870Ab2I0TC4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Sep 2012 15:02:56 -0400
In-Reply-To: <205356936.3972629.1348734210351.JavaMail.root@zmail.sgconsulting.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/27/12 01:23, Forconi wrote:
> Hi, 
> I made a cleanup and a fresh clone of the git repository.
> 
> This is what I get running make:
> 
> $ make CC=arm-unknown-linux-gnu-gcc
> src/pi_tests/pip_stress.c:240:2: error: #error _POSIX_THREAD_PROCESS_SHARED is not defined
> src/pi_tests/pi_stress.c:78:2: error: #error "Can't run this test without PI Mutex support"
> arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/cyclictest/cyclictest.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
> src/cyclictest/cyclictest.c: In function 'timerthread':
> src/cyclictest/cyclictest.c:700: warning: implicit declaration of function 'pthread_setaffinity_np'
> arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/lib/rt-utils.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
> arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/lib/error.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
> arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/lib/rt-get_cpu.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
> ar rcs librttest.a rt-utils.o error.o rt-get_cpu.o
> arm-unknown-linux-gnu-gcc -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2  -o cyclictest cyclictest.o librttest.a -lrt -lpthread -lrttest -L. 
> cyclictest.o: In function `timerthread':
> cyclictest.c:(.text+0x17ac): undefined reference to `pthread_setaffinity_np'
> collect2: ld returned 1 exit status
> make: *** [cyclictest] Error 1
> 
> It seems that the pthread_setaffinity_np is missing in pthread library (maybe I have an old lib?)


These errors look possibly more reasonable than the original errors.  And possibly
just lack of support for the features as you suggest with "maybe I have an old lib".
Another possibility is that your cross tools are not pulling in the right header
files and libraries.


(1) pip_stress.c:240:2: error: #error _POSIX_THREAD_PROCESS_SHARED is not defined

Your environment is missing the feature.  If it existed, _POSIX_THREAD_PROCESS_SHARED
would be defined in the <bits/posix_opt.h> that your cross tools are pulling in.
The include chain is:

   src/pi_tests/pip_stress.c
      src/include/pip_stress.h
         <unistd.h>
            <bits/posix_opt.h>

If you think the header files from your cross tools should define _POSIX_THREAD_PROCESS_SHARED
then you can verify which header file is used for <bits/posix_opt.h> by:

   arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/pi_tests/pip_stress.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2 -C -E >junk_pip_stress
   grep posix_opt.h junk_pip_stress


(2) cyclictest.c:700: warning: implicit declaration of function 'pthread_setaffinity_np'

Your environment is missing the feature.  If it existed, pthread_setaffinity_np() would
be defined in <pthread.h>.  This warning is consistent with your pthread library not
having pthread_setaffinity_np(), which is reported by the link error
"undefined reference to `pthread_setaffinity_np'".

You can verify which header file is used for <pthread.h> by:

   arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/cyclictest/cyclictest.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2 -C -E >junk_cyclictest
   grep pthread.h junk_cyclictest

If you think your pthread library should include this feature, then verify which
pthread library the linker is pulling in.

-Frank


