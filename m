From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] drm/i915: Do not flush caches on RT, print a warning
 instead
Date: Fri, 14 Jun 2013 18:04:40 +0200
Message-ID: <51BB3F18.6030709@linutronix.de>
References: <1369154725.6828.131.camel@gandalf.local.home>  <CALqGcGop=cpgSvcdmwE6QOSjo-JHBDGYpe2qyy3cxULfamgy+w@mail.gmail.com> <1370637266.9844.95.camel@gandalf.local.home> <51B35727.6040907@osadl.org> <51B46AC0.7050502@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <C.Emde@osadl.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christoph Mathys <eraserix@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55154 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab3FNQEr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Jun 2013 12:04:47 -0400
In-Reply-To: <51B46AC0.7050502@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/09/2013 01:45 PM, Carsten Emde wrote:
> Invalidating and flushing all caches may introduce long latencies of up
> to several milliseconds. Do not execute it in PREEMPT_RT_FULL kernels,
> warn once instead and propose to pin all GPU renderering tasks to a
> single CPU, if possible.
> 
> Original commit:
> 25ff1195f8a0b3724541ae7bbe331b4296de9c06 upstream.
> 
> Original log:
> In order to fully serialize access to the fenced region and the update
> to the fence register we need to take extreme measures on SNB+, and
> manually flush writes to memory prior to writing the fence register in
> conjunction with the memory barriers placed around the register write.
> 
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Oh boy.

Chris, I have a few questions:
- is the wbinvd() required even on the local CPU or just the remote?
  According to bugzilla non-smp works fine. If so, you open code
  wbinvd_on_all_cpus()
- is it possible to replace the wbinvd() with clflush() ?
- is the problem going away if every process doing graphics is pinned
  to single CPU and the wbindv() call is avoided?

Sebastian
