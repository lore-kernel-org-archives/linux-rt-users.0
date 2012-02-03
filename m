From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/2 v4] preempt-rt/x86: Delay calling signals in int3
Date: Fri, 03 Feb 2012 15:10:33 -0500
Message-ID: <1328299833.5882.211.camel@gandalf.stny.rr.com>
References: <20120203182853.547078531@goodmis.org>
	 <20120203183041.427463295@goodmis.org> <20120203184016.GA10413@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
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
To: Oleg Nesterov <oleg@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:40776 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab2BCUKf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 15:10:35 -0500
In-Reply-To: <20120203184016.GA10413@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-02-03 at 19:40 +0100, Oleg Nesterov wrote:

> Stupid question. Do we really need to send the signal from here?

If we can do it correctly elsewhere, I'm fine with that too :-)

> 
> Why force_sig(rt => T) can't set TIF_NOTIFY_RESUME instead? Then
> we can change do_notify_resume() to check TIF_FORCE_SIG_TRAP. And
> perhaps we can even avoid the new TIF_FORCE_SIG_TRAP, we could
> check task->stored_info_set.

You know the signal code much better than I do. If that works, I'm all
for that too. I really don't like the entry_64 solution, but it was what
I knew would work.

> 
> In fact I feel this can be simplified even more, but I am not sure.

My strengths are in the entry_64.S code, not the signal code, so I fixed
it the best way that I felt. This does not imply my fix is the best. If
we can solve this in a clean way using the existing signal
infrastructure, I'm all for that.

-- Steve


