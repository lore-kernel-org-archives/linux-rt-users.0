From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PREEMPT RT] SLUB and split softirq lock for v3.2-rt
Date: Tue, 23 Apr 2013 22:36:19 -0400
Message-ID: <1366770979.2626.3.camel@gandalf.local.home>
References: <1360771932-27150-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360771932-27150-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2013-02-13 at 17:11 +0100, Sebastian Andrzej Siewior wrote:
> 3.2-rt is a long term supported kernel, which lacks two RT features
> from 3.6: SLUB support and the split softirq lock implementation.
> 
> SLUB has a way better performance than SLAB on RT and the split
> softirq lock implementation is necessary especially for realtime
> networking applications.
> 
> The following patch series backports these features to 3.2-rt.
> 
> Steven, could you please apply these patches to a separate
> 3.2-rt-features branch?
> 

Hi Sebastian,

Which version of 3.2-rt was this applied to. It does not apply, where
patch 7/16 totally does not apply. I looked at the history of 3.2-rt and
I can't find where it would apply.

Thanks,

-- Steve
