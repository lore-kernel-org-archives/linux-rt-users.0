Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from barracuda2.shentel.net ([204.111.1.145]:39489 "EHLO
        barracuda4.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726917AbeHWVjB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Aug 2018 17:39:01 -0400
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda4.shentel.net with ESMTP id CNgsPJPiW8JTvqll for <linux-rt-users@vger.kernel.org>; Thu, 23 Aug 2018 14:07:45 -0400 (EDT)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 4C53522423
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Aug 2018 14:07:45 -0400 (EDT)
From: Gene Heskett <gheskett@shentel.net>
Subject: Re: SCHED_DEADLINE as user
Date: Thu, 23 Aug 2018 14:07:35 -0400
References: <pl0fsj$ohn$1@blaine.gmane.org> <201808230945.02854.gheskett@shentel.net> <5B7EDA65.7000906@windriver.com>
In-Reply-To: <5B7EDA65.7000906@windriver.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201808231407.35449.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

On Thursday 23 August 2018 12:01:41 Chris Friesen wrote:

> On 08/23/2018 07:45 AM, Gene Heskett wrote:
> > LinuxCNC is also run as a common user, never as root.  Thats my
> > $0.02 from a users viewpoint.
>
> Given that these are special-purpose machines, can I ask why you
> wouldn't run as root if it gave better performance?
>
> Chris

Its a rather bad habit, and if I get used to doing it on this machine, I 
might do it on one of the metal carvers, which has a tendency to mess 
with the user perms. Root or known user is all the same to  lcnc AFAIK. 
I have done it 3 or 4 times, but there is no detectable diff in 
performance. But sometime in the last few years it has now been trained 
to refuse to run as root.

The kernel argument isolcpus= comes in handy occasionally on really old 
but still multicore hdwe but has had little or no effect since about 
kernel 3.4.0 built for SMP and PREEMPT. We don't use  more than 2GB of 
d-ram for the same reason, the patches to give a 4GB capable address are 
also a performance penalty.

Currently running
Linux GO704 3.4-9-rtai-686-pae #1 SMP PREEMPT Debian 3.4.55-4linuxcnc 
i686 GNU/Linux, a 32 bit build because its faster at a context switch 
than the larger stack image the 64 bit build uses.

This machine, my "doitall" machine doesn't drive any of that sort of 
hardware, and is currently running:3.16.0-0.bpo.4-amd64 #1 SMP Debian 
3.16.39-1+deb8u1~bpo70+1 (2017-02-24) x86_64 GNU/Linux which will run 
the simulator so I can write cgode from a comfy chair.  Then export it 
with sshfs to the machine that will actually make the swarf, aka 
metallic sawdust.

Thanks Chris.

-- 
Cheers, Gene Heskett
--
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
