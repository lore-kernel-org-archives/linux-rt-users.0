From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: v2.6.19-rt6, yum/rpm
Date: Fri, 15 Dec 2006 19:18:30 +0300
Message-ID: <4582CAD6.9040404@ru.mvista.com>
References: <20061205171114.GA25926@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752812AbWLOQRH@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061205171114.GA25926@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello everybody.

Ingo Molnar wrote:

> i have released the 2.6.19-rt6 tree, which can be downloaded from the 
> usual place:

>     http://redhat.com/~mingo/realtime-preempt/

[...]

> as usual, bugreports, fixes and suggestions are welcome,

    Be aware that even with the newest -rt patch, the PowerPC TOD vsyscalls 
are still broken, i.e. glibc may return imprecise/incorrect results for the 
related calls -- despite arch/powerpc/kernel/time.c has been at last fixed to 
at least compile, the PowerPC clocksource patch removed the important part of 
TOD vsyscall support, and this hasn't been dealt with.  I've sent to Thomas 
Gleixner a patch removing the affected vsyscalls altogether for the time being 
in the early November (unfortunately, I came to know of the breakage too late, 
and hadn't time to deal with it propery due to othr woes), however, I'm not 
seeing any of my patches (I've also done PowerPC clockevents support) merged 
to -rt (or otherwise published). Most of the patches can be found in the 
linuxppc-dev list archives, for the interested...

> 	Ingo

WBR, Sergei
