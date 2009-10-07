From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH RFC] BKL not necessary in cpuid_open
Date: Wed, 7 Oct 2009 22:13:41 +0200
Message-ID: <20091007201338.GE5903@nowhere>
References: <alpine.LFD.2.00.0910072016190.15183@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760006AbZJGUOy@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0910072016190.15183@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 07, 2009 at 08:19:32PM +0200, John Kacur wrote:
> 
> I've been staring at the BKL lock in cpuid_open, and I can't see what it 
> is protecting. However, I may have missed something - even something 
> obvious, so comments are welcome.
> 
> From 25c0f07b3ec5533c0e690e06198baa4300ee4a8c Mon Sep 17 00:00:00 2001
> From: John Kacur <jkacur@redhat.com>
> Date: Wed, 7 Oct 2009 20:06:12 +0200
> Subject: [PATCH] The BKL is not necessary in cpuid_open
>  Most of the variables are local to the function. It IS possible that for
>  struct cpuinfo_x86 *c
>  c could point to the same area. However, this is used read only.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>


Hmm, I'm discovering that in tip:rt/kill-the-bkl

http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=commitdiff;h=55968ede164ae523692f00717f50cd926f1382a0

Looks like we have overlaped.

Thomas it would be nice to post these patches on LKML (or I missed
them?) and may be to merge them into tip:master, so that they are
visible and then we lower the risk of any duplicate works in this area.

Thanks.
