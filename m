From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Porting intLock()
Date: Thu, 4 Oct 2007 18:16:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710041813420.9615@gandalf.stny.rr.com>
References: <loom.20071004T185733-342@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Morten Mossige <morten.mossige@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:43342 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758190AbXJDWQU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Oct 2007 18:16:20 -0400
In-Reply-To: <loom.20071004T185733-342@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--

On Thu, 4 Oct 2007, Morten Mossige wrote:

> Hi
> I'm porting an application from another realtime-os to Linux. This
> application makes use of intLock() from time to time. I still need the the
> application to be compilable on both Linux and my old os, so I  need a
> portabel intLock()
> I have tried the following approach:
> When a thread needs to do intLock, I boost the thread-pri to max, and when
> the thread does intUnLock() I set the thread-pri back. This woorks quite ok,
> but by using this approach, I will also lock other threads in other
> applications running on Linux.
> What I really need is a way of blocking all other threads in my application,
> without affecting other applications.
> I know I can use mutex'es and semaphores, but that will require a major
> rewriting of the application, and that is somthing I dont want to do.
> Can someone come up with an idea how this is done best?
> Morten

Upping the prio is basically what intLock does really. That is upping it
over the priority of interrupts, which would also mean that you would not
be preempted. So by increasing the prio to max, you have in essence locked
out all interrupts from that CPU, as well as other tasks.  So just doing
for you application doesn't make sense. Note, the timer interrupt will
still go off.

Without knowing more about you application, we really cant give much more
advice.
