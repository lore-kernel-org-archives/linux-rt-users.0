From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: mq_timedrecieve timeout accuracy
Date: Wed, 24 Mar 2010 15:03:50 +0100
Message-ID: <6d09081c1003240703o19ad3dffx20abae9d15e2d0b@mail.gmail.com>
References: <6d09081c1003240527r471ee34etbba11b4b7c7e92b3@mail.gmail.com>
	 <8226231.1269436934345.JavaMail.ngmail@webmail10.arcor-online.net>
	 <6d09081c1003240637w28ee6861tfcef4c7876ef3e40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org, rachana.rao@in.abb.com
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:17594 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946Ab0CXODx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Mar 2010 10:03:53 -0400
Received: by ey-out-2122.google.com with SMTP id 9so423677eyd.5
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Mar 2010 07:03:51 -0700 (PDT)
In-Reply-To: <6d09081c1003240637w28ee6861tfcef4c7876ef3e40@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Wed, Mar 24, 2010 at 2:37 PM, Pradyumna Sampath <pradysam@gmail.com> wrote:
> John, mq_timedrecieve takes abstime. Isnt it supposed to be
> CLOCK_REALTIME ? Anyway, I tried with MONOTONIC .. mq_timedrecieve
> doesnt block on that.
>
> I was just looking at some code in the kernel. linux/ipc/mqueue.c
> +442. This line says:
>
> time = schedule_timeout(timeout);
>
> Maybe this is why produces a timeout that is inaccurate. Shouldnt it
> be schedule_hrtimeout ?

Ok, I just moved the HZ value from 250 to 1000 and the accuracy has
improved significantly from 5-7 to 1-2 miliseconds. But IMHO, we
should still change schedule_timeout to schedule_hrtimeout for better
accuracy on the timeout because in many cases 1-2 miliseconds is just
not good enough.

I will try to push out a patch for this later today.

regards
/prady

-- 
http://www.prady.in
