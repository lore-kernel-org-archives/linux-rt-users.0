Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:50330 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964966AbeFOQLj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Jun 2018 12:11:39 -0400
Date: Fri, 15 Jun 2018 18:11:35 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v4.9 RT 0/6] futex backports
Message-ID: <20180615161134.2sjx2nitrq73cl2r@linutronix.de>
References: <20180606133131.7747-1-bigeasy@linutronix.de>
 <20180612175355.GH15066@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180612175355.GH15066@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

On 2018-06-12 12:53:55 [-0500], Julia Cartwright wrote:
> On Wed, Jun 06, 2018 at 03:31:25PM +0200, Sebastian Andrzej Siewior wrote:
> Hey Sebastian-
Hi Julia,

> > as mentioned in the stable meeting, here is the futex patch that was
> > missing in the v4.9 tree :)
> >
> > The futex state in v4.9 was backported from a later kernel at the time
> > Peter made the patches. That is why all the fixes which were tagged
> > stable did not enter the v4.9 stable tree.
> 
> This is a downside to backporting major functionality to an older
> release. :(

but we found a few bugs before it hit upstream and it improved things on
the RT side, too.

> > I had a "deadlock assert in glibc" from pthread_mutex_lock() which did
> > not make a lot of sense. After comparing the futex code in latest v4.9
> > and v4.14 I identified a few patches which should be backported.
> 
> Ah, yes.  As you can see, my name was on these patches because we ran
> into this issue.  Sorry you similarly had to run into this.

no worries.

> > I haven't seen the issue after applying the patches which follow as a
> > reply to this email. They apply on top of v4.9.98-rt76.
> 
> Thanks!  I'll get these cooked into a release over the next few days.

thanks.

>    Julia

Sebastian
