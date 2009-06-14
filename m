From: Iratxo Pichel Ortiz <iratxo.pichel@gmail.com>
Subject: Re: NOHZ: local_softirq_pending
Date: Sun, 14 Jun 2009 21:50:19 +0200
Message-ID: <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>
References: <4A35171C.9090800@albentia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Iratxo Pichel Ortiz <ipichel@albentia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:28069 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbZFNTuS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Jun 2009 15:50:18 -0400
Received: by fg-out-1718.google.com with SMTP id d23so271557fga.17
        for <linux-rt-users@vger.kernel.org>; Sun, 14 Jun 2009 12:50:19 -0700 (PDT)
In-Reply-To: <4A35171C.9090800@albentia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have some more info about this issue, just in case someone can lead
me to the light. I have changed my .config file, disabling hi-prec
timers and setting HZ to 1000. The problem seems to be gone until I
get a big load to the box. When I ping the board from my PC with a lot
of traffic, the hi-latency messages start again.

Thanks in advance!

    Iratxo.

On Sun, Jun 14, 2009 at 5:28 PM, Iratxo Pichel
Ortiz<ipichel@albentia.com> wrote:
> Hi there,
>
> I hope that someone in this list could help me trace down this issue =
I am
> seeing.
>
> I am using 2.6.30-rt16 RT Kernel on a IXP425 system. The system is ru=
nning
> an experimental comm stack that has been working quite well with 2.6.=
26-rt2
> for a very long time (> 100days).
>
> When the system boots, every 180s aprox, I see this traces in the dme=
sg:
> 42949422.930000] NOHZ: local_softirq_pending 02
> [42949422.940000] NOHZ: local_softirq_pending 02
> [42949422.950000] NOHZ: local_softirq_pending 02
> [42949422.960000] ISR HIHG LATENCY 30073
> [42949596.920000] NOHZ: local_softirq_pending 02
> [42949596.930000] NOHZ: local_softirq_pending 02
> [42949596.940000] NOHZ: local_softirq_pending 02
> [42949596.950000] NOHZ: local_softirq_pending 02
> [42949596.960000] ISR HIHG LATENCY 40066
>
> The "ISR HIGH LATENCY" is small latency measurement that I have done =
in the
> ISR function of the driver. Hw is ticking the system every 2.5ms and =
the
> usual run-time of the ISR handler is well under 200us. Every aprox
> 180seconds, suddenly this run-time get as high as 50ms.
>
> It is very highly probable that the problem is inside my driver, beca=
use if
> I dont load the modules, this "NOHZ..." trace is not shown. Anyway, I=
 would
> like to know if this "issue" is triggered by some known cause, or at =
least
> any idea where to start looking at.
>
> Please, CC me as I am not subscribed to the list.
>
> Thank you very much in advance and best regards!
>
> =A0 Iratxo.
>
>
> Another run:
> [ =A0 96.950000] NOHZ: local_softirq_pending 02
> [ =A0 96.960000] NOHZ: local_softirq_pending 02
> [ =A0 96.970000] NOHZ: local_softirq_pending 02
> [ =A0 97.000000] ISR HIGH LATENCY 50068
> [ =A0270.000000] ISR HIGH LATENCY 50048
> [ =A0463.000000] ISR HIGH LATENCY 50049
> [ =A0643.000000] ISR HIGH LATENCY 50047
>
> --
> Iratxo Pichel Ortiz
> Software Development Manager
>
> Albentia Systems S.A.
> http://www.albentia.com
>
> Tel: +34 914400567
> Cel: +34 663808405
> Fax: +34 914400569
>
> C\Margarita Salas 22
> Parque Tecnol=F3gico de Legan=E9s
> Legan=E9s (28918)
> Madrid
> Spain
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
