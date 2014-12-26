From: Henrik Austad <henrik@austad.us>
Subject: Re: Help needed to implement parameter in SCHED_DEADLINE policy
Date: Fri, 26 Dec 2014 23:14:24 +0100
Message-ID: <20141226221424.GA8000@sisyphus.home.austad.us>
References: <CAD2dHrTBZd6a_QdEqh4xhVj1c-e4bzAKF5uC4N6B+UEh-zgxvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: kernelnewbies@kernelnewbies.org, linux-rt-users@vger.kernel.org
To: Chanchal Paul <paulchanchal.ece@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:62575 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbaLZWOa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Dec 2014 17:14:30 -0500
Received: by mail-lb0-f170.google.com with SMTP id 10so9031199lbg.15
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Dec 2014 14:14:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAD2dHrTBZd6a_QdEqh4xhVj1c-e4bzAKF5uC4N6B+UEh-zgxvg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Dec 26, 2014 at 09:14:22PM +0530, Chanchal Paul wrote:
> Hi all,

Hi Paul,

> I am trying to implement my custom scheduling policy in rt patched
> linux kernel. I am working with version 3.14.25-rt22. I have
> successfully installed the kernel after patching with rt patch of same
> version.
> 
> Now the installed kernel also has SCHED_DEADLINE i.e. the EDF scheduling policy.
> 
> The problem in my hand is to introduce a parameter in the
> SCHED_DEADLINE policy which will further dynamically change the
> priority according to the supplied value while the task is submitted.

You do know that SCHED_DEADLINE does not use priorities but _deadlines_, 
right?

care to elaborate a bit?

> I have already simulated and tested my requirement. I am having
> problem with understanding the hierarchy of scheduler code.

You mean the order of the scheduling policies? If you look at the 
sched_class in the different classes, you'll find the following hierarchy:

stop_sched_class
dl_sched_class
rt_sched_class
fair_sched_class
idle_sched_class

So, first the scheduler sees if there's any deadline tasks, then -rt and so 
on.

I (we) need a bit more info about what exactly it is you're struggling with

> 
> Thanks in advance
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Henrik Austad
