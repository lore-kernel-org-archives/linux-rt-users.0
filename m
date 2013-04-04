From: Stanislav Meduna <stano@meduna.org>
Subject: Re: malloc/free and priority inheritance?
Date: Thu, 04 Apr 2013 14:59:47 +0200
Message-ID: <515D7943.5000401@meduna.org>
References: <515B647C.3080505@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: libc-help@sourceware.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:41587 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760382Ab3DDM77 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Apr 2013 08:59:59 -0400
In-Reply-To: <515B647C.3080505@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03.04.2013 01:06, Stanislav Meduna wrote:

> I am hunting a possible priority inversion case and I would like
> to ask whether the malloc/free from glibc (particularly 2.11.3
> used in Debian 6 or newer) uses priority inheritance mutexes
> when doing the necessary locking.

OK, after code-review it looks that it does not and neither
do the condition variables and semaphores. This is bad...

I think I can work around the malloc/free with some linker magic
and wrapper functions (we don't allocate much so the performance
hit is tolerable), but anyone here has a pointer to priority
inheritance aware condition variables implemented using futexes
outside of glibc?

I'd like to avoid patching glibc, as this is always a quite risky
challenge and we already have production code. On the other hand
I only need to support RT-Linux on x86 and ARM and I don't need
the assembly-optimized versions.

Thanks
-- 
                                        Stano

