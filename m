From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: preempt-rt: Real Time hogging task
Date: Mon, 06 Feb 2012 11:36:25 -0500
Message-ID: <1328546185.2200.15.camel@gandalf.stny.rr.com>
References: <CAPB=Z-r+3ht0Au3mvrUBQ7-g+r=QfLao19BF7n97662q52fxKg@mail.gmail.com>
	 <1328191924.5882.86.camel@gandalf.stny.rr.com>
	 <CAPB=Z-pbkg1mp+WFjQUAyWAU+c8CuM8WoAN4==h-FNVaZYJmzQ@mail.gmail.com>
	 <CAPB=Z-qNCq9kuqsgrC5vdF9q4tpXnZuH+17c378GmaZD3P9FVQ@mail.gmail.com>
	 <CAPB=Z-qu+T0Zy0YFWP5YyPstGK+FsWqwqpx8PU8jorC_sWi=ow@mail.gmail.com>
	 <1328544236.2200.4.camel@gandalf.stny.rr.com>
	 <CAPB=Z-qenLaD1LYFbu51QaYQMp_Lf6ta0vqXw0qyQ-18s3Hcew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Raz <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:44229 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab2BFQg1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Feb 2012 11:36:27 -0500
In-Reply-To: <CAPB=Z-qenLaD1LYFbu51QaYQMp_Lf6ta0vqXw0qyQ-18s3Hcew@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-02-06 at 18:29 +0200, Raz wrote:
> Hey Steven
> 
> I found what the problem is. It is **not** a  preempt-rt bug, it is
> because made some modifications to 
> the kernel.

Thanks for letting me know. But next time, please, make sure you can
trigger the bug with an unmodified version of -rt *before* sending a bug
report.

-- Steve



