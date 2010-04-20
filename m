From: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: cpu usage with high-res timer
Date: Tue, 20 Apr 2010 17:11:12 -0500
Message-ID: <i2je6bf505b1004201511k52fa9445o76b8d0e0136590fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40834 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab0DTWLN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Apr 2010 18:11:13 -0400
Received: by gwj19 with SMTP id 19so1038993gwj.19
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Apr 2010 15:11:12 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm running 2.6.33-rt on a powerpc platform(upgraded from 2.6.18-rt),
the main application is a multi-thread program. I use procps 3.2.7 to
check cpu usage, load avg etc.

2.6.33 beats 2.6.18 all around, including latency, hackbench, etc.

however my pthread app always takes 13% cpu (top reports cpu 87% idle,
i.e. 100%-13%=87%) while it's running and waiting for input on
2.6.33-rt, on 2.6.18-rt it's <1% cpu usage(top reports 97% idle
percentage).

when I disable high-res from 2.6.33-rt, cpu usage is the same but
'top' now reports 96% idle, looks like it ignores the fact that my
application is using 13% cpu(I suspect the idle rate should still be
100%-13%=87%, but it's not when high-res is disabled). both kernel
uses 1000HZ, 2.6.18 does not have high-res implemented.

I'm trying to find the cause of the 13% cpu usage on 2.6.33, and if it
has anything to do with high-res timer. Interestingly, 2.6.33 has only
half the load avg comparing to 2.6.18 while my application is waiting
for input, even though the application uses more cpu time but the
system load is lower, which is good news.

Still, why am my application suddenly showing a high cpu usage on this
new rt kernel?

any suggestion is appreciated,
xianghua
