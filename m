From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Re: mq_timedrecieve timeout accuracy
Date: Wed, 24 Mar 2010 14:22:14 +0100 (CET)
Message-ID: <8226231.1269436934345.JavaMail.ngmail@webmail10.arcor-online.net>
References: <6d09081c1003240527r471ee34etbba11b4b7c7e92b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rachana.rao@in.abb.com
To: pradysam@gmail.com, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:55065 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756212Ab0CXNWR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Mar 2010 09:22:17 -0400
In-Reply-To: <6d09081c1003240527r471ee34etbba11b4b7c7e92b3@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> We are dealing with an application that is a fairly heavy user of
> POSIX message queues. While running this application I seemed to have
> stumbled upon the fact that the timeout in the mq_timedrecieve is
> innaccurate to the tune of a more than 5-6 miliseconds and that it is
> fairly consistent even at its highest priority.
> 
> Cyclictest on the same machine gives me a max deviation of about 7uS,
> so I guess my timers (hrt) are functioning alright.
> 
> Here is a small program I hacked up from the LTP sources to
> demonstrate this behaviour (attached). I ran this on a dual core
> 2.5Ghz cpu and a uniprocessor 1.5Ghz cpu (cpuinfo below). On the
> dual-core I can see that its off by 1-2 miliseconds but on the 1.5 Ghz
> celeron its off by 6-8 miliseconds sometimes.
> 
> kernel version: 2.6.33.1-rt10
> 
> Usage: ./send_rev_2 <timeout_in_miliseconds>
> 
> $ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 13
> model name      : Intel(R) Celeron(R) M processor         1.50GHz
> stepping        : 8
> cpu MHz         : 1500.111
> cache size      : 1024 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov
> clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx up bts
> 
> Also attaached is my .config.
> 
> thanks in advance
> regards
> /prady
Does it help to run the posix threads with realtime priority by calling
pthread_setschedparam() with SCHED_FIFO and a suitable priority?
As fas as I understand your code, the threads run with standard (non realtime
priority).


Mathias



-- 
Mathias Koehrer
mathias_koehrer@arcor.de


Holt sich Schumi den 8. Titel seiner Formel-1-Karriere? Schumi reloaded, alle Infos, Fahrer- und Team-Portraits und das Formel-1-Experten-Quiz finden Sie hier: http://www.arcor.de/rd/footer.f1
