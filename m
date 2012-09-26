From: Forconi <forconi@wavecomm.it>
Subject: Cyclictest compile error when cross compiling for AT91SAM9260
Date: Wed, 26 Sep 2012 09:26:56 +0000 (UTC)
Message-ID: <1481347384.3944129.1348651616613.JavaMail.root@zmail.sgconsulting.it>
References: <1482871759.3943500.1348650924961.JavaMail.root@zmail.sgconsulting.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zmail.sgconsulting.it ([174.143.207.116]:33647 "EHLO
	zmail.sgconsulting.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534Ab2IZJ3m (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2012 05:29:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by zmail.sgconsulting.it (Postfix) with ESMTP id 4B8071889D
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2012 09:26:57 +0000 (UTC)
Received: from zmail.sgconsulting.it ([127.0.0.1])
	by localhost (zmail.sgconsulting.it [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L+RrFg8A2QWL for <linux-rt-users@vger.kernel.org>;
	Wed, 26 Sep 2012 09:26:56 +0000 (UTC)
Received: from zmail.sgconsulting.it (zmail.sgconsulting.it [174.143.207.116])
	by zmail.sgconsulting.it (Postfix) with ESMTP id AD26518851
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Sep 2012 09:26:56 +0000 (UTC)
In-Reply-To: <1482871759.3943500.1348650924961.JavaMail.root@zmail.sgconsulting.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, 
I have compiled and installed an RT_PREEMPT patched kernel (2.6.33.7-rt29) on a AT91SAM9260 board.
I'd like to test latencies using cyclictest software (obtained from git repository).
My cross compile environment is gcc-4.2.3 with glibc-2.3.3 (obtained from the producer of the board).

This is the error I get when I try to compile:

$ make CROSS_COMPILE=arm-unknown-linux-gnu- librttest.a 
arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/lib/rt-utils.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/lib/error.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/lib/rt-get_cpu.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
ar rcs librttest.a rt-utils.o error.o rt-get_cpu.o

$ make CROSS_COMPILE=arm-unknown-linux-gnu- cyclictest
arm-unknown-linux-gnu-gcc -D VERSION_STRING=0.84 -c src/cyclictest/cyclictest.c -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include -O2
In file included from /opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib/gcc/arm-unknown-linux-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-include/sys/sysinfo.h:25,
                 from src/cyclictest/cyclictest.c:34:
/opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib/gcc/arm-unknown-linux-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-include/linux/kernel.h:716:2: warning: #warning Attempt to use kernel headers from user space, see http:
In file included from /opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib/gcc/arm-unknown-linux-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-include/sys/resource.h:25,
                 from src/cyclictest/cyclictest.c:37:
/opt/glomation/gcc-4.2.3-glibc-2.3.3/bin/../lib/gcc/arm-unknown-linux-gnu/4.2.3/../../../../arm-unknown-linux-gnu/sys-include/bits/resource.h:35: error: expected identifier before numeric constant
src/cyclictest/cyclictest.c: In function 'timerthread':
src/cyclictest/cyclictest.c:703: warning: implicit declaration of function 'pthread_setaffinity_np'
make: *** [cyclictest.o] Error 1



Thank you for any suggestions and help.

Regards,
Samuele Forconi.
