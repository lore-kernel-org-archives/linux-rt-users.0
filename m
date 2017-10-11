From: Gene Heskett <gheskett@shentel.net>
Subject: Re: Trace code
Date: Tue, 10 Oct 2017 22:01:02 -0400
Message-ID: <201710102201.02182.gheskett@shentel.net>
References: <CANBvECE8jmVTZSEOV7SBu4X0Toq0oe_7wchXJNiOFJxtzMCn6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda.cloud.shentel.net ([204.111.1.144]:39928 "EHLO
        barracuda.cloud.shentel.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751156AbdJKCL0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Oct 2017 22:11:26 -0400
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda.cloud.shentel.net with ESMTP id c33FAlzzCucIzSlv for <linux-rt-users@vger.kernel.org>; Tue, 10 Oct 2017 22:01:04 -0400 (EDT)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 3580F21F3D
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Oct 2017 22:01:04 -0400 (EDT)
In-Reply-To: <CANBvECE8jmVTZSEOV7SBu4X0Toq0oe_7wchXJNiOFJxtzMCn6A@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 10 October 2017 15:40:30 Victor Moreno Calvo wrote:

> Hello,
>
> My company has decided to move to Linux using the PREEMPT patch for
> some simulators.
>
> We are at the initial phase of the project, so we do not have enough
> experience and data to get the maximum performance or the right tools.
>
> The purpose of this email is to get an idea or more info to know how
> it is possible to measure latency in our code (C++). Are there any
> libraries to measure times for cyclic task or should we use a discrete
> analyzer?
>
The package "linuxcnc", available from the linuxcnc.org web site, has had 
a latency-test utility for several generations of the code for running 
cnc machinery.  This utility is a two thread setup, with one thread that 
can work with floating point processing, looping at (normally) a 1 
kilohertz rate, keeping track of the average loop time, and the amount 
of jitter in the time. It also sets up a 2nd thread, no floating point 
allowed, with e 25 microsecond repeat rate in that thread, again keeping 
track of the actual time, and the amount of jitter.  All displayed in 
nanoseconds.

You might find it useful, we sure do when surveying the boards available 
to see if board x is a suitable candidate to drive a cnc controlled 
machine.  You would I think be amazed at the differences between a $60 
board, and a $300 board, the $60 board often mops the floor with the 2x 
faster $300 board.

You will I expect, also find that C++ code is going to be noticeably 
slower. A good share of the linuxcnc core is written in python.
>
> Regards.
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
