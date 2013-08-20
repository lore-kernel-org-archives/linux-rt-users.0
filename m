From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.10.6-rt3
Date: Tue, 20 Aug 2013 10:06:51 -0400
Message-ID: <20130820100651.32e1b79c@gandalf.local.home>
References: <20130812163413.GI23040@linutronix.de>
	<520D212F.7030400@localhost>
	<20130815152210.5ed93696@gandalf.local.home>
	<520DCE5F.1040402@linutronix.de>
	<521254A0.6050603@localhost>
	<20130819202903.692097ea@gandalf.local.home>
	<20130819210208.426e01b3@gandalf.local.home>
	<52131747.4010105@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Kent Overstreet <kmo@daterainc.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52131747.4010105@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 20 Aug 2013 09:14:15 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 08/20/2013 03:02 AM, Steven Rostedt wrote:
> > Looking at it more, I can now see why they did what they did.
> 
> He is the only user in the whole kernel. It is somehow hard to believe
> that it can't be solved differently.
> 

Perhaps. But if I understand the code, this is what they have.

When a request is sent out, the writes must wait till it is complete
before it can do anything, thus the writers wait. When the request
finishes (by a different thread), it releases the reader, then the
writers can continue.

The problem is that the task that sends the request does not wait for
it to finish. But until the request does finish, all writers must wait.
To complicate the matter, it appears that more than one request can be
in transition at a time. That is, its not just a single request the a
writer must wait for, it could be many.

The only way I can think of at the moment to fix this without
non-owner, is to set up a wait queue, and a ref count. Basically have
this:

writer:

  again:
	down_write(lock);
	if (refcount) {
		up_write(lock);
		wait_event(wq, !refcount);
		goto again;
	}

reader:
	down_read(lock);
	refcount++;
	request();
	up_read(lock);

completion:

	down_read(lock);
	refcount--;
	up_read_(lock);

The refcount would need to be an atomic, but I think this would work.

Maybe I'll submit it to get rid of the one user of non_owner().

-- Steve
