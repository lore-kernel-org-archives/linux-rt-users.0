From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: config_preempt_RT patch platform support question.
Date: Thu, 13 Nov 2008 08:41:49 +0100
Message-ID: <491BDA3D.8040904@osadl.org>
References: <A58BC43ACBDDA54393A506C9A68AB8B402F8EB14DD@maxx.waves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: RT-Users <linux-rt-users@vger.kernel.org>
To: Amir Aharon <amira@waves.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:59567 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbYKMIBy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Nov 2008 03:01:54 -0500
In-Reply-To: <A58BC43ACBDDA54393A506C9A68AB8B402F8EB14DD@maxx.waves.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Amir,

> I work on a project which delivers low latency audio streaming via a
> Linux machine. I receive/send audio frames of 4 samples each per
> network frame (raw Ethernet) so I expect to have a network interrupt
> each 90 microseconds. I use Linux 2.6.26.3-rt7 on different
> platforms; unfortunately we encountered problems such as kernel
> panics, depend on the platform running...
The PREEMPT_RT patches for kernel 2.6.26 are still under development.
Please post the various kernel messages you are observing. BTW: The most
recent 2.6.26 patch is 2.6.26.6-rt11.

> My questions are: How can I have more details on the tests which
> where used to evaluate the platform running the config_preempt_RT
> (specifically on networking issues)? Does Intel Q6600 2.4GHz (quad
> core) has been tested? Are there known issues? Does Xeon x5482 3.2GHz
> (x2 meaning octa core) has been tested? Are there known issues?
For the time being, linux-2.6.24.7-rt21 is believed to be stable and
ready for production. This version has been tested heavily under x86
(slow/fast machines, single/dual/quad core, 32/64 bit) and under various
PPC platforms. It has been tested less heavily on ARMs and MIPSes. There
are no known issues on x86 platforms. Would you mind to run
2.6.24.7-rt21 on your machines?

	Carsten.
