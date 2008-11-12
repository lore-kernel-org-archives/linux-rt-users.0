From: Amir Aharon <amira@waves.com>
Subject: config_preempt_RT patch platform support question.
Date: Wed, 12 Nov 2008 09:30:45 -0500
Message-ID: <A58BC43ACBDDA54393A506C9A68AB8B402F8EB14DD@maxx.waves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from maxx.waves.com ([12.34.136.4]:12472 "EHLO maxx.waves.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbYKLOaq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Nov 2008 09:30:46 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,
I work on a project which delivers low latency audio streaming via a Linux machine. I receive/send audio frames of 4 samples each per network frame (raw Ethernet) so I expect to have a network interrupt each 90 microseconds.
I use Linux 2.6.26.3-rt7 on different platforms; unfortunately we encountered problems such as kernel panics, depend on the platform running...

My questions are:
How can I have more details on the tests which where used to evaluate the platform running the config_preempt_RT (specifically on networking issues)? 
Does Intel Q6600 2.4GHz (quad core) has been tested? Are there known issues?
Does Xeon x5482 3.2GHz (x2 meaning octa core) has been tested? Are there known issues?


Thanks,
Amir.
