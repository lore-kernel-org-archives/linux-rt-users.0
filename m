From: "David L. Craig" <dlc@radix.net>
Subject: Re: 2.6.26-rt9 Hang
Date: Sun, 28 Sep 2008 21:05:46 -0400
Message-ID: <20080929010546.GA28281@saltmine.radix.net>
References: <20080928223129.GA20775@saltmine.radix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from saltmine.radix.net ([207.192.128.40]:64464 "EHLO
	saltmine.radix.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbYI2BFs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 28 Sep 2008 21:05:48 -0400
Received: from saltmine.radix.net (localhost [127.0.0.1])
	by saltmine.radix.net (8.12.2/8.12.2) with ESMTP id m8T15lh6000486
	for <linux-rt-users@vger.kernel.org>; Sun, 28 Sep 2008 21:05:47 -0400 (EDT)
Received: (from dlc@localhost)
	by saltmine.radix.net (8.12.2/8.12.2/Submit) id m8T15krt000485
	for linux-rt-users@vger.kernel.org; Sun, 28 Sep 2008 21:05:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080928223129.GA20775@saltmine.radix.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The magic SysRc keys stop when it hangs.  The d command
gives me:

  Sep 28 20:50:08 muse kernel: [  223.281343] SysRq : HELP :
  loglevel0-8 reBoot Crashdump tErm Full kIll saK aLlcpus
  showMem Nice powerOff showPc show-all-timers(Q) unRaw Sync
  showTasks Unmount shoW-blocked-tasks showalLcpupc

up until it freezes.  uname -a gives me:

  Linux muse 2.6.26.5-rt9 #3 SMP PREEMPT RT Sat Sep 27
  20:44:21 EDT 2008 i686 GNU/Linux

I'm off to bed.  Tomorrow's another day.

-- 

May the LORD God bless you exceedingly abundantly!

Dave Craig

-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
"'So the universe is not quite as you thought it was.
 You'd better rearrange your beliefs, then.
 Because you certainly can't rearrange the universe.'"

--from _Nightfall_  by Asimov/Silverberg
