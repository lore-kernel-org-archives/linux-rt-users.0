From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH 1/2] RFC cyclictest: clean up --latency ordering in getopt
Date: Mon, 7 May 2012 19:05:23 -0700
Message-ID: <4FA87F63.2090701@am.sony.com>
References: <4FA841B4.20701@am.sony.com> <4FA842F3.60204@am.sony.com> <4FA845F1.4080205@am.sony.com> <20120508003059.GH5429@uudg.org>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:33682
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758044Ab2EHCF5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2012 22:05:57 -0400
In-Reply-To: <20120508003059.GH5429@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/07/12 17:30, Luis Claudio R. Goncalves wrote:
> On Mon, May 07, 2012 at 03:00:17PM -0700, Frank Rowand wrote:
> | This is the resulting message on the ARM panda with a 'bad'
> | 32khz timer:
> | 
> | 
> |   # cyclictest -q -p 80 -t -n -l 10 -h ${hist_bins} -R 100
> |   reported clock resolution: 1 nsec
> |   measured clock resolution less than: 30517 nsec
> 
> How about using a fixed loop size (say 1000000 clock reads) to define
> the average cost of reading the clock (the second value presented above)
> instead of a variable amount of iterations? Reading the clock twice and
> calculating the average could lead to wrong impressions. Also, it would
> be interesting to run such test under a real time priority (FIFO:2, maybe?)
> to avoid too much external interference on the readings, mainly involuntary
> context switches.
> 
> Having too different values called 'clock resolution' may be a good source
> of confusion. The value of clock_getres() is the resolution, as per the
> system jargon, and the second value should be granularity, reading cost,
> the-average-time-it-takes-to-read-the-clock or something alike.

The 'measured clock resolution' is not intended to be representative of the
time it takes for clock_gettime() to execute.  It really is a measure of
the resolution that the clock is actually delivering.  It is the smallest
amount that the actual clock actually increments.

Look at the patch again:
If consecutive calls to clock_gettime() return the same value, then the
clock resolution is larger than the execution time of clock_gettime().
If this is the case, then when the clock moves to a new value, the
difference from the old value is representative of the clock resolution.

The patch calls clock_gettime() a number of times in a loop, collecting
timestamps.  The timestamps are then scanned, looking for:

  1) does a difference of zero occur?
  2) what is the minimum non-zero difference?

If a difference of zero is found, then the clock resolution is larger
than the execution time of clock_gettime().  If this resolution is
_also_ greater than the resolution that the clock claims from
clock_getres(), then this is reported.

Reporting the minimum non-zero difference is being generous.
Saying that the measured resolution is "less than" is also
being generous.  What can I say, I'm trying to be optimistic? :-)

This might be more obvious if I show you the actual clock_gettime()
values from a run on an ARM panda:

   # cyclictest -q -p 80 --smp -l 1 -R 50 -v
   
   
   For consecutive calls to clock_gettime():
   
   time, delta time (nsec)
   
   8720.940737610  0
   8720.940737610  0
   8720.940737610  0
   8720.940737610  0
   8720.940737610  0
   8720.940737610  0
   8720.940737610  0
   8720.940768124  30514
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940768124  0
   8720.940798638  30514
   8720.940798638  0
   8720.940798638  0
   reported clock resolution: 1 nsec
   measured clock resolution less than: 30514 nsec


>  
> | A possible follow on patch would be to generate a hard
> | error (fail the test) if the measured resolution was
> | above some unreasonable value (perhaps > 1 msec), but
> | allow the hard fail to be overridden with yet another
> | command line option.  Any opinions about that?
> 
> My suggestion is to keep the current behavior and add an option to
> stop/complain case the clock has a poor resolution or has a reading
> cost too high.
> 
> Luis


