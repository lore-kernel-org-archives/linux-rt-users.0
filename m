From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH RT 2/2 v4] preempt-rt/x86: Delay calling signals in int3
Date: Mon, 6 Feb 2012 17:25:32 +0100
Message-ID: <20120206162532.GA6951@redhat.com>
References: <20120203182853.547078531@goodmis.org> <20120203183041.427463295@goodmis.org> <20120203184016.GA10413@redhat.com> <1328299833.5882.211.camel@gandalf.stny.rr.com> <20120205192305.GB12183@redhat.com> <20120205193146.GC12183@redhat.com> <1328544744.2200.11.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander van Heukelum <heukelum@fastmail.fm>,
	Andi Kleen <ak@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>, stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65400 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754513Ab2BFQct (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Feb 2012 11:32:49 -0500
Content-Disposition: inline
In-Reply-To: <1328544744.2200.11.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/06, Steven Rostedt wrote:
>
> On Sun, 2012-02-05 at 20:31 +0100, Oleg Nesterov wrote:
> > Damn. Sorry for noise...
> >
> > On 02/05, Oleg Nesterov wrote:
> > >
> > > +int force_sig_info(int sig, struct siginfo *info, struct task_struct *t)
> > > +{
> > > +#ifdef CONFIG_PREEMPT_RT_FULL
> > > +	if (in_atomic()) {
> > > +		if (WARN_ON_ONCE(t != current))
> >
> > This is certainly wrong in upstream kernel. It does use force_
> > this way although it shouldn't imho.
>
> It's wrong in upstream even with the #ifdef define here?

No, the patch has no effect if !CONFIG_PREEMPT_RT_FULL.

Oleg.

