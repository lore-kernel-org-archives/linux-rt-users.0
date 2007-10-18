From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Thu, 18 Oct 2007 09:32:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710180928480.9970@gandalf.stny.rr.com>
References: <20071018124827.GA22282@in.ibm.com> <20071018.055242.115933276.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ankita@in.ibm.com, linux-rt-users@vger.kernel.org,
	ghaskins@novell.com, mingo@elte.hu, dino@in.ibm.com,
	dvhltc@us.ibm.com, kravetz@us.ibm.com
To: David Miller <davem@davemloft.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:43283 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933129AbXJRNdc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 09:33:32 -0400
In-Reply-To: <20071018.055242.115933276.davem@davemloft.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--

On Thu, 18 Oct 2007, David Miller wrote:

> From: ankita@in.ibm.com (Ankita Garg)
> Date: Thu, 18 Oct 2007 18:18:27 +0530
>
> > Any thoughts on where in the code could these large latencies be
> > attributed to?
>
> If the max latency is usually the first one, it's could be the page
> fault the signal handler is taking the first time it is executed.

This test doesn't seem to use mlock.

Ankita, could you add it to the start of the test and see if it helps with
the latencies?

Could you add a

  mlockall(MCL_CURRENT | MCL_FUTURE);

to the start of the test. That should help with any page faulting issues.

-- Steve
