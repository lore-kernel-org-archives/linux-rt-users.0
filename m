From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Date: Fri, 19 Oct 2007 22:36:34 +1000
Message-ID: <18200.42194.853246.935329@cargo.ozlabs.ibm.com>
References: <20070921032603.0D3EA32C887@thor>
	<4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161C38.2070305@ru.mvista.com>
	<18198.44590.721412.314409@cargo.ozlabs.ibm.com>
	<471777BD.8090800@ru.mvista.com>
	<18200.3600.459275.823335@cargo.ozlabs.ibm.com>
	<47189EF3.7010103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:58857 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbXJSMgs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2007 08:36:48 -0400
In-Reply-To: <47189EF3.7010103@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sergei Shtylyov writes:

>     The xtime_lock is still grabbed by time_init()

That was left in there because we are setting sys_tz and do_gtod, and
do_gtod at least is only updated with the xtime_lock held.  Of course,
at that early stage in the boot process, no lock is really needed, but
xtime_lock was taken for consistency with other code.

In fact there's quite a lot of stuff in there that could be removed
now.  I also want to make the vdso use an algorithm more like what
getnstimeofday does.

>     The only thing I'm still unusre about is that deterministic accounting. 
> Could you point me at the patch which deals with this (at least for System 390 

See efe567fc8281661524ffa75477a7c4ca9b466c63 in Linus' tree, and look
for posts to lkml by Christian Borntraeger, who has been pursuing the
issue (subject "Re: [stable] 2.6.23 regression: top displaying 9999%
CPU usage").

Paul.
