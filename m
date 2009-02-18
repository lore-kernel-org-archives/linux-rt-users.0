From: Sujit Karataparambil <sjt.kar@gmail.com>
Subject: Fwd: info softirq
Date: Wed, 18 Feb 2009 18:13:28 +0530
Message-ID: <921ca19c0902180443g30d500c0u3a3613556d0dc166@mail.gmail.com>
References: <30047d300902180147s1bbdbf45u1b194db53c9480a9@mail.gmail.com>
	 <921ca19c0902180352h2aaa859co69d66888f74898d4@mail.gmail.com>
	 <30047d300902180425r7e796378nfec7de22629e4a46@mail.gmail.com>
	 <921ca19c0902180442v6a90bb23x2c4c1f1570f56040@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org,
	Nicola Manica <nicola.manica@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.229]:8950 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbZBRMna (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2009 07:43:30 -0500
Received: by qb-out-0506.google.com with SMTP id q18so2722422qba.17
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Feb 2009 04:43:29 -0800 (PST)
In-Reply-To: <921ca19c0902180442v6a90bb23x2c4c1f1570f56040@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

---------- Forwarded message ----------
From: Sujit Karataparambil <sjt.kar@gmail.com>
Date: Feb 18, 2009 6:12 PM
Subject: Re: info softirq
To: Nicola Manica <nicola.manica@gmail.com>


> Probably I did not understand. I use netperf with
> netperf -H 192.168.0.207 -t UDP_STREAM -D 1 -I95,5 -- -m 1024
> so the test is simple UDP_STREAM. But the same happens with others tests.

you are using UDP_STREAM,in this test case, Which seems to be upstream.
Generally with this sort of test case generation is not suitable because of the
reason that it does not give accurate results. This is the problem with the
IRQ 16 being called multiple times.


> I compiled netperf from the source with --enable-intervals
> --enable-histogram --enable-demo

This seems to be fine.


-- 
--linux(2.4/2.6),bsd(4.5.x+),solaris(2.5+)
