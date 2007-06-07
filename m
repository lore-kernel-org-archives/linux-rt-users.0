From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG: at kernel/sched.c:4031 __schedule()
Date: Thu, 07 Jun 2007 11:39:40 -0400
Message-ID: <1181230780.10408.0.camel@localhost.localdomain>
References: <4668112B.4090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Oleg Kechin <okechin@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:34552 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762125AbXFGPjn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2007 11:39:43 -0400
In-Reply-To: <4668112B.4090406@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-06-07 at 17:07 +0300, Oleg Kechin wrote:

> in prepare_task_switch(rq, next); interrupts are enabled,

That's a bug.  __schedule should not have interrupts enabled.
What's the back trace of this?

-- Steve

> but in finish_task_switch(this_rq(), prev); interrupts not disabled
> (it look not symmetrical for me).
> 
> Can anybody tell - is this right behavior?
> I think interrupts should be disabled somewhere in this fragment,
> or may be, scheduler should not complain?
> 
> Oleg Kechin.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
