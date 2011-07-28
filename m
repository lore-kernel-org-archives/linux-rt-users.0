From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: [ANNOUNCE] 3.0-rt4
Date: Thu, 28 Jul 2011 12:51:13 +0400
Message-ID: <201107281251.16892@zigzag.lvk.cs.msu.su>
References: <alpine.LFD.2.02.1107272222420.2660@ionos> <201107281224.44323@zigzag.lvk.cs.msu.su> <1311842677.5890.209.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	lasaine@lvk.cs.msu.su
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvk-gate.cmc.msu.ru ([212.192.248.233]:34322 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750734Ab1G1IvT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 04:51:19 -0400
In-Reply-To: <1311842677.5890.209.camel@twins>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> On Thu, 2011-07-28 at 12:24 +0400, Nikita V. Youshchenko wrote:
> > (*) we need >1G of memory for data buffers, and have too much legacy
> > software components so moving to 64bit system is not practical within
> > available resource
>
> You can run a complete 32bit userspace on a 64bit kernel without any
> problems.

... expect shared data between kernel and userspace (structures passed over 
ioctl()s, structures in mmapped buffers). Unfortunately, in scope of our 
project (that lasts since 2001 or so), we do have such issues :(.
