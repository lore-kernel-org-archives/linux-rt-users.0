From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG: sleeping function called from invalid context on
 3.10.10-rt7
Date: Wed, 11 Sep 2013 14:35:57 -0400
Message-ID: <20130911143557.14c1fe6a@gandalf.local.home>
References: <20130911102809.GA31663@uudg.org>
	<20130911092623.42efd930@gandalf.local.home>
	<5230895B.5070400@hurleysoftware.com>
	<5230B673.6090800@tuebingen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Hurley <peter@hurleysoftware.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Mario Kleiner <mario.kleiner@tuebingen.mpg.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5230B673.6090800@tuebingen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 11 Sep 2013 20:29:07 +0200
Mario Kleiner <mario.kleiner@tuebingen.mpg.de> wrote:

> That said, maybe preempt_disable is no longer the optimal choice there 
> and there's some better way to achieve good protection against 
> interruptions of that bit of code? My knowledge here is a bit rusty, and 
> the intel kms drivers and rt stuff has changed quite a bit.

If you set your code to a higher priority than other tasks (and
interrupts) than it wont be preempted there. Unless of course it blocks
on a lock, but even then, priority inheritance will take place and it
still should be rather quick. (unless the holder of the lock is doing
that strange polling).

-- Steve
