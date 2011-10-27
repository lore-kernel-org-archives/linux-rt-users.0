From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: Latency problem
Date: Thu, 27 Oct 2011 15:03:48 -0400
Message-ID: <CAE_Gge3nBE4_Jm39qnVz_6ieBpJL6b9qNd41snW=6bi9cggm3g@mail.gmail.com>
References: <CAE_Gge02PZyZ93wSyH8uSJAQ6wdZRqG-L-qumV23g4Tam7BUmQ@mail.gmail.com>
 <1319741477.6197.26.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44219 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab1J0TEI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Oct 2011 15:04:08 -0400
Received: by gyb13 with SMTP id 13so2936395gyb.19
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Oct 2011 12:04:08 -0700 (PDT)
In-Reply-To: <1319741477.6197.26.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> You don't give any info wrt what kind of box this is, how you ran
> cyclictest, what load it was competing against, nada. =A0With the inf=
o
> provided, nobody can say much.
>
> It _looks_ like you must have just called up cyclictest using all
> defaults, which doesn't even start cyclictest as a realtime class tas=
k,
> meaning you'll see worst case latencies for SCHED_OTHER tasks, which =
has
> nothing to do with realtime class scheduling latencies.
>
> Latencies in the 40us range are pretty normal for my el-cheapo Q6600
> desktop grade box trying to save power and sucking rocks at it, but m=
s
> latencies I never see with remotely sane loads.
>
> =A0 =A0 =A0 =A0-Mike
>

Hello Mike,

You're right, but the problem is that I tried running cyclictest with
many different parameters to see if it was working (-S, -p95, etc..).
I also tried to disable some CPU hearts to see with just one active
heart if the problem still was here. But like I said, the test was
returning this bad results ONLY over this hardware ! I tried with the
same distribution, in the same conditions, and with the same tests on
other computers with different hardware (software wasn't different as
I used an external SDD to boot on debian), and it worked fine. I
agree... ms latencies is very weird...

The load of the system was different each time, but the results were
the same : I tried in single user mode, I tried with X server loaded,
under a X server terminal, etc. etc.
Moreover, the use of hwlatdetect seems to confirm that the problem is
from hardware.

Another test that we tried to do is to activate idle=3Dpoll at the boot
in grub, and to trace the cyclictest. In the traces, we can see a gap
of more or less 35ms.

I'm pretty sure the problem is linked to hardware. But if you have an
idea of parameters I can use with cyclictest to have better results,
please let me know !

Thank you !
Rapha=EBl
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
