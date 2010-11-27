From: =?ISO-8859-9?Q?Niccol=F2_Belli?= <darkbasic4@gmail.com>
Subject: Re: 2.6.3x-rty where x > 3 and y >= 1?
Date: Sat, 27 Nov 2010 18:20:00 +0100
Message-ID: <4CF13DC0.8080109@gmail.com>
References: <4CDAF425.4050800@ccrma.stanford.edu>	 <alpine.LFD.2.00.1011102154330.2900@localhost6.localdomain6>	 <4CDC0429.8090506@gmail.com> <1289515742.14141.0.camel@localhost.localdomain> <4CE6E9B2.1040005@gmail.com> <4CEDAE00.1050800@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: 7bit
Cc: Ng Oon-Ee <ngoonee@gmail.com>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel James <daniel@64studio.com>,
	Free Ekanayaka <free.ekanayaka@canonical.com>
To: Robin Gareus <robin@gareus.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33028 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab0K0RUI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Nov 2010 12:20:08 -0500
Received: by wyb28 with SMTP id 28so2976065wyb.19
        for <linux-rt-users@vger.kernel.org>; Sat, 27 Nov 2010 09:20:07 -0800 (PST)
In-Reply-To: <4CEDAE00.1050800@gareus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Il 25/11/2010 01:29, Robin Gareus ha scritto:
> Don't worry. It's not worth the hype it generated. I'm just back from
> rolling a new kernel for 64studio. I tried a couple of candidates
> including -bfs.
> 
> 2.6.33.7-rt29 is _by far_ the best option for low-latency audio.
> Well, actually it's the only option (not counting older rt-linux
> releases) which provides reliable <=4 ms latency (16 or 32 audio-frames
> per period) without any x-runs!

I agree: I patched alsa git to make it compile but I didn't notice any
major improvement with -bfs :-(

I hope the next -rt kernel will be released soon, otherwise I fear I
will crash my laptop next time I hear "what about buying a Mac?" .-.

Darkbasic
