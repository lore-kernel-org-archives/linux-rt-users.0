From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: mq_timedrecieve timeout accuracy
Date: Wed, 24 Mar 2010 18:51:25 +0530
Message-ID: <921ca19c1003240621k226df80ct62b3fb2e26269eca@mail.gmail.com>
References: <6d09081c1003240527r471ee34etbba11b4b7c7e92b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, rachana.rao@in.abb.com
To: Pradyumna Sampath <pradysam@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47338 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210Ab0CXNV0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Mar 2010 09:21:26 -0400
Received: by pwi5 with SMTP id 5so3897512pwi.19
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Mar 2010 06:21:25 -0700 (PDT)
In-Reply-To: <6d09081c1003240527r471ee34etbba11b4b7c7e92b3@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> stumbled upon the fact that the timeout in the mq_timedrecieve is
> innaccurate to the tune of a more than 5-6 miliseconds and that it is
> fairly consistent even at its highest priority.

OK.

>
> Cyclictest on the same machine gives me a max deviation of about 7uS,
> so I guess my timers (hrt) are functioning alright.

Out of how much? What is the range of the timer.

> Here is a small program I hacked up from the LTP sources to
> demonstrate this behaviour (attached). I ran this on a dual core
> 2.5Ghz cpu and a uniprocessor 1.5Ghz cpu (cpuinfo below). On the
> dual-core I can see that its off by 1-2 miliseconds but on the 1.5 Gh=
z
> celeron its off by 6-8 miliseconds sometimes.

Yes, but the cyclic test doesnot match with this result. Both are in
the negative.
How have you tested the patch.

>
> kernel version: 2.6.33.1-rt10
>
> Usage: ./send_rev_2 <timeout_in_miliseconds>
>
> $ cat /proc/cpuinfo
> processor =A0 =A0 =A0 : 0
> vendor_id =A0 =A0 =A0 : GenuineIntel
> cpu family =A0 =A0 =A0: 6
> model =A0 =A0 =A0 =A0 =A0 : 13
> model name =A0 =A0 =A0: Intel(R) Celeron(R) M processor =A0 =A0 =A0 =A0=
 1.50GHz
> stepping =A0 =A0 =A0 =A0: 8
> cpu MHz =A0 =A0 =A0 =A0 : 1500.111
> cache size =A0 =A0 =A0: 1024 KB
> fdiv_bug =A0 =A0 =A0 =A0: no
> hlt_bug =A0 =A0 =A0 =A0 : no
> f00f_bug =A0 =A0 =A0 =A0: no
> coma_bug =A0 =A0 =A0 =A0: no
> fpu =A0 =A0 =A0 =A0 =A0 =A0 : yes
> fpu_exception =A0 : yes
> cpuid level =A0 =A0 : 2
> wp =A0 =A0 =A0 =A0 =A0 =A0 =A0: yes
> flags =A0 =A0 =A0 =A0 =A0 : fpu vme de pse tsc msr pae mce cx8 apic s=
ep mtrr pge mca cmov
> clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx up bts
>
> Also attaached is my .config.
>
> thanks in advance
> regards
> /prady
>
>
> --
> http://www.prady.in
>



--=20
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
