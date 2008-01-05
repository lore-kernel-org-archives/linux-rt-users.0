From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Question: RT patch and CFS patch ?
Date: Fri, 4 Jan 2008 21:24:52 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801042123410.23332@gandalf.stny.rr.com>
References: <1199271164.7684.0.camel@aquarius.pit.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Andrzej Walczak <awalczak@pit.edu.pl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:48041 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbYAECZF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Jan 2008 21:25:05 -0500
In-Reply-To: <1199271164.7684.0.camel@aquarius.pit.edu.pl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 2 Jan 2008, Andrzej Walczak wrote:

> Dear All,
>
> I have question:
>
> Will RT kernel have any benefits from improved CFS scheduler ?
>
> or maybe this question in other words
>
> Does it make sense to patch kernel with CFS patch
> (http://people.redhat.com/mingo/cfs-scheduler/sched-cfs-v2.6.23.12-v24.1.patch)
> or other relevant  before/after patching with RT patch ?
>

2.6.24-rc-rt should have the latest upstream CFS stuff plus some other
goodies.  2.6.23-rt is still the older CFS scheduler.  I'm currently
trying to get Ingo's backport to run on .23-rt. But I wont release that
with CFS until I get it stable.

-- Steve
