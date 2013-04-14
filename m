From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Realtime capable userspace?
Date: Sun, 14 Apr 2013 14:20:39 +0200
Message-ID: <516A9F17.4080008@meduna.org>
References: <516A7083.8080705@meduna.org> <516A8035.9040604@xenomai.org> <516A9726.9040801@meduna.org> <516A993D.9090006@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:54131 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab3DNMUs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Apr 2013 08:20:48 -0400
In-Reply-To: <516A993D.9090006@xenomai.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 14.04.2013 13:55, Gilles Chanteperdrix wrote:

> When malloc needs to grow the memory pool it manages, it will request
> memory to the kernel, using brk or mmap. Since in the Linux kernel, the
> memory is shared with the filesystem cache, the worst case latency for
> satisfying such a memory request is the time of a disk flush, so, given
> the latencies of good old hard disks, it is well in the milliseconds
> range. mlockall will simply force the kernel to satisfy the whole
> request ASAP instead of allocating it little by little, upon memory
> faults, so, may in fact increase the latency of the malloc service.

Yes, the theoretical possibility is definitely here, but I don't think
it can happen in the real life in our environment. Given the processes
running there there is nearly no way that the kernel does not have
enough non-dirty pages to satisfy a brk or mmap request. It is also
highly improbable that the brk/mmap are necessary - during the phase
where the deadlines matter the only way they can happen is heap
fragmentation causing something to temporarily overrun the brk limit.

You are right, as soon as the kernel has to flush some dirty pages
the malloc latency goes through the roof - we have a CF Card instead
of a good old hard disk, but tens of ms are definitely possible.

I am using the mlockall() mainly as a guard against throwing
non-dirty code and data pages out and then getting a major
pagefault and wait for the kernel to read them back. This is
a much more probable scenario.

Regards
-- 
                                           Stano

