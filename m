From: "Robert de Vries" <robert.h.de.vries@gmail.com>
Subject: Re: How to dedicate a CPU for real time applications?
Date: Fri, 20 Apr 2007 11:09:14 +0200
Message-ID: <47db5b910704200209j311ecc16r1967739eec7810b4@mail.gmail.com>
References: <46281FC8.2000209@l1nuxh4ck3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Bernhard Kuhn" <kuhn@l1nuxh4ck3r.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:60171 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992705AbXDTJJP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 05:09:15 -0400
Received: by nz-out-0506.google.com with SMTP id s1so691975nze
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Apr 2007 02:09:14 -0700 (PDT)
In-Reply-To: <46281FC8.2000209@l1nuxh4ck3r.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 4/20/07, Bernhard Kuhn <kuhn@l1nuxh4ck3r.de> wrote:
>
> Hi!
>
> Although -rt provides exceptionaly low latencies, i'd like
> to try out further optimization by dedicating one CPU in
> a SMP system for real time application ("Shielded CPU").
>
> If applying "isolcpus=1", then most processes will be
> bound to CPU0 as expected (per CPU kernel threads need
> to stay), but, interrupts are still distributed amongst
> CPUs. I tried to modify /proc/irq/*/smp_affinity, but
> the cpu mask doesn't change for most interrupts.
>
> Any ideas what could be the problem? TIA!

You have to enable IRQBALANCE in the kernel.
Then you have to disable the irqbalance daemon or else your carefully
redirected interrupts are directed back behind your back.
Then you can do /bin/echo 1 > /proc/irq/10/smp_affinity.
Beware that the mask is not updated immediately. It is updated the
next time an interrupt is serviced. This may take a long time if there
are only a few interrupts sent or none.

I'll write something up about this in the Real-Time Linux Wiki.

On a related note: I am working on a user space library to make it
easy to do CPU shielding of other processes (what you do with
isolcpus=1, but then dynamic) using the cpuset feature of the kernel.
I have only just begun to develop this library so only the very basic
features are implemented.

Let me know if someone is interested in using it.

     Robert
