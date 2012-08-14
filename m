From: Mike Galbraith <efault@gmx.de>
Subject: Re: [rfc patch] fs,reiserfs: unlock superblock before callling
 reiserfs_quota_on_mount()
Date: Tue, 14 Aug 2012 16:56:29 +0200
Message-ID: <1344956189.5477.1.camel@marge.simpson.net>
References: <1344949583.14924.36.camel@marge.simpson.net>
	 <1344954183.6724.8.camel@gandalf.stny.rr.com>
	 <1344955168.14924.85.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344955168.14924.85.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2012-08-14 at 16:39 +0200, Mike Galbraith wrote: 
> On Tue, 2012-08-14 at 10:23 -0400, Steven Rostedt wrote: 
> > On Tue, 2012-08-14 at 15:06 +0200, Mike Galbraith wrote:
> > > Greetings,
> > > 
> > > Using openSUSE's "partitioner" gizmo to set up a reiserfs partition with
> > > quotas and whatnot enabled rewarded me with a deadlock.
> > 
> > Is this just a -rt bug? Can't this deadlock also in mainline?
> 
> It didn't with a NOPREEMPT kernel the one time I tried it, which seemed
> mighty odd when I stared at the rt deadlock.  I'll give it another go, I
> likely just munged q/d NOPREEMPT test.

Nope, no screw-up.  Maybe it can deadlock, but it refused to do so.

-Mike
