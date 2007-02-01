From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: v2.6.19-rt6, yum/rpm
Date: Thu, 01 Feb 2007 18:52:38 +0300
Message-ID: <45C20CC6.2070201@ru.mvista.com>
References: <20061205171114.GA25926@elte.hu> <4582CAD6.9040404@ru.mvista.com> <20061215161952.GA29191@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751855AbXBAPwx@vger.kernel.org>
In-Reply-To: <20061215161952.GA29191@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello.

Ingo Molnar wrote:

>>>as usual, bugreports, fixes and suggestions are welcome,

>>   Be aware that even with the newest -rt patch, the PowerPC TOD 
>>vsyscalls are still broken, i.e. glibc may return imprecise/incorrect 
>>results for the related calls -- despite arch/powerpc/kernel/time.c 
>>has been at last fixed to at least compile, the PowerPC clocksource 
>>patch removed the important part of TOD vsyscall support, and this 
>>hasn't been dealt with.  I've sent to Thomas Gleixner a patch removing 
>>the affected vsyscalls altogether for the time being in the early 
>>November (unfortunately, I came to know of the breakage too late, and 
>>hadn't time to deal with it propery due to othr woes), however, I'm 
>>not seeing any of my patches (I've also done PowerPC clockevents 
>>support) merged to -rt (or otherwise published). Most of the patches 
>>can be found in the linuxppc-dev list archives, for the interested...

> could you resend them to me please?

    Seeing that GENERIC_TIME has been thrown out from the -rt patch, it makes 
no sense now (even if I had time -- I also decided to leave this to Thomas as 
the HRT maintainer). Concerning this change: tghe patch that comments out 
recalc_time_offset() call in arch/powerpc/kernel/time.c must have be thrown 
out as well since it's breaking TOD vsyscall support now.

> 	Ingo

WBR, Sergei
