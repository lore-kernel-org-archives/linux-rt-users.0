From: Robin Gareus <robin@gareus.org>
Subject: Re: 2.6.3x-rty where x > 3 and y >= 1?
Date: Thu, 25 Nov 2010 01:29:52 +0100
Message-ID: <4CEDAE00.1050800@gareus.org>
References: <4CDAF425.4050800@ccrma.stanford.edu>	 <alpine.LFD.2.00.1011102154330.2900@localhost6.localdomain6>	 <4CDC0429.8090506@gmail.com> <1289515742.14141.0.camel@localhost.localdomain> <4CE6E9B2.1040005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ng Oon-Ee <ngoonee@gmail.com>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel James <daniel@64studio.com>,
	Free Ekanayaka <free.ekanayaka@canonical.com>
To: =?ISO-8859-9?Q?Niccol=F2_Belli?= <darkbasic4@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:11523 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab0KYAcE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Nov 2010 19:32:04 -0500
In-Reply-To: <4CE6E9B2.1040005@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/19/10 22:18, Niccol=F2 Belli wrote:
> Il 11/11/2010 23:49, Ng Oon-Ee ha scritto:
>>> Glad to hear that, I can't use 2.6.33-rt anymore because of problem=
s
>>> with my intel video card and my band is starting to blame because o=
f xruns.
>>>
>>> Darkbasic
>>
>> In the meantime, the -bfs kernel does improve the situation somewhat=
=2E
>=20
> I just compiled 2.6.36-bfs, but unfortunately alsa git does not compi=
le
> against it (I need alsa git because of M-Audio Fast Track Ultra suppo=
rt).
>=20
Don't worry. It's not worth the hype it generated. I'm just back from
rolling a new kernel for 64studio. I tried a couple of candidates
including -bfs.

2.6.33.7-rt29 is _by far_ the best option for low-latency audio.
Well, actually it's the only option (not counting older rt-linux
releases) which provides reliable <=3D4 ms latency (16 or 32 audio-fram=
es
per period) without any x-runs!

Vanilla 2.6.36 and -bfs kernel both perform quite well. If >=3D15 ms
latency is sufficient for your use-case and you can live with some
occasional x-run that is.

I'm looking forward to a new -rt patch.

Cheers!
robin

PS. Note that sound latency here is not calculated (eg. 32*2/48kHz) but
measured with jack_delay from http://www.kokkinizita.net/linuxaudio/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
