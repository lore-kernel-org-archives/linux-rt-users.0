From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH 1/2] RFC cyclictest: clean up --latency ordering in getopt
Date: Tue, 8 May 2012 10:53:26 -0300
Message-ID: <20120508135326.GA5051@uudg.org>
References: <4FA841B4.20701@am.sony.com>
 <4FA842F3.60204@am.sony.com>
 <4FA845F1.4080205@am.sony.com>
 <20120508003059.GH5429@uudg.org>
 <4FA87F63.2090701@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43179 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab2EHNxc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 May 2012 09:53:32 -0400
Received: by pbbrp8 with SMTP id rp8so8070291pbb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 08 May 2012 06:53:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA87F63.2090701@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, May 07, 2012 at 07:05:23PM -0700, Frank Rowand wrote:
| On 05/07/12 17:30, Luis Claudio R. Goncalves wrote:
| > On Mon, May 07, 2012 at 03:00:17PM -0700, Frank Rowand wrote:
| > | This is the resulting message on the ARM panda with a 'bad'
| > | 32khz timer:
| > | 
| > | 
| > |   # cyclictest -q -p 80 -t -n -l 10 -h ${hist_bins} -R 100
| > |   reported clock resolution: 1 nsec
| > |   measured clock resolution less than: 30517 nsec
| > 
| > How about using a fixed loop size (say 1000000 clock reads) to define
| > the average cost of reading the clock (the second value presented above)
| > instead of a variable amount of iterations? Reading the clock twice and
| > calculating the average could lead to wrong impressions. Also, it would
| > be interesting to run such test under a real time priority (FIFO:2, maybe?)
| > to avoid too much external interference on the readings, mainly involuntary
| > context switches.
| > 
| > Having too different values called 'clock resolution' may be a good source
| > of confusion. The value of clock_getres() is the resolution, as per the
| > system jargon, and the second value should be granularity, reading cost,
| > the-average-time-it-takes-to-read-the-clock or something alike.
| 
| The 'measured clock resolution' is not intended to be representative of the
| time it takes for clock_gettime() to execute.  It really is a measure of
| the resolution that the clock is actually delivering.  It is the smallest
| amount that the actual clock actually increments.

Sorry, I read your patch 'upside-down' and I was not considering the
possibility of clock_getres() returning a totally bogus value. Wouldn't
that be the case to fix the resolution information for this clocksource
in the kernel?

How about running your test for a fixed amount of time? 250ms sounds like a
safe amount of time and if the readings do not change in 250ms you surely
have a problem with the clock. A configurable amount of repetitions may
lead to wrong results... if you are locky enough to have the clock valu
changing right in th middle of you 10x loop, you may see latencies later
that are just fruit of the unreliable clock.

You could also, when reporting the findings about the clock resolution,
that said resolution could mask latencies as big as it. Or induce in the
results latencies as big as it.

Anyway, nice patch.

Cheers,
Luis
-- 
[ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

