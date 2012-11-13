From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: Re: Does anyone use CONFIG_TINY_PREEMPT_RCU?
Date: Tue, 13 Nov 2012 21:22:29 +0100
Message-ID: <201211132122.30259.tim01@vlsi.informatik.tu-darmstadt.de>
References: <20121113004906.GA10557@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	mingo@elte.hu, laijs@cn.fujitsu.com, dipankar@in.ibm.com,
	akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
	josh@joshtriplett.org, niv@us.ibm.com, tglx@linutronix.de,
	peterz@infradead.org, rostedt@goodmis.org, Valdis.Kletnieks@vt.edu,
	dhowells@redhat.com, edumazet@google.com, darren@dvhart.com,
	fweisbec@gmail.com, sbw@mit.edu, patches@linaro.org
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:45370
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755581Ab2KMUWV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2012 15:22:21 -0500
In-Reply-To: <20121113004906.GA10557@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Paul
> I know of people using TINY_RCU, TREE_RCU, and TREE_PREEMPT_RCU, but I
> have not heard of anyone using TINY_PREEMPT_RCU for whom TREE_PREEMPT_RCU
> was not a viable option (in contrast, the people running Linux on
> tiny-memmory systems typically use TINY_RCU).  Of course, if no one
> really needs it, the proper thing to do is to remove it.
> 
> So, if you need TINY_PREEMPT_RCU, please let me know.  Otherwise, I will
> remove it, probably in the 3.9 timeframe.
I am using TINY_PREEMPT_RCU on the i.mx35 platform. I am currently on 3.4-rt 
since the 3.6 compile failed due to for my config? Some strange device tree 
stuff which i haven't had the time to figure out why.

Best regards
Tim
