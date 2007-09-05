From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: PI mutex support on ARM
Date: Wed, 5 Sep 2007 20:46:13 +0200
Message-ID: <3efb10970709051146r49462626h28e0febbf44282dd@mail.gmail.com>
References: <200708201453.14641.m.gruber@tirol.com>
	 <200709041348.42229.m.gruber@tirol.com>
	 <3efb10970709050557i24dbdc3bub65a5eea249ae8f1@mail.gmail.com>
	 <200709051836.02683.m.gruber@tirol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: "Manfred Gruber" <m.gruber@tirol.com>, tglx@linutronix.de,
	mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:14635 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347AbXIESqP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2007 14:46:15 -0400
Received: by py-out-1112.google.com with SMTP id u77so6224030pyb
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Sep 2007 11:46:14 -0700 (PDT)
In-Reply-To: <200709051836.02683.m.gruber@tirol.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Manfred,

> The only difference between you patch and now 2.6.23-rc4-rt1 is that now a
> raw_ spinlock is used. So i think when using your patch on 2.6.21.5-rt20,
> because a customer has this kernel running, i have there also to use a
> raw_spinlock ?

The same patch applies to older kernels. Besides, I use this patch for
a while now on 2.6.21 and 2.6.22, but with an interrupt lock instead
of a spinlock. A raw_spinlock is better because it is safe in SMP
also, so Ingo has the proper implementation in his patch, which you
should follow. (Probably this is technically the best possible
solution, given the limited amount of atomic-instructions on
ARM-v4/v5)
So, A normal (non-raw) spinlock should NOT be used here, because that
does would be converted to a rt-mutex, which is preemptible. If this
code is preemptible, it could be preempted by another user space
thread which could, in theory, modify the same piece of memory, and
thus causing a race condition.

Notice that there have been raised questions about the interrupt lock
while accessing user space memory in this code, it is considered as
not-safe.
AFAIK the only situation where it is not-safe, is the case where the
memory is not available in RAM, but e.g. somewhere in a swap space. If
the memory has to be paged in, probably interrupts are needed. In my
system things like this will never happen...

Maybe Ingo, Thomas or someone else can acknowledge (or trash) my opinion here?


Kind Regards,

Remy Bohmer
