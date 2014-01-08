From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: Re: 3.12.6-rt9 on AM335x (armv7)
Date: Wed, 08 Jan 2014 09:08:52 +0100
Message-ID: <52CD0794.8030009@ma-fu.de>
References: <52C44448.3030405@ma-fu.de> <15611103.51LOkxSQt9@dabox> <52CC6F94.6070906@ma-fu.de> <10785809.PZUZGWPMgY@hydra> <52CC91E9.7070808@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: pavel@pavlinux.ru, Tim Sander <tim@krieglstein.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:52785 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbaAHIIs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Jan 2014 03:08:48 -0500
In-Reply-To: <52CC91E9.7070808@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hmm, on Intel it might be an SMI-Issue.

Matthias

On 08.01.2014 00:46, Pavel Vasilyev wrote:
> 08.01.2014 02:58, Tim Sander =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>> Yeah 118 =C2=B5s should be the right ballpark, while still a little =
high for my=20
>> taste. All cortex a8 seem to have rather high latency. The A9's seem=
 much=20
>> better in this respect.
>=20
> On my Intel Atom D425, latency around 25-30 =C2=B5s (but peaks upto 5=
000 =C2=B5s :/ )
>=20
>>
>> Have you seen the following:
>> https://www.osadl.org/Realtime-Preempt-Kernel.kernel-rt.0.html#laten=
cyfighting
>>
>> Cyclictest has tracing support which might help finding the cause of=
 the long=20
>> latency.=20
>>
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
