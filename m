From: Stanislav Meduna <stano@meduna.org>
Subject: Realtime capable userspace?
Date: Sun, 14 Apr 2013 11:01:55 +0200
Message-ID: <516A7083.8080705@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:39019 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab3DNJCG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Apr 2013 05:02:06 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1URIox-0004Sd-Na
	for linux-rt-users@vger.kernel.org; Sun, 14 Apr 2013 11:02:02 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I know this is not a kernel-related question, but I think the amount of
people doing realtime here is probably the largest.

As learned the hard-way the glibc is not (yet) realtime capable and
first changes are now starting to trickle in. Even if I try to fix known
places, who knows what, where and for how long is locked.

What userspace (libc / threads / malloc) are you using for realtime
applications? From my quick research:

- glibc:
  - priority-inheritance mutex implemented, but never used inside
    the glibc
  - not easy to replace malloc used internally (so that e.g.
    strdup() uses another one), at least when using shared
    libraries

- ucLibc:
  - threads from glibc, malloc uses non-PI-aware locks

- newlib:
  - no PI support, no futexes, mutexes done via kill(treadid, signal)

- tcmalloc (gperftools)
  - no PI locks used, although it is probably easily added. Not sure
    about the state of the software generally - it probably got much
    less real-world testing than the implementation in glibc


I ended with own low-level implementation of synchronization primitives
I needed via futexes (fortunately no full condvars or semaphores
needed) and serializing all malloc/free/... cals via a PI-aware mutex
(I don't care for performance when contented here, but I do care for
priority inversion).

What do you use for non-trivial applications?

Thanks
-- 
                                   Stano
