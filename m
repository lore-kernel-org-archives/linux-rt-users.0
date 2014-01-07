From: Tim Sander <tim@krieglstein.org>
Subject: Re: 3.12.6-rt9 on AM335x (armv7)
Date: Tue, 07 Jan 2014 23:58:57 +0100
Message-ID: <10785809.PZUZGWPMgY@hydra>
References: <52C44448.3030405@ma-fu.de> <15611103.51LOkxSQt9@dabox> <52CC6F94.6070906@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Matthias Fuchs <mfuchs@ma-fu.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:41266
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753007AbaAGW5q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Jan 2014 17:57:46 -0500
In-Reply-To: <52CC6F94.6070906@ma-fu.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Matthias
> without hackbench and frieds (idle system) I get a max. latency of ab=
out
> 4ms. Running hackbench (default arguments, -l 1000), it  still increa=
ses up
> to 5ms:
>=20
> ...
> # Total: 000000193
> # Min Latencies: 00024
> # Avg Latencies: 00205
> # Max Latencies: 05058
> ...
>=20
> The obvious PM stuff is disabled. No dynamic frequency scaling, etc.
> Really weired stuff. I already mentioned the 3.2 system with the same=
 CPU in
> the OSADL lab. It comes with max. latency of 118us. So I really expec=
t
> something similiar.
Yeah 118 =B5s should be the right ballpark, while still a little high f=
or my=20
taste. All cortex a8 seem to have rather high latency. The A9's seem mu=
ch=20
better in this respect.

Have you seen the following:
https://www.osadl.org/Realtime-Preempt-Kernel.kernel-rt.0.html#latencyf=
ighting

Cyclictest has tracing support which might help finding the cause of th=
e long=20
latency.=20

Best regards
Tim
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
