From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC] BKL not necessary in cpuid_open
Date: Wed, 7 Oct 2009 23:01:23 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910072259230.9428@localhost.localdomain>
References: <alpine.LFD.2.00.0910072016190.15183@localhost.localdomain> <20091007201338.GE5903@nowhere>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752870AbZJGVMx@vger.kernel.org>
In-Reply-To: <20091007201338.GE5903@nowhere>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 7 Oct 2009, Frederic Weisbecker wrote:
> Hmm, I'm discovering that in tip:rt/kill-the-bkl
> 
> http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=commitdiff;h=55968ede164ae523692f00717f50cd926f1382a0
> 
> Looks like we have overlaped.
> 
> Thomas it would be nice to post these patches on LKML (or I missed
> them?) and may be to merge them into tip:master, so that they are
> visible and then we lower the risk of any duplicate works in this area.

Now guess why I mentioned this branch sevaral times at the rt summit
last week. It's even documented in Jonathans excellent meeting
minutes on lwn.net :)

Thanks,

	tglx
