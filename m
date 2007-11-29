From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23.8-rt11, tasks freezing
Date: Thu, 29 Nov 2007 16:18:03 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711291617010.26382@gandalf.stny.rr.com>
References: <200711211250.39265.juuso.alasuutari@gmail.com>
 <Pine.LNX.4.58.0711210905530.767@gandalf.stny.rr.com>
 <200711291325.26009.juuso.alasuutari@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Juuso Alasuutari <juuso.alasuutari@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:57622 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759082AbXK2VSM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Nov 2007 16:18:12 -0500
In-Reply-To: <200711291325.26009.juuso.alasuutari@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Thu, 29 Nov 2007, Juuso Alasuutari wrote:

> On Wednesday 21 November 2007 16:11:48 Steven Rostedt wrote:
> > On Wed, 21 Nov 2007, Juuso Alasuutari wrote:
> <snip>
> > > The system boots up nicely and seems to be running properly, until
> > > something tips it off and some commands begin to get "jammed". What seems
> > > to trigger it is accessing the hard disk, for instance doing something
> > > like `grep -r foo /var`. When it happens the desktop seems mostly
> > > responsive, but trying to run commands like `ls` will freeze the
> > > terminal. Other commands will succeed, for instance `ps aux` works as
> > > usual.
> > >
> > > Alt-SysRq-w shows more than one blocked pdflush task, as well as metalog
> > > and whatever commands have become "jammed" so far, like `ls`.
> > >
> > > I'll be happy to post more information, I just need to know what. I'd
> > > attach my .config here, but I can't access the computer from where I'm at
> > > the moment.
> >
> > You can send me the .config off list. Also, if possible, the output of
> > dmesg, sysrq-t and your sysrq-w as well as (try this last because it
> > sometimes hangs the box hard) sysrq-L
>
> Hi,
>
> I sent you the output some time ago, have you had time to look at it?
>


Hi Juuso,

Sorry, several things came up as high priority, and this got pushed back.

I'll try to take a look at it this week.

-- Steve
