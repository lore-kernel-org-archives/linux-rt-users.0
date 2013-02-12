From: Stanislav Meduna <stano@meduna.org>
Subject: Re: [PATCH] sched/rt: Unthrottle the highest RT task of the rq if
 there are no another available tasks to be picked
Date: Tue, 12 Feb 2013 09:12:23 +0100
Message-ID: <5119F967.3040302@meduna.org>
References: <2260671360618316@web22h.yandex.ru> <1360652809.4657.87.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:48067 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757989Ab3BLIMi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Feb 2013 03:12:38 -0500
In-Reply-To: <1360652809.4657.87.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12.02.2013 08:06, Mike Galbraith wrote:

>> In this case pick_next_task takes idle tasks and idle wastes cpu
>> time.

> That's not a waste of CPU time, that's utilization enforcement the thing
> it is designed to do.

Well this is a philosophical question and the opinions will IMHO
vary strongly. If the throttling kicks in, the system already
is in the out-of-spec state. Is the goal now just to allow
e.g. the ssh login to be able to kill the task and still try
to do the best if otherwise (possibly masking the problem for
months), or is it to enforce the utilization?

For example we have a PLC software where the end-user develops
an application that will be executed in our realtime task.
The application usually has a longer initialization part where
the excess utilization can happen and should be tolerated
and the running part where it is a bug if it happens. Here
I would prefer the throttling to alert the user, but not
to actually throttle if there is no non-RT task actually
wanting to run. In other cases I would maybe prefer even
killing the task, alerting the user to the fact.

I have a related question: is the information that the throttling
happened available somewhere except the log (where it gets only
written once)? If not, would a patch exporting the count
of throttlings via /sys be accepted?

My problem is that I would like to know that the throttling
happened right now and display it to the user.

Regards
-- 
                                        Stano

