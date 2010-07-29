From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: Q6600 + low frequency periodic timer + CPU_IDLE = much jitter
Date: Thu, 29 Jul 2010 12:35:04 +0200
Message-ID: <4C515958.60301@osadl.org>
References: <1280394320.9599.48.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Len Brown <lenb@kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:41681 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757188Ab0G2LsX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jul 2010 07:48:23 -0400
In-Reply-To: <1280394320.9599.48.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Mike,

> It's looking like my Q6600 is kinda slow at switching gears, and I'd
> just like to verify that it is the hardware, not something odd going on
> in cpuidle territory.
Yes, it's the CPU. It is a known restriction of this processor and has
been verified on a number of different systems. It appears that the
processor is halted while the PLL is stabilizing. However, there is no
formal confirmation from Intel AFAIK.

It happens that one of the test systems that we regularly use in the
quality assessment of the PREEMPT_RT patch is a Q6600:
# grep CPU /proc/cpuinfo
model name	: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz
model name	: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz

The recommendation is to add
-=--------------------------------------=-
cd /sys/devices/system/cpu
for i in cpu?/cpufreq/scaling_governor
do
  echo performance >$i
done
cd -
-=--------------------------------------=-
to /etc/rc.d/rc.local and to abandon dynamic frequency scaling on such
systems.


Carsten.
