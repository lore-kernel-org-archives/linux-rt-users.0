From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PREEMPT RT] SLUB and split softirq lock for v3.2-rt
Date: Wed, 24 Apr 2013 11:45:32 -0400
Message-ID: <1366818332.2626.5.camel@gandalf.local.home>
References: <1360771932-27150-1-git-send-email-bigeasy@linutronix.de>
	 <1366770979.2626.3.camel@gandalf.local.home> <517793BD.30101@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <517793BD.30101@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2013-04-24 at 10:11 +0200, Sebastian Andrzej Siewior wrote:
> On 04/24/2013 04:36 AM, Steven Rostedt wrote:
> > Hi Sebastian,
> 
> Hi Steven,
> 
> > Which version of 3.2-rt was this applied to. It does not apply, where
> > patch 7/16 totally does not apply. I looked at the history of 3.2-rt and
> > I can't find where it would apply.
> 
> I applied them on top of 2438ee33 ("Linux 3.2.37-rt55 REBASE"). I just
> grabbed the patches from the mailing list and re-applied them on top of
> this tree and is still works.
> 

Nevermind, the problem was at my end :-(  I saved the patches as a mbox,
but evolution decided to move patch 5 to after patch 7, which broke
everything :-p

-- Steve
