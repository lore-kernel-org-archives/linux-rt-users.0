From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: cpu stall and hyperthread
Date: Fri, 06 Jul 2012 01:02:25 +0200
Message-ID: <4FF61D01.9040502@osadl.org>
References: <4FEBCDDE.60503@gmail.com> <4FF351C6.3000100@gmail.com> <4FF4C94A.6040105@osadl.org> <4FF5DFDC.9010501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Dong Liu <dliu.cn@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:41006 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933237Ab2GEXMH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Jul 2012 19:12:07 -0400
In-Reply-To: <4FF5DFDC.9010501@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Dong,

> I tried to disable CONFIG_RT_GROUP_SCHED, but I still got cpu stalls!
Just had another look at your dmesg files. Didn't you get
   BUG: soft lockup - CPU#0 stuck for 279s! [swapper/0:0]
before? Now - with CONFIG_RT_GROUP_SCHED disabled - you get:
   rcu_preempt detected stalls on CPUs/tasks: { 3} [..]

Is it reproducible? Maybe, there are two different problems. One leads 
to soft lockups and is related to CONFIG_RT_GROUP_SCHED, and another one 
that leads to rcu_preempt stalls.

	-Carsten.
