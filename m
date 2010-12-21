From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: A couple of Questions about the RT Patch
Date: Tue, 21 Dec 2010 17:00:51 +0100
Message-ID: <4D10CF33.5030808@osadl.org>
References: <AANLkTinUpZGFB8YijVkFMfScwf8rARG8Rikx+NQBbUtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT-Users <linux-rt-users@vger.kernel.org>
To: David Peverley <pev@sketchymonkey.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:34912 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240Ab0LUREZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Dec 2010 12:04:25 -0500
In-Reply-To: <AANLkTinUpZGFB8YijVkFMfScwf8rARG8Rikx+NQBbUtA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

David,

> [..]
> As I understand it, the different kernel releases of the patch are
> sequential as opposed to parallel, i.e. the newer patches on new
> kernels such as the just announced 2.6.33.7-rt29 [..]
2.6.33.7.2-rt30
> [..] supersede the
> earlier releases and changes don't get back-ported top earlier
> kernels.
That's correct.

> As we don't have the option to update the kernel revision to
> keep in sync with the later RT patches, can anyone tell me if we
> should be considering evaluating changes from later patches to
> back-port
In general, there is no reason to move on to a newer kernel, if
everything is working fine.

> I've also wanted to look into doing some tests to see how this
> platform performs. I've built the RT-Tests package and run hackbench
> and cyclictest on my board but I'm not sure how to evaluate the
> results I'm seeing! It seems to me that most documents I've read
> evaluate the results by comparing to someone elses baseline results
Hmm, not really. You normally evaluate your result against the longest
acceptable latency (aka deadline) that is part of your system's
specification.

In practice, you may run cyclictest under the typical load of your
system. BTW: I don't think that hackbench creates an "adequate" load.
Ingo wrote it during the development of the 2.6 scheduler in order to
investigate scheduler-induced latencies by creating an abnormally high
load (that normally never occurs). There are, however, a lot more
sources of latency that should be considered.

You normally specify the cycle time of your project as interval and run
cyclictest for several days, e.g.
  # cyclictest -m -n -p99 -i200 -l1000000000
will take about 56 hours to finish. You then check the worst-case
latency after "Max:" on the right of the output line. This is your
result. If, for example, your project requires that the system never
takes longer than 200 =B5s to react in user space to an asynchronously
arriving external event and cyclictest gives a worst-case latency of 12=
0
=B5s, then there is a reasonable probability that your system is okay.
This requires, of course, that realistic conditions of the production
system have been created.

If you would like to compare your results against reference values, you
may wish to visit the OSADL QA farm [1]. The more than 20 systems of th=
e
farm are running repeated tests of cyclictest under idle and load
conditions. The resulting latency plots are made available online.

In addition, you may enable kernel built-in latency histograms for
long-term continuous worst-case latency monitoring [2]. These histogram=
s
only have a minimal penalty on performance and real-time capabilities -
but they provide an insight into the system's real-time characteristics
under production conditions. There is no longer any need for cyclictest
runs and artificial load generation. The OSADL QA farm continuously
displays such latency recordings of the test systems.


Thanks,

        Carsten.



[1] https://www.osadl.org/QA
[2]
https://www.osadl.org/fileadmin/dam/articles/Long-term-latency-monitori=
ng.pdf
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
