From: "Cheng Renquan" <crquan@gmail.com>
Subject: Re: strange getrusage timer problem with rt-kernel
Date: Wed, 26 Nov 2008 11:55:23 +0800
Message-ID: <91b13c310811251955la7c09ecwe83c88929d2f5af@mail.gmail.com>
References: <492cc7d4.044e6e0a.165f.56dc@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:2417 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYKZDz0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Nov 2008 22:55:26 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1291174ugf.37
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2008 19:55:24 -0800 (PST)
In-Reply-To: <492cc7d4.044e6e0a.165f.56dc@mx.google.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> From: crquan@gmail.com
> To: linux-rt-users@vger.kernel.org
> Subject: strange getrusage timer problem with rt-kernel
>
> I'm testing 2.6.26.6-rt11 (is that the latest?) kernel, using tiotest from tiobench
> (http://sourceforge.net/projects/tiobench/), a classic multi-thread IO stress tool,
>
> it reported a strange problem, with:
>
> root:~/tiobench# time ./tiotest -R -d /dev/mapper/dg5-lv2 -t 1 -f 1000 -r 102400
> tiotest: tiotest.c:609: add_timer: Assertion `end_time->tv_sec >= start_time->tv_sec' failed.
> Aborted
>
> real8m35.086s
> user0m2.080s
> sys0m7.000s
>
> Not always, just few times, you can view the tiotest.c code from:
> http://tiobench.cvs.sourceforge.net/viewvc/tiobench/tiobench/tiotest.c?revision=1.20&view=markup
>
> when add_timer called, it's passed with two timers, one before the io test, and the other is after
> the io tests, why the Assertion `end_time->tv_sec >= start_time->tv_sec' failed.?
>
> this problem never happened in mainstream kernels.
>
> Regards,
>
> --
> Cheng Renquan, Shenzhen, China
>
> EOF
