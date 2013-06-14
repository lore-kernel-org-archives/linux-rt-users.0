From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] drm/i915: Do not flush caches on RT, print a warning instead
Date: Fri, 14 Jun 2013 22:32:13 +0200
Message-ID: <CAKMK7uEjuMsU_jmbYKAK_dA7E+Rbro8dqUAN6T0tiM65J2hvAQ@mail.gmail.com>
References: <1369154725.6828.131.camel@gandalf.local.home>
	<CALqGcGop=cpgSvcdmwE6QOSjo-JHBDGYpe2qyy3cxULfamgy+w@mail.gmail.com>
	<1370637266.9844.95.camel@gandalf.local.home>
	<51B35727.6040907@osadl.org>
	<51B46AC0.7050502@osadl.org>
	<51BB3F18.6030709@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Wilson <chris@chris-wilson.co.uk>,
	Carsten Emde <C.Emde@osadl.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christoph Mathys <eraserix@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:51917 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab3FNUcN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Jun 2013 16:32:13 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so2422348iea.3
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Jun 2013 13:32:13 -0700 (PDT)
In-Reply-To: <51BB3F18.6030709@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 14, 2013 at 6:04 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 06/09/2013 01:45 PM, Carsten Emde wrote:
>> Invalidating and flushing all caches may introduce long latencies of up
>> to several milliseconds. Do not execute it in PREEMPT_RT_FULL kernels,
>> warn once instead and propose to pin all GPU renderering tasks to a
>> single CPU, if possible.
>>
>> Original commit:
>> 25ff1195f8a0b3724541ae7bbe331b4296de9c06 upstream.
>>
>> Original log:
>> In order to fully serialize access to the fenced region and the update
>> to the fence register we need to take extreme measures on SNB+, and
>> manually flush writes to memory prior to writing the fence register in
>> conjunction with the memory barriers placed around the register write.
>>
>> Cc: Chris Wilson <chris@chris-wilson.co.uk>
>> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>
> Oh boy.
>
> Chris, I have a few questions:
> - is the wbinvd() required even on the local CPU or just the remote?
>   According to bugzilla non-smp works fine. If so, you open code
>   wbinvd_on_all_cpus()
> - is it possible to replace the wbinvd() with clflush() ?


-next has an extended version of this w/a where we also bang a special
register after the wbinvd - the current one isn't good enough on
baytrail platforms. Thus far we haven't found anything less offensive
that still works (hey, we've started with machine_stop!), but we're
working together with hw engineers trying to figure out what's going
on.

> - is the problem going away if every process doing graphics is pinned
>   to single CPU and the wbindv() call is avoided?

Yep, the issue only happens when threads migrate while they're
accessing tiled buffers thru the gtt.

-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
