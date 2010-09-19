From: jordan <triplesquarednine@gmail.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Sun, 19 Sep 2010 13:23:20 -0400
Message-ID: <AANLkTimgte_c6rC=okyH9Oo-NSOERqAPeOHyyd1BoWvG@mail.gmail.com>
References: <4C92A00C.6050401@atl.lmco.com>
	<AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
	<AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
	<4C936152.5000505@64studio.com>
	<AANLkTint6iHc6DPeEVpKd0ER0XsYMDK=0yiekHGkWtWF@mail.gmail.com>
	<20100919104916.63967cc4@riff>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Daniel James <daniel@64studio.com>, John Kacur <jkacur@redhat.com>,
	Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38927 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab0ISRXV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Sep 2010 13:23:21 -0400
Received: by ewy23 with SMTP id 23so1397941ewy.19
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Sep 2010 10:23:20 -0700 (PDT)
In-Reply-To: <20100919104916.63967cc4@riff>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Clark,

> I'll second this sentiment. We were going to to release a new realtime
> kernel with the .31 series, but testing showed that it had some
> significant regressions in terms of event response time and in overall
> throughput, so we held off. The .33 series is much better in those
> regards and that's what we'll be going out with in our next release.

Ya, i liked .33 - it would be a great choice. There were a lot of
perfromance gains in that kernel... Recently, i have changed laptops
(my good one died). Unfortunately, this laptop i am using now has
buggy hardware. But i am stuck with it, until my next machine is
built...

I actually, am having to use BFS and BFQ and avoid rtirq, etc.  I've
had to take a totally different method to get smooth, reliable audio
performance (at low latency). But all my work has paid, and my system
is quite robust. im using 2.6.34 optimized like crazy. I've been
impressed though, as the system never has problems, even with it's
inherent issues, and under significant CPU-load. Even, though my
method seems to work perfect, and is actually simple to use. I am
looking forward to when i can finish building my new rackmount, and
get back to the standard way of doing things.

> Heh. I haven't actually compiled a kernel on stage, but a friend of
> mine reworked a play's audio track 20 minutes before curtain when the
> Windows box ate it's disk; he booted up his Linux laptop and ran the
> sound sequencer program in a QEMU instance. I think I'd rather rebuild
> a kernel under the gun :).

That's why i use linux live, Windows is scary for that purpose. * I
would much rather compile the kernel under pressure. it only takes
10minutes! *
Using Linux, I am still able to use lots of windows VSTi (NI
Komplete) coupled with linux apps. It works perfectly.
Even on a junker dell inspiron 6400 (e1505), coreduo 1.6ghz, 1gig ram.
 I am able to run somewhere around 8-12 Vst instruments (big ones
too), sooperlooper, FX chains, live audio-inputs (mic and guitar),
all @ 128 frames in jack, and i never have issues. When i did try to
use Windows live, i ran into problems. High latency, crashing, etc.
Even with my Macbook that died, i'd run into the similar issues. (when
using Mac OS anyway).

Linux seems to work nicely, even on junk "craptops"   It'll be funny
to see how the new rack will perform!

jordan
