From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: cyclictest abstime vs. reltime
Date: Wed, 17 Dec 2014 15:16:50 -0500
Message-ID: <20141217151650.6ee5649c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Marcelo Tosatti <mtosatti@redhat.com>, williams@redhat.com,
	riel@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52574 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbaLQUQz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Dec 2014 15:16:55 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBHKGsGS009663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Wed, 17 Dec 2014 15:16:54 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

We're doing some scheduling latency measurements with KVM. While
analyzing some traces and reading cyclictest code in the process,
I found out that by default cyclictest uses the absolute time
algorithm, which basically does:

clock_gettime(&now)
next = now + interval   /* interval == 1000us */
/* do some quick stuff */
while() {
    clock_nanosleep(&next) /* ie. sleeps until now + 1000us, 'next' is abs */
    clock_gettime(&now)
    diff = calcdiff(now, next)
    /* update a bunch of stats and the histogram data, also
       check if we're finished */
    next += interval
}

Now, doesn't this mean that the timerthread will actually sleep less
than interval? This is so because we have fixed sleeping points which
don't take into consideration the sleeping latency nor the bunch of
things the timerthread does (eg. update histogram).

If I'm making sense, won't this behavior cause better numbers to be
reported?

I compared abstime and reltime in bare-metal, and got the following
results (cyclictest [-r] -m -n -q -p99 -l 1000000):

abstime mode:

# Min Latencies: 00001
# Avg Latencies: 00001
# Max Latencies: 00003

reltime mode:

# Min Latencies: 00003
# Avg Latencies: 00003
# Max Latencies: 00008

(Yes, this machine is pretty modern and well setup for RT. The results
above are pretty deterministic. Also, I've ran hwaltdetect for hours
and got no SMIs).

The relative time algorithm, on the other hand, is exactly what I expected
I would see when I looked at the code:

/* do some quick stuff */
while() {
    clock_getttime(&now)
    clock_nanosleep(&interval) /* interval == 1000us */
    expected = now + interval
    clock_getttime(&now)
    diff = calcdiff(now, expected);
    /* update a bunch of stats and the histogram data, also
       check if we're finished */
}

So, my question boils down to: is there a relevant difference between
the two modes? Why isn't reltime the default mode?
