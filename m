Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3D17C91;
	Sat, 24 May 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748124911; cv=none; b=miuh0kb6skjFvAkAp/5DpMIAx3IVn4ypeHF/dIKf6Q9nfyk36W7EIRBm+nHKDOo670NLY5lQtER00SZbkX0TI2Y1JUkgkQCbNpMBfejHWuqjOr5wpVU4FrncHxRURl/3JqwUvCCeR91v+YNcazYjcsdaj72jcI6IfCSlMcVMhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748124911; c=relaxed/simple;
	bh=Jn4DQanbzMmrQWqPxAVQLPOdWEKZC7J/ZPdBUEV7gek=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IAmV4pOf8a8IIsaRO3qGauL/3fnuqfNBqUOqTAJQiCUetAt+BWyTVMPsJD0Qs1X5ISDMf1TbkaHc10v72GyQxCeA2Ss7S4BshaYKvNYvY+WHbMI12hO5BQcxmFBTxZx+G9mkL65IxP3YdNfMo3ypTiLedXZ7TmjPM+eQd0fbJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=she-devel.com; spf=pass smtp.mailfrom=she-devel.com; dkim=fail (0-bit key) header.d=she-devel.com header.i=@she-devel.com header.b=B3N/oa2u reason="key not found in DNS"; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=she-devel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=she-devel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=she-devel.com header.i=@she-devel.com header.b="B3N/oa2u"
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id CAE633004C49;
	Sun, 25 May 2025 00:09:20 +0200 (CEST)
Authentication-Results: ext-mx-out013.mykolab.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=she-devel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=she-devel.com;
	 h=content-transfer-encoding:content-type:content-type
	:message-id:references:in-reply-to:subject:subject:from:from
	:date:date:mime-version:received:received:received; s=dkim2; t=
	1748124560; x=1749938961; bh=sTkvBYjgQr7BjrFV26gBjeMe496NHv2RsAG
	UaqbUrQo=; b=B3N/oa2ujNtJEQ00Kct0cnXsFz42+hkpgRfhvksONJSmzaHmOR5
	W9DpW8mKhxdK0k3pRm2r7eQCqPp/n+bjbVOy2ImxKgVlQTBJQfvgZmP6Faw5wlim
	AOqDOrLGC14KaGQZUS/yTHU0n9rhxANGrh5L9doQPgKX9gb5V0NhyHWSVsnzpNEh
	l/cDU14Zuw9Co61Oj/dDsLJvqgb8wr/twFtJVEgN03qTi9Il8c7v7ckCjWTCoNFR
	1dITh98nhezAy4xrMyPcPMyvph0f/o/y7GFLpLx/ScNP6SPOQ6jLjbasWEcMzfVu
	dKOpTdzfjSN69GdEJSteA1G+1BxXckG4mPw==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id QeCNPnKlRXfm; Sun, 25 May 2025 00:09:20 +0200 (CEST)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id CBC9B3004C46;
	Sun, 25 May 2025 00:09:17 +0200 (CEST)
Received: from int-subm015.mykolab.com (unknown [10.9.37.15])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id 6187F3244D87;
	Sun, 25 May 2025 00:09:17 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 May 2025 15:09:16 -0700
From: Alison Chaiken <alison@she-devel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: corbet@lwn.net, gratian.crisan@ni.com, triegel@redhat.com,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, achaiken@aurora.tech
Subject: Re: [PATCH] Documentation: locking: update libc support status of PI
 futexes
In-Reply-To: <20250523150028.62N5N42-@linutronix.de>
References: <20241228181546.1315328-1-alison@she-devel.com>
 <20250107153121.wAL-TfKG@linutronix.de>
 <619bfa123308eeb3a548fae36a3f9e4c@she-devel.com>
 <20250523150028.62N5N42-@linutronix.de>
Message-ID: <a8e9dff20e63f135b512ea3235669120@she-devel.com>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2025-05-23 08:00, Sebastian Andrzej Siewior wrote:
> On 2025-01-11 10:55:55 [-0800], Alison Chaiken wrote:
>> > Are you sure? My memory is that glibc avoided using the internal mutex.
>> > The old problem should be gone and pthread_cond_signal() and
>> > pthread_cond_wait() should work.
>> 
>> Ignoring support for 64-bit time, the last substantive change to
>> pthread_cond_wait() and pthread_cond_signal() was Torvald Riegel's  
>> commit
>> ed19993b5b0d05d62cc883571519a67dae481a14 "New condvar implementation 
>> that
>> provides stronger ordering guarantees," which fixed problems with 
>> waking of
>> ineligible futex waiters and with ABA issues concerning the futex 
>> word.
>> What the patch does not do is made clear by the commit message:
>> 
>>      This condvar doesn't yet use a requeue optimization (ie, on a
>> broadcast,
>>      waking just one thread and requeueing all others on the futex of 
>> the
>>      mutex supplied by the program).
>> 
>> What futex-requeue-pi.rst directs is
>> 
>>      In order to support PI-aware pthread_condvar's, the kernel needs 
>> to
>>      be able to requeue tasks to PI futexes.
>> 
>> Riegel and Darren Hart discussed Riegel's patch in at length at the 
>> 2016 RT
>> Summit:
>> 
>> https://wiki.linuxfoundation.org/realtime/events/rt-summit2016/schedule
>> 
>> The related glibc bug report by Darren may be found at
>> 
>>     https://sourceware.org/bugzilla/show_bug.cgi?id=11588
>> 
>> The last comment on the bug from 2017 is by Riegel:
>> 
>>     So far, there is no known solution for how to achieve PI support 
>> given
>> the current constraints we have (eg, available futex operations, POSIX
>> requirements, ...).
>> 
>> I ran the bug reproducer posted by Darren in Qemu and found that it 
>> did not
>> fail.   I'm not sure if the result is valid given the peculiarities of 
>> Qemu,
>> or whether I made some other mistake.
> 
> I've been looking at this again for other reasons and looked at the
> code again…
> 
> Back then we use futex-requeue API and required both futex-object to
> have the PI bit set. This wasn't the case originally, hence the patch 
> by
> Darren which did not make it into the official libc.
> 
> With the rework by Riegel, the mutex within pthread's condvar
> implementation is gone also the usage of the requeue API. The
> pthread_cond_wait()/ pthread_cond_signal() API is back to use futex'
> wait/ wake.
> The glibc comments write something about important ordering constrains.
> The futex wait enqueues the waiter according to its priority. So the
> task with highest priority gets always a front seat. The futex wake
> function wakes always the first waiter in the queue.
> 
> With all this I would say that the glib'c condvar implementation does
> not have any issues since the rework.
> There were a few loops, with a 0 retry counter (basically dead) and 
> they
> have been removed.
> 
> Sebastian

Thanks, Sebastian, for looking into this question.

Torvald Riegel's last patch to pthread_cond_wait.c:

$ git log -n 1 --author=riegel -- pthread_cond_wait.c
commit ed19993b5b0d05d62cc883571519a67dae481a14
Author: Torvald Riegel <triegel@redhat.com>
Date:   Wed May 25 23:43:36 2016 +0200
     New condvar implementation that provides stronger ordering 
guarantees.

Speaking of ordering, the 2016 Linux Realtime Summit happened after, on 
11 October.   Torvald and Darren co-presented a talk about condition 
variables:

https://wiki.linuxfoundation.org/realtime/events/rt-summit2016/pthread-condvars

Torvald in his half of the talk discusses the POSIX requirement which 
necessitated a change to condvars and his redesign.  In the video at 
30:50,

---

Zijlstra:  Even for FIFO, in the previous slides, S2 will only wake W2, 
because W3 was not yet
eligible, but W3 might be the highest-priority waiter.  Strictly 
speaking, W3 was eligible at S2.
[p. 9, W3 was in G2, not G1, but "happened before" S2].    At S2, the 
only possible wakeup was W2,
even thought W3 might be the highest-priority waiter.

Hart: Correct.  Not in this scheme.

Zijstra: Sequence-wise, it's correct,

Hart: it's mathematically correct.

Zijlstra: But it's not the one we want to wake according to PI rules.

Hart: Yep.

Zijlstra: This scheme does not permit us doing so.

Hart: Noted.

---

Darren and Torvald agree that glibc cannot make pthread condvars 
PI-aware without breaking ABI.   Am I missing something?

Thanks,
Alison

---
Alison Chaiken                   alison@she-devel.com
https://she-devel.com
"What respite from her thrilling toil did Beauty ever take — But Work 
might be Electric Rest To those that Magic make" -- Emily Dickinson
