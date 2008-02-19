From: "Nelson Castillo" <nelsoneci@gmail.com>
Subject: Re: sched_yield() needed for pthread_cond_signal(..) to work?
Date: Mon, 18 Feb 2008 20:51:38 -0500
Message-ID: <2accc2ff0802181751q13d943e0l8d4484c18f0c275@mail.gmail.com>
References: <2accc2ff0802181016q26eb8b8cm88f45a0162ae21a0@mail.gmail.com>
	 <20080219013513.5eb25b97@hammerfall>
	 <371630906-1203382013-cardhu_decombobulator_blackberry.rim.net-2030994132-@bxe129.bisx.prod.on.blackberry>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michal Schmidt" <mschmidt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	"=?ISO-8859-1?Q?Andr=E9s_Calder=F3n?=" <andres.calderon@emqbit.com>
To: sven@thebigcorporation.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:64812 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbYBSBvl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Feb 2008 20:51:41 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1855327wra.23
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Feb 2008 17:51:39 -0800 (PST)
In-Reply-To: <371630906-1203382013-cardhu_decombobulator_blackberry.rim.net-2030994132-@bxe129.bisx.prod.on.blackberry>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Feb 18, 2008 7:51 PM,  <sven@thebigcorporation.com> wrote:
>
> Sorry for top-posting.
>
> This looks a lot like LTP code, which is full of similar assumptions
>
> Note also that in RT above RT prio 50 signals don't get delivered, and a program waiting for a signal can lock the machine.
> Sent via BlackBerry by AT&T

Thanks a lot for all your feedback.

The implementation I did was flawed. This new example should run and print 1000.
I think there are  no more  bugs :) but I'll check again.

http://svn.arhuaco.org/svn/src/junk/trunk/threads/cond-signal-test-ok.c

I was confused with of pthread_signal and pthread_wait. I hadn't implemented
producer-consumer before. As the FAQ says, depending on sched_yield is bad
design and RT-Linux allows you to find bugs.

The snippet of code was an example to debug an implementation that we
are using now. We needed to port an application that uses RTEMS
(rtems_timer_create, rtems_timer_fire_after, rtems_timer_reset,
rtems_timer_cancel and
rtems_timer_delete). Now I will be able to complete the code. Once I
fix bugs, it should
be available here.

http://svn.arhuaco.org/svn/src/junk/trunk/threads/test_timer.c

I guess it could be useful to someone else porting from RTEMS to Linux-RT.

Regards,
Nelson.-

-- 
http://arhuaco.org
