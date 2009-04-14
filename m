From: Suresh Kumar SHUKLA <suresh.shukla@st.com>
Subject: RE: Measuring timer interrupt latency
Date: Tue, 14 Apr 2009 09:26:55 +0530
Message-ID: <000001c9bcb5$11d64f90$3f52c70a@dlh.st.com>
References: <20090413091405.380e42f8@torg>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'rt-users'" <linux-rt-users@vger.kernel.org>
To: "'Clark Williams'" <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:40370 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751697AbZDND43 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Apr 2009 23:56:29 -0400
In-Reply-To: <20090413091405.380e42f8@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Clark,

I already captured cyclictest (0.34) results. Thanks for new version info.

It would be  interesting to see the benefits of RT patch in ISR latency (#1)
scenarios. 
Tim Sander's LMM seems perfectly suitable for this.

regards,
Suresh

-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org
[mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Clark Williams
Sent: Monday, April 13, 2009 7:44 PM
To: Suresh Kumar SHUKLA
Cc: 'rt-users'
Subject: Re: Measuring timer interrupt latency

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 13 Apr 2009 12:14:42 +0530
Suresh Kumar SHUKLA <suresh.shukla@st.com> wrote:

> Hi,
> 
> I want to profile the improvements in interrupt latency with and 
> without RT patches.
> 
> The approach I have in mind is that time gap between IRQ firing and 
> IRQ handler reading value of counter would be sufficient to reveal the 
> interrupt latency. These values can be analysed for min/max/avg.
> 
> Is there any test program which captures interrupt latency (for x86) ? 
> I checked realfeel but it is user mode program and am not sure of its 
> accuracy.
> 
> regards,
> Suresh
> 

Have you tried cyclictest? It's part of the rt-tests package that Thomas
Gleixner wrote and that I now maintain. 

You can pick up the latest tarball here:

http://www.kernel.org/pub/linux//kernel/people/clrkwllms/rt-tests/rt-tests-0
.35.tar.bz2

The thing is, I'm not sure how useful measuring the interval between
interrupt and ISR. It's such a small component of the total latency value
that it usually gets lost in the noise. Cyclictest measures the time between
a timer fires and when the user-space program (cyclictest) actually gets to
run after a sleep, which is the entire latency value.
What you're talking about measuring on RT is basically a lookup and
schedule() call, since all interrupts have threaded handlers on RT.

If you are wanting to decompose the latency into it's components on RT, I
think you'd have:

	1. ISR latency
	2. Scheduler latency for IRQ thread
	3. IRQ handler time
	4. Scheduler latency for user-space thread

Cyclictest measures the aggregate of all these. 

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEARECAAYFAknjSLEACgkQHyuj/+TTEp1kuACfSi13WaRt6nZDc53LXWqSsbsK
Tv0AoJHpeXAjOkCPu5yBMElNDMr3Ij0y
=5LIa
-----END PGP SIGNATURE-----
N
'2flr8yzhXb2X,6G'vX^)^:{.nG+	7%
{1.[,z;"
X^n r!v&zKkh(h-Z&"x
.G+
ih.(-i ]"j"
z6m'ojdz9^
`~f#"7h'~m

