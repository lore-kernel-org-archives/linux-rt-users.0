From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: clock_nanosleep and NTP drift correction
Date: Thu, 13 Sep 2012 17:33:42 +0200
Message-ID: <5051FCD6.7060004@drcomp.erfurt.thur.de>
References: <F9467A784CC48947B1D879F07370839E0EBB712C@fe20099s.ecn.etasgroup.com> <20120913120922.GA5341@uudg.org> <5051FA33.7050205@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ltw.loris.tv ([188.40.101.23]:47517 "EHLO ltw.loris.tv"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab2IMPdq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Sep 2012 11:33:46 -0400
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 8C1E061A3C
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Sep 2012 17:33:43 +0200 (CEST)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IyEL2EP16I9w for <linux-rt-users@vger.kernel.org>;
	Thu, 13 Sep 2012 17:33:42 +0200 (CEST)
Received: from [IPv6:2001:638:906:2:e269:95ff:fe88:796b] (foh.inf-ra.uni-jena.de [IPv6:2001:638:906:2:e269:95ff:fe88:796b])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ltw.loris.tv (Postfix) with ESMTPSA id CAAF961A25
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Sep 2012 17:33:42 +0200 (CEST)
In-Reply-To: <5051FA33.7050205@drcomp.erfurt.thur.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/13/2012 05:22 PM, Adrian Knoth wrote:

>     {\scshape clock name}& {\scshape posix}& {\scshape set}& {\scshape
> adjust}&
> {\scshape jump} &
> {\scshape slew}\\
>     \midrule
> \texttt{CLOCK_REALTIME}& yes& yes& yes& yes& yes\\
> \texttt{CLOCK_MONOTONIC}& yes& no& yes& no& yes\\
> \texttt{CLOCK_MONOTONIC_RAW}& no& no& no& no& no\\
> \texttt{CLOCK_PROCESS_CPUTIME_ID}& yes& no& no& SMP& no\\
> \texttt{CLOCK_THREAD_CPUTIME_ID}& yes& no& no& SMP& no\\

For the sake of completeness, let me add that it's not possible to
clock_nanosleep() on CLOCK_MONOTONIC_RAW.

We recently came across this problem in FFADO, so maybe having this
information available saves some time for somebody. Further reading:

   http://subversion.ffado.org/ticket/242


Cheers
