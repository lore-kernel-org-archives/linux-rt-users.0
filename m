From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Posix Execution time clock
Date: Tue, 1 Dec 2009 10:32:28 -0200
Message-ID: <20091201123228.GM3864@uudg.org>
References: <4B1508B5.7030202@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Hector Perez Tijero <perezh@unican.es>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:34657 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbZLAMca (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Dec 2009 07:32:30 -0500
Received: by ywh12 with SMTP id 12so5057073ywh.21
        for <linux-rt-users@vger.kernel.org>; Tue, 01 Dec 2009 04:32:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B1508B5.7030202@unican.es>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Dec 01, 2009 at 07:14:45AM -0500, Hector Perez Tijero wrote:
> Hi,
>
> My question might be a little basic for this list... Maybe someone could  
> point me out to another forum :)
>
> I'm trying to get some measures using the execution time clock in my  
> system and I found some slight differences in the use of the  
> CLOCK_THREAD_CPUTIME_ID and CLOCK_MONOTONIC clocks. The measures are  
> between the same points of code. My concern is that, sometimes, the  
> measure obtained with CLOCK_MONOTONIC is lower than using  
> CLOCK_THREAD_CPUTIME_ID. Find below a dummy example to test this strange  
> behavior.
>
> It doesn't happen very often but the error could be around hundreds of  
> microseconds.
>
> So my question is: are both POSIX clocks based on different physical  
> clocks? I always though they use the TSC...

Check the dmesg logs for hints on TSC. There are some TSCs that are not
used as clocksources because they are out-of-sync between CPUs, because
they halt on idle, because they halt on inner C-states and so on...

> My previous guess was that such behavior could be caused by the CPU  
> frequency scaling but the same happened when I disabled it.

How many CPUs?

>From http://www.tin.org/bin/man.cgi?section=3&topic=clock_gettime :

  NOTE for SMP systems
       The CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID clocks are
       realized on many platforms using timers from the CPUs (TSC on i386,
       AR.ITC on Itanium). These registers may differ between CPUs and as a
       consequence these clocks may return bogus results if a process is
       migrated to another CPU.

By definition, CLOCK_MONOTONIC seems to be what you want.

Another interesting detail is that you have to check what is the value of
/proc/sys/kernel/vsyscall64 for it constrols the behavior and resolution of
clock reads (enabling or disabling VDSO clock enhancements). Try setting it
to zero and repeating your tests.

Along with that, the latest version for 2.6.24, IIRC, was 2.6.24.7-rt27.
So, it sounds like you are using older versions of old software.

Regards,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

