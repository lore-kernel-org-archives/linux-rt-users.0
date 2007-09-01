From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.23-rc4-rt1 / new project URL
Date: Sat, 01 Sep 2007 08:50:40 -0700
Message-ID: <1188661841.11196.6.camel@dhcp193.mvista.com>
References: <1188593944.9647.15.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756189AbXIAQCj@vger.kernel.org>
In-Reply-To: <1188593944.9647.15.camel@chaos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-08-31 at 22:59 +0200, Thomas Gleixner wrote:

> - loadavgrt fix (Luis Claudio R. Goncalves)

Sven caught that this patch was broken, I think there is an updated
one.. It's also breaking !PREEMPT_RT compiles..

 dwalker2/140 failed
kernel/timer.c: In function 'calc_load':
kernel/timer.c:962: error: implicit declaration of function 'count_active_rt_tasks'
make[1]: *** [kernel/timer.o] Error 1


Daniel
