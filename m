From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Don't disable preemption in exception handlers without
 IST
Date: Sat, 27 Oct 2007 10:31:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710271031190.28295@gandalf.stny.rr.com>
References: <20071027103933.GA9536@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:47491 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbXJ0Obj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2007 10:31:39 -0400
In-Reply-To: <20071027103933.GA9536@wotan.suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



--
On Sat, 27 Oct 2007, Andi Kleen wrote:

>
> Some of the exception handlers that run on an IST in a normal kernel
> still disable preemption. This causes might_sleep warning when sending signals
> for debugging in PREEMPT-RT because sending signals can take a lock.
> Since the ISTs are disabled now for those don't disable the preemption.
>
> This completes the remove IST patch I sent some time ago and fixes
> another case where using gdb caused warnings.
>
> Also it will likely improve latency a little bit.
>
> Signed-off-by: Andi Kleen <ak@suse.de>

Thanks, applied.

-- Steve
