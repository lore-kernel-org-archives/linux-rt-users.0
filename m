From: Stanislav Meduna <stano@meduna.org>
Subject: Re: hrtimer: interrupt took 6742 ns, then RT throttling and hung
 machine for nearly 2 seconds
Date: Mon, 15 Apr 2013 14:56:29 +0200
Message-ID: <516BF8FD.2000700@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:41480 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab3DOM4i (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Apr 2013 08:56:38 -0400
In-Reply-To: <alpine.LFD.2.02.1304151416580.21884@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 15.04.2013 14:22, Thomas Gleixner wrote:

> Yes, we decoded that problem a week ago. Patch is available here:
> 
> http://www.spinics.net/lists/linux-tip-commits/msg19100.html
> 
> It's on the way to Linus tree, so it will come via the stable updates
> to RT soon.

Hmm, this is a uniprocessor. Could this still happen via some interrupt
or something?

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Celeron(R) M processor         1.00GHz
stepping        : 8
cpu MHz         : 999.993
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx bts
bogomips        : 1999.98
clflush size    : 64
cache_alignment : 64
address sizes   : 32 bits physical, 32 bits virtual
power management:


Thanks
-- 
                                              Stano

