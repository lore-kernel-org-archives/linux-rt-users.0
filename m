From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.19-rt6, yum/rpm
Date: Fri, 15 Dec 2006 17:19:52 +0100
Message-ID: <20061215161952.GA29191@elte.hu>
References: <20061205171114.GA25926@elte.hu> <4582CAD6.9040404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752837AbWLOQWu@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Content-Disposition: inline
In-Reply-To: <4582CAD6.9040404@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> >as usual, bugreports, fixes and suggestions are welcome,
> 
>    Be aware that even with the newest -rt patch, the PowerPC TOD 
> vsyscalls are still broken, i.e. glibc may return imprecise/incorrect 
> results for the related calls -- despite arch/powerpc/kernel/time.c 
> has been at last fixed to at least compile, the PowerPC clocksource 
> patch removed the important part of TOD vsyscall support, and this 
> hasn't been dealt with.  I've sent to Thomas Gleixner a patch removing 
> the affected vsyscalls altogether for the time being in the early 
> November (unfortunately, I came to know of the breakage too late, and 
> hadn't time to deal with it propery due to othr woes), however, I'm 
> not seeing any of my patches (I've also done PowerPC clockevents 
> support) merged to -rt (or otherwise published). Most of the patches 
> can be found in the linuxppc-dev list archives, for the interested...

could you resend them to me please?

	Ingo
