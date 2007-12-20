From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: loadavg vs loadavgrt
Date: Thu, 20 Dec 2007 11:49:55 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0712201147390.17621@gandalf.stny.rr.com>
References: <1985e0f60712200235v61e78b99s646149e0d27f125b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:57484 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759906AbXLTQur (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2007 11:50:47 -0500
In-Reply-To: <1985e0f60712200235v61e78b99s646149e0d27f125b@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 20 Dec 2007, Jaswinder Singh wrote:

> Hello,
>
> By linux-2.6.23-rt3 on ideal condition, I am getting :-
>
> root@192.168.1.253:~# cat /proc/loadavgrt
> 1.00 1.00 1.00 0/52 1158

This is bogus. It's a known issue, and there's a patch in the works.
The problem is that the calculation of load average is done via a softirq,
which in vanilla Linux is not a thread (nor an RT task). But in RT, all
softirqs are RT tasks, and when this calculation is performed, it sees
that there is always an RT task runnning. That RT task that it sees
running happens to be the softirq RT task that is calculating the load!

So the numbers are bogus!

-- Steve


> root@192.168.1.253:~# cat /proc/loadavg
> 0.00 0.00 0.02 1/52 1159
> root@192.168.1.253:~#
>
> I am curious:
> 1. Why loadavgrt is not reflecting load on loadavg
>
> 2. loadavgrt is giving correct information or it is bogus
>
> Thank you,
>
> Jaswinder Singh.
>
