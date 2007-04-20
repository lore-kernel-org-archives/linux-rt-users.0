From: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Subject: Re: How to dedicate a CPU for real time applications?
Date: Fri, 20 Apr 2007 13:43:38 +0200
Message-ID: <4628A76A.1050403@l1nuxh4ck3r.de>
References: <46281FC8.2000209@l1nuxh4ck3r.de> <47db5b910704200209j311ecc16r1967739eec7810b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080104070905090204000902"
Cc: linux-rt-users@vger.kernel.org
To: Robert de Vries <robert.h.de.vries@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:58798 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbXDTLnQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 07:43:16 -0400
In-Reply-To: <47db5b910704200209j311ecc16r1967739eec7810b4@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------080104070905090204000902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Robert de Vries wrote:

> Beware that the mask is not updated immediately. It is updated the
> next time an interrupt is serviced. This may take a long time if there
> are only a few interrupts sent or none.

Thanks! This was the missing link: this matched my
observation that only those interrupts don't change
their cpumask that are not activly in use. And for
seldomly used interrupts, the cpumask change occurs
delayed. Is there a special reason why the affinity
doesn't change immediately?


> I'll write something up about this in the Real-Time Linux Wiki.
> On a related note: I am working on a user space library to make it
> easy to do CPU shielding of other processes (what you do with
> isolcpus=1, but then dynamic)

That would be cool :-)


 > using the cpuset feature of the kernel.

Hopefully, cpusets avoid the problem as side-noted
the "isocpus" parameter in Documentation/kernel-parameters.txt

---- 8< ----
This option is the preferred way to isolate CPUs. The
alternative -- manually setting the CPU mask of all
tasks in the system -- can cause problems and
suboptimal load balancer performance
---- >8 ----


> I have only just begun to develop this library so only the very basic
> features are implemented.
> 
> Let me know if someone is interested in using it.

This certainly sounds interesting! However, i intend to try out
how well hrtimers behave on a dedicated CPU on kernel level.
I have attached a small hrtimers demo with a callback function
running in interrupt context. I can imagine that pretty much
all data and code involved fits into L2 cache and not more pages
then TLB-entries are used. This would heavily increase determinism.
BTW.: what a pity that x86 doesn't has cacheline-locking
instructions (such as PowerPC) - then all interrupt related data
and code could be marked with i.e. "__irq" and moved to a separate
sections that are cache-locked upon startup.

regards

Bernhard


--------------080104070905090204000902
Content-Type: application/x-compressed-tar;
 name="hrtimer_demo-20070416.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hrtimer_demo-20070416.tgz"

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
--------------080104070905090204000902--
