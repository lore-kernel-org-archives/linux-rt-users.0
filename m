From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH 1/2] RFC cyclictest: clean up --latency ordering in getopt
Date: Mon, 7 May 2012 21:30:59 -0300
Message-ID: <20120508003059.GH5429@uudg.org>
References: <4FA841B4.20701@am.sony.com>
 <4FA842F3.60204@am.sony.com>
 <4FA845F1.4080205@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57620 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab2EHAf0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2012 20:35:26 -0400
Received: by pbbrp8 with SMTP id rp8so7331678pbb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 07 May 2012 17:35:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA845F1.4080205@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, May 07, 2012 at 03:00:17PM -0700, Frank Rowand wrote:
| This is the resulting message on the ARM panda with a 'bad'
| 32khz timer:
| 
| 
|   # cyclictest -q -p 80 -t -n -l 10 -h ${hist_bins} -R 100
|   reported clock resolution: 1 nsec
|   measured clock resolution less than: 30517 nsec

How about using a fixed loop size (say 1000000 clock reads) to define
the average cost of reading the clock (the second value presented above)
instead of a variable amount of iterations? Reading the clock twice and
calculating the average could lead to wrong impressions. Also, it would
be interesting to run such test under a real time priority (FIFO:2, maybe?)
to avoid too much external interference on the readings, mainly involuntary
context switches.

Having too different values called 'clock resolution' may be a good source
of confusion. The value of clock_getres() is the resolution, as per the
system jargon, and the second value should be granularity, reading cost,
the-average-time-it-takes-to-read-the-clock or something alike.
 
| A possible follow on patch would be to generate a hard
| error (fail the test) if the measured resolution was
| above some unreasonable value (perhaps > 1 msec), but
| allow the hard fail to be overridden with yet another
| command line option.  Any opinions about that?

My suggestion is to keep the current behavior and add an option to
stop/complain case the clock has a poor resolution or has a reading
cost too high.

Luis
-- 
[ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

