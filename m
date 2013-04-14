From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: Realtime capable userspace?
Date: Sun, 14 Apr 2013 13:55:41 +0200
Message-ID: <516A993D.9090006@xenomai.org>
References: <516A7083.8080705@meduna.org> <516A8035.9040604@xenomai.org> <516A9726.9040801@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xenomai.org ([88.191.142.154]:39865 "EHLO xenomai.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362Ab3DNLzo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Apr 2013 07:55:44 -0400
In-Reply-To: <516A9726.9040801@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/14/2013 01:46 PM, Stanislav Meduna wrote:

> On 14.04.2013 12:08, Gilles Chanteperdrix wrote:
> 
>> PI mutexes are not sufficient to make malloc deterministic. I guess if
>> you are looking for a deterministic malloc, you should have a look at TLSF.
> 
> Yup, I know that malloc from glibc is a complicated beast and should
> be probably not used at all during hard realtime operation.
> 
> Right now my biggest problem is the possibility of priority inversion.
> My time constraints are in the 20 - 50 ms range and I hope the malloc
> itself - while not deterministic - is not unbounded / won't go to that
> times. I am of course using mlockall and everything. OTOH a priority
> inversion case is a sure recipe for missing the deadlines.


mlockall does not really help reducing malloc worst case latency.

When malloc needs to grow the memory pool it manages, it will request
memory to the kernel, using brk or mmap. Since in the Linux kernel, the
memory is shared with the filesystem cache, the worst case latency for
satisfying such a memory request is the time of a disk flush, so, given
the latencies of good old hard disks, it is well in the milliseconds
range. mlockall will simply force the kernel to satisfy the whole
request ASAP instead of allocating it little by little, upon memory
faults, so, may in fact increase the latency of the malloc service.

-- 
                                                                Gilles.
