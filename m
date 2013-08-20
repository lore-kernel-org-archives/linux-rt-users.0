From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.10.6-rt3
Date: Mon, 19 Aug 2013 21:02:08 -0400
Message-ID: <20130819210208.426e01b3@gandalf.local.home>
References: <20130812163413.GI23040@linutronix.de>
	<520D212F.7030400@localhost>
	<20130815152210.5ed93696@gandalf.local.home>
	<520DCE5F.1040402@linutronix.de>
	<521254A0.6050603@localhost>
	<20130819202903.692097ea@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kent Overstreet <kmo@daterainc.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130819202903.692097ea@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 19 Aug 2013 20:29:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 19 Aug 2013 10:23:44 -0700
> Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> 
> > > The problem is that bcache is using new semaphore functions which it
> > > just introduced which rt does not know about. The comment above their
> > > definition says that it is wrong to use them and completion is the
> > > right way to do it.
> > > So my question is, why don't we use completion but this nasty hack?
> 
> I think I'm going to send them an email about that.
> 

Looking at it more, I can now see why they did what they did.

Grumble, we may need to bring back the old "compat" rwsem, or whatever
we called it, and just use that instead. And say that this code will
have no real time boosting.

-- Steve
