From: Stanislav Meduna <stano@meduna.org>
Subject: SLAB leaks filep in 3.4.13-rt21 with PREEMPT_RT_FULL
Date: Sat, 20 Oct 2012 17:48:09 +0200
Message-ID: <5082C7B9.9010502@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:42322 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab2JTQOC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Oct 2012 12:14:02 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1TPbHZ-0006no-Iq
	for linux-rt-users@vger.kernel.org; Sat, 20 Oct 2012 17:48:20 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

compiling a current (a few days back) linux-stable-rt.git
with PREEMPT_RT_FULL results in a significant memory leak.
Just repeating

  cat /proc/meminfo  | grep Unreclaim

shows the unreclaimable memory jumping in 4 - 12 kB steps.
  sync ; echo 3 > /proc/sys/vm/drop_caches
does not help either, this is for sure a real leak.

Looking at the slabtop output the "filp" is responsible for
most of the allocations, but there are more, even the "pid"
is rising although the number of threads in the system stays
the same.

PREEMPT_LL and selecting the SLUB (which is the preferred
allocator but not available with PREEMPT_RT_FULL) solves the
problem. I did not test with LL and SLAB (yet - I think that
it is hardly improbable that the SLAB allocator is the reason).

I can't test with PREEMPT_RTB as this option looks even more
broken on my setup and oopses at root filesystem (ext3)
mounting so I do not have the logs and the beginning rolls
out of the console so I can't even photograph it :(

The machine is an industrial embedded PC running a Geode LX.
I did not change the kernel in any way except adding an own
module that was not loaded during the tests.

I am new to linux-rt and this list - is it OK to attach
full .config files?

Thanks
-- 
                               Stano
