From: Andy Ng <andreas2025@gmail.com>
Subject: Tracing within functions.
Date: Sun, 29 Mar 2015 21:16:07 +0100
Message-ID: <CAAVaN8yOYUf_+5Pxh4qOWxb5rqMu__LcqSxr0YMVA114A41YWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36908 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbbC2UQH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 29 Mar 2015 16:16:07 -0400
Received: by igcxg11 with SMTP id xg11so55985748igc.0
        for <linux-rt-users@vger.kernel.org>; Sun, 29 Mar 2015 13:16:07 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am using an RT kernel and in my  driver there is  an atomic code
path that just makes some critical I/O operations. I would like to
trigger a system function trace when kernel enters into a specific
function in my driver and stop the system trace at the end of the
function. I would like to identify time execution latencies for a
specific code path. I am using Cortex A9 and I have perf and PMU up
and running, but still it is not clear to me how to retrieve the
traces with those latencies in my code path.

Any ideas how to trace/measure that  will be very much appreciated.

Best regards,
Andy
