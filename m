From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24.7-rt8
Date: Wed, 21 May 2008 08:47:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805210845090.13661@gandalf.stny.rr.com>
References: <1211258763.14697.82.camel@localhost.localdomain>
 <1211351104.5484.13.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934620AbYEUMro@vger.kernel.org>
In-Reply-To: <1211351104.5484.13.camel@marge.simson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 21 May 2008, Mike Galbraith wrote:
> On Tue, 2008-05-20 at 00:46 -0400, Steven Rostedt wrote:
> > We are pleased to announce the 2.6.24.7-rt8 tree, which can be
> > downloaded from the location:
> >
> >   http://rt.et.redhat.com/download/
>
> I ran mysql+oltp (ro) on 2.6.24.7-rt7 and 2.6.25-rt2 to compare
> throughput to their parent trees, and ended up with strange (and
> verified) looking performance curves for both trees.  The changes in
> 2.6.24.7-rt8 and 2.6.25.4-rt3 cured the primary oddities.

The difference between 24-rt7 and 24-rt8 as well as with 25-rt2 and 25-rt3
is the deserialization of rwlocks. The rt patch as always serialized
readers to allow for priority inheritance with rwlocks. I wrote a patch to
break that and allow for multiple readers and still keep the priority
inheritance.

Your test probably had a bottle neck on a rwlock (same for rwsems)
somewhere that the new code solved.

-- Steve
