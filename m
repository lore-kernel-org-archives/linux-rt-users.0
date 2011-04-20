From: Johannes Bauer <hannes_bauer@aon.at>
Subject: Fwd: Re: preempt-rt amd uClibc
Date: Wed, 20 Apr 2011 12:47:44 +0200 (CEST)
Message-ID: <1303296464.4daeb9d04a026@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout05.highway.telekom.at ([195.3.96.77]:57950 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752095Ab1DTKrw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Apr 2011 06:47:52 -0400
Received: from warsbl214-nfs.highway.telekom.at (HELO WARSBL214.highway.telekom.at) ([172.18.96.93])
          (envelope-sender <hannes_bauer@aon.at>)
          by smarthub97.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 20 Apr 2011 10:47:47 -0000
Received: from webmail.aon.at (localhost.localdomain [127.0.0.1])
	by WARSBL214.highway.telekom.at (8.13.1/8.13.1) with SMTP id p3KAliv8010935
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Apr 2011 12:47:46 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Thats good news, thank you Remy!

I was able to run cyclictest
\\\"cyclictest -t1 -p 80 -n -i 10000 -l 1000\\\" an thw maximum latencies were about
650us. However the intervall timers \\\"cyclictest -t1 -p 80 -i 10000 -l 1000\\\"
result in abou 3000us maximum latencies.
Is it common that interval timers have higher latencies and could this values be
reasonable for a 72MHz arm7tdmi (ARMv4T).

Anyone has any values to compare or can tell me if those values are reasonable?

Kind Regards
Johannes Bauer

----- Original von:  Remy Bohmer

> Hi,

2011/4/15 Johannes Bauer <hannes_bauer@aon.at>:
> Hi everybody!
>
> I downloaded the newest uClinux dist a while ago and compiled it with 2.6.33
kernel and the 2.6.33.7.2-rt30 patch applied.
> Then i by hand implemeted an old patch for arm lpc22xx machine (ARMv4T), since
i am running a lpc2478 board from embedded artists.
> I had to implement a clockevent/source timer to add hrtimer support. I
compiled it all with uClibc since it as a NOMMU system.
>
> Now i have some questions:
> Is it possible to run the preempt-rt patch with the uClinux distribution and
uClibc?

The preempt-RT patch runs just fine with a uClibc userspace, I have no
idea what it will do in a NOMMU system (never tried it)

> I read a few times that if doesnt support PI mutexes, but arent those RT
mutexes part of the kernel?

The kernel itself has PI-mutexes support, _internally_within_ the
kernel; regardless what type of userspace C-library is being used.
However, for _userspace_ PI-mutexes, you will need a C-library that
supports it (search for example for PTHREAD_PRIO_INHERIT in the
library code). 2 options:
* Glibc since version 2.5 (actually 2.4.90 and higher)
* uClibc master. You might have some luck since there is now NPTL
support in uClibc master. So, get the master tree of uClibc and see if
it works for you.
(http://git.uclibc.org/uClibc/snapshot/uClibc-master.tar.gz)
I have not tested it myself though, but if it works, please share the
good news.

Have Fun!

Remy
--
To unsubscribe from this list: send the line \\\"unsubscribe linux-rt-users\\\" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



----- Ende der weitergeleiteten Nachricht -----

