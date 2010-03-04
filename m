From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Disabling lapic timer for a certain core
Date: Thu, 4 Mar 2010 11:04:53 -0300
Message-ID: <20100304140453.GX2553@uudg.org>
References: <14900780.1267705793289.JavaMail.ngmail@webmail16.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40945 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0CDOFE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Mar 2010 09:05:04 -0500
Received: by vws9 with SMTP id 9so1236696vws.19
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Mar 2010 06:05:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <14900780.1267705793289.JavaMail.ngmail@webmail16.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Mar 04, 2010 at 01:29:53PM +0100, M. Koehrer wrote:
| Hi all!
|=20
| I am running the RT_PREEMPT kernel 2.6.31.2-rt13 on a Intel Quad Core=
 CPU.
| I start my kernel with isolcpus=3D1-7 option to force all processes t=
o run on CPU core 0 only.
| Now we have the need for a very fast loop. Within this loop some acce=
sses from/to a PCIe I/O board
| (mapped in user space) and some additional computation has to be done=
=2E
| For this, I use a real time thread, run this on CPU core 3 and let it=
 run in an endless polling loop.
| So far everything works fine.
| This thread is the only running user mode thread on CPU core 3.
| However, we measure some run time jitters when accessing the I/O boar=
d in the range of up to=20
| 15 microseconds which are not tolerable by the application.
| I see that on all cores the "Local Timer Interrupt" occurs 100 times =
a
| second (of course this is the timer frequency select in the kernel co=
nfiguration).

Are CPU0 and CPU3 on the same socket? Are you using a SMP or a NUMA box=
? I
would suggest running your application in a CPU on a different socket j=
ust
to ensure you are not having any cache issues.

Have you tried running hwlat_detect or smi-test? Your 15us threshold is=
 pretty
tight and could easilly be affected by SMI spikes (if present in your
system).

Luis

| My question is now:
| Is it possible to disable the "Local Timer Interrupt" for core 3 as i=
t is actually not required here?
| I want to use the full 100% CPU core time for this single loop.
|=20
| Any help or ideas are welcome!
|=20
| Thanks a lot.
|=20
| Regards
|=20
| Mathias
|=20
| --=20
| Mathias Koehrer
| mathias_koehrer@arcor.de
|=20
|=20
| Tolle Dekollet=E9s oder scharfe Tatoos? Vote jetzt ... oder mach selb=
st mit und zeige Deine Schokoladenseite
| bei Topp oder Hopp von Arcor: http://www.arcor.de/rd/footer.toh
| --
| To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---

--=20
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
