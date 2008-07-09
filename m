From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 2/3] sched: terminate newidle balancing once at least one task has moved over
Date: Wed, 9 Jul 2008 18:09:51 +1000
Message-ID: <200807091809.52293.nickpiggin@yahoo.com.au>
References: <20080627202444.3829.21595.stgit@lsg.lsg.lab.novell.com> <200807081500.18245.nickpiggin@yahoo.com.au> <48732751.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, rostedt@goodmis.org, peterz@infradead.org,
	npiggin@suse.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: "Gregory Haskins" <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp113.mail.mud.yahoo.com ([209.191.84.66]:38216 "HELO
	smtp113.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752941AbYGIIKT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jul 2008 04:10:19 -0400
In-Reply-To: <48732751.BA47.005A.0@novell.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 08 July 2008 22:37, Gregory Haskins wrote:
> >>> On Tue, Jul 8, 2008 at  1:00 AM, in message
>
> <200807081500.18245.nickpiggin@yahoo.com.au>, Nick Piggin
>
> <nickpiggin@yahoo.com.au> wrote:
> > On Saturday 28 June 2008 06:29, Gregory Haskins wrote:
> >> Inspired by Peter Zijlstra.
> >>
> >> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> >
> > What happened to the feedback I sent about this?
> >
> > It is still nack from me.
>
> Ah yes.  Slipped through the cracks...sorry about that.
>
> What if we did "if (idle == CPU_NEWLY_IDLE && need_resched())" instead?

Isn't that exactly the same thing because any task will preempt the idle
thread?
