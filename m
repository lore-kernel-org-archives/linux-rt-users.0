From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] RT: remove "paranoid" limit in push_rt_task
Date: Fri, 3 Oct 2008 21:15:01 +0530
Message-ID: <20081003154501.GB5032@linux.vnet.ibm.com>
References: <20081003123745.17387.61782.stgit@dev.haskins.net> <20081003124305.17387.90233.stgit@dev.haskins.net> <48E62253.1090000@bull.net>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, dvhltc@us.ibm.com, dino@in.ibm.com
To: Gilles Carry <Gilles.Carry@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP02.au.ibm.com ([202.81.18.163]:42256 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYJCPs0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Oct 2008 11:48:26 -0400
Content-Disposition: inline
In-Reply-To: <48E62253.1090000@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Gilles Carry <Gilles.Carry@bull.net> [2008-10-03 15:46:59]:

> Sorry Greg,
>
> Neither PPC64 nor Intel64 make it with this patch.
> At boot time, it stops at the BUG_ON you added:
> 0xc00000000004eca4 is in push_rt_task (kernel/sched_rt.c:1102)
I am also confirming this issue gilles reported.

Although, i have a question:
When we enable group scheduling (CONFIG_RT_GROUP_SCHED),
all the problems disappear.
After skimming through the rt scheduler code, I don't feel group 
scheduling alters the behavior of push/pull strategies in any way.

So I am wonder whether enabling group scheduling
actually solves the problem or just makes it tough 
to recreate?

> I let you do more investigations.
> Have a good week-end in you garage ;)
Have a great weekend :)
>
-- 
-Thanks,Chirag
