From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: loadavg vs loadavgrt
Date: Fri, 21 Dec 2007 10:28:39 +0530
Message-ID: <1985e0f60712202058h50e6cd74ne047ff85221a3e3b@mail.gmail.com>
References: <1985e0f60712200235v61e78b99s646149e0d27f125b@mail.gmail.com>
	 <Pine.LNX.4.58.0712201147390.17621@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:51316 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbXLUE6k (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2007 23:58:40 -0500
Received: by rv-out-0910.google.com with SMTP id k20so165873rvb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Dec 2007 20:58:39 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0712201147390.17621@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Dec 20, 2007 10:19 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> So the numbers are bogus!
>

Thanks, understood :)

root@192.168.1.253:~# cat /proc/loadavg
0.00 0.00 0.02 1/52 1159

This seems loadavg is calculating average for non-RT tasks.

I think loadavg should be loadavg(all RT Tasks) + loadavg(all non-RT
tasks) , it means loadavg should be all Tasks(RT + non-RT)  running on
the machine.

In RT we introduced loadavgrt, but we changed the meaning of loadavg.

Currently loadavgrt is correct it is trying to calculate average of RT tasks.
But currently loadavg is loadavgnonrt, it should be loadavg (for all Tasks)

Please correct me, If I am wrong.

Thank you,

Jaswinder Singh.
