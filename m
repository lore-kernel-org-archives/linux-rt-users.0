From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch RT 0/7] Various fixes for the stable RT series - part I
Date: Wed, 11 Jul 2012 19:31:32 -0400
Message-ID: <1342049492.14828.69.camel@gandalf.stny.rr.com>
References: <20120711214552.036760674@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <cbe@osadl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120711214552.036760674@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2012-07-11 at 22:05 +0000, Thomas Gleixner wrote:
> The following patch series is a collection of bug fixes, which should
> go into the 3.x based stable RT trees.
> 
> I have them locally applied to my 3.5 devel queue, but I'm still
> distracted by other events (leap seconds and the like) to get a 3.5
> devel queue released.
> 
> Steven, please pick up the lot.
> 
> I have a part II series pending which is addressing the widely
> observed CPU hotplug issue. I'm going to send that out soon, despite
> the fact that I fundamentaly hate it. Though the hotplug rework which
> I have in the queue has turned out to be more work than expected and
> there is no real way to backport all of the necessary changes into any
> of the existing 3.x based RT trees. So I bite the bullet and go with
> the workarounds to get rid of the last obstacles in the 3.x based RT
> series.

I'll pull these in and start running my tests. I noticed that some of
them are Signed-off-by Carsten first. Did he author them? If so, I'll
make it so his name gets the git author.

Same for Mike Galbraith on patch 6. Only patch 7 has a 'From:' tag.

-- Steve
