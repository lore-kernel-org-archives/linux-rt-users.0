Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:52610 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933378AbeFLRyo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Jun 2018 13:54:44 -0400
Date: Tue, 12 Jun 2018 12:53:55 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: [v4.9 RT 0/6] futex backports
Message-ID: <20180612175355.GH15066@jcartwri.amer.corp.natinst.com>
References: <20180606133131.7747-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606133131.7747-1-bigeasy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

On Wed, Jun 06, 2018 at 03:31:25PM +0200, Sebastian Andrzej Siewior wrote:
> Hi Julia,

Hey Sebastian-

> as mentioned in the stable meeting, here is the futex patch that was
> missing in the v4.9 tree :)
>
> The futex state in v4.9 was backported from a later kernel at the time
> Peter made the patches. That is why all the fixes which were tagged
> stable did not enter the v4.9 stable tree.

This is a downside to backporting major functionality to an older
release. :(

> I had a "deadlock assert in glibc" from pthread_mutex_lock() which did
> not make a lot of sense. After comparing the futex code in latest v4.9
> and v4.14 I identified a few patches which should be backported.

Ah, yes.  As you can see, my name was on these patches because we ran
into this issue.  Sorry you similarly had to run into this.

> I haven't seen the issue after applying the patches which follow as a
> reply to this email. They apply on top of v4.9.98-rt76.

Thanks!  I'll get these cooked into a release over the next few days.

   Julia
