From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: mq_timedrecieve timeout accuracy
Date: Wed, 24 Mar 2010 14:37:23 +0100
Message-ID: <6d09081c1003240637w28ee6861tfcef4c7876ef3e40@mail.gmail.com>
References: <6d09081c1003240527r471ee34etbba11b4b7c7e92b3@mail.gmail.com>
	 <8226231.1269436934345.JavaMail.ngmail@webmail10.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org, rachana.rao@in.abb.com
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33566 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982Ab0CXNhZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Mar 2010 09:37:25 -0400
Received: by ewy8 with SMTP id 8so1211517ewy.28
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Mar 2010 06:37:24 -0700 (PDT)
In-Reply-To: <8226231.1269436934345.JavaMail.ngmail@webmail10.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Wed, Mar 24, 2010 at 2:22 PM, M. Koehrer <mathias_koehrer@arcor.de> wrote:
> Does it help to run the posix threads with realtime priority by calling
> pthread_setschedparam() with SCHED_FIFO and a suitable priority?
> As fas as I understand your code, the threads run with standard (non realtime
> priority).

Yes. I tried this with a chrt -f 99. But I still end up getting those
large deviations.

John, mq_timedrecieve takes abstime. Isnt it supposed to be
CLOCK_REALTIME ? Anyway, I tried with MONOTONIC .. mq_timedrecieve
doesnt block on that.

I was just looking at some code in the kernel. linux/ipc/mqueue.c
+442. This line says:

time = schedule_timeout(timeout);

Maybe this is why produces a timeout that is inaccurate. Shouldnt it
be schedule_hrtimeout ?

regards
/prady

--
http://www.prady.in
