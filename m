From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Workqueue scheduling policy
Date: Mon, 19 Aug 2013 12:24:49 -0400
Message-ID: <20130819122449.422b862b@gandalf.local.home>
References: <CAEWbfHJwxup6RY9bS8G4cecJdAi=CHad3QUbSNYCqZ_cCC0chw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: spdev31 <spdev31@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:26314 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3HSQYu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Aug 2013 12:24:50 -0400
In-Reply-To: <CAEWbfHJwxup6RY9bS8G4cecJdAi=CHad3QUbSNYCqZ_cCC0chw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 15 Aug 2013 13:59:49 -0700
spdev31 <spdev31@gmail.com> wrote:

> Hi,
> 
> I see the workqueue scheduling policys defaults to SCHED_FIFO with the
> 2.6.33 RT patch but is SCHED_NORMAL with the 3.0 RT patch (and newer
> RT patches, I believe).  Can you help me understand the reason for
> using realtime policies for 2.6.33 RT workqueues and non-realtime
> policies for 3.0 RT patch workqueues?
> 

Actually, mainline kernel set workqueues as SCHED_FIFO for 2.6.33 and
no longer does that for 3.0 kernels. Has nothing to do with the -rt
patch.

But as for why they did that switch. Probably because there's no reason
that the workqueues need to be running as a high priority task, just
like ksoftirqd runs as SCHED_OTHER in mainline.

-- Steve
