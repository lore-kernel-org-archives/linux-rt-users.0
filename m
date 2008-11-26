From: crquan@gmail.com
Subject: strange getrusage timer problem with rt-kernel
Date: Wed, 26 Nov 2008 11:52:28 +0800
Message-ID: <492cc7d4.044e6e0a.165f.56dc@mx.google.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:11984 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbYKZDvw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Nov 2008 22:51:52 -0500
Received: by ti-out-0910.google.com with SMTP id b6so131691tic.23
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2008 19:51:50 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm testing 2.6.26.6-rt11 (is that the latest?) kernel, using tiotest from tiobench
(http://sourceforge.net/projects/tiobench/), a classic multi-thread IO stress tool,

it reported a strange problem, with:

root:~/tiobench# time ./tiotest -R -d /dev/mapper/dg5-lv2 -t 1 -f 1000 -r 102400
tiotest: tiotest.c:609: add_timer: Assertion end_time->tv_sec >= start_time->tv_sec' failed.?

this problem never happened in mainstream kernels.

Regards,

--
Cheng Renquan, Shenzhen, China

