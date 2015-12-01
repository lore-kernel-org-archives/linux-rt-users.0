From: "Shi, Yang" <yang.shi@linaro.org>
Subject: -rt kernel just can show 8 perf events?
Date: Tue, 01 Dec 2015 12:36:37 -0800
Message-ID: <565E04D5.4000202@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35420 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756938AbbLAUgj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Dec 2015 15:36:39 -0500
Received: by pacej9 with SMTP id ej9so15944034pac.2
        for <linux-rt-users@vger.kernel.org>; Tue, 01 Dec 2015 12:36:39 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi folks,

I'm running some perf program on my x86-64 machine with 4.1.12-rt13 
kernel, but I found just 8 perf events can be showed up with "perf stat 
-e" on -rt kernel, but mainline kernel is fine.

I traced 14 events (tried different number in my test, always > 8), then 
I got:

             29692      cs 

                104      page-faults 

                104      minor-faults 

                  0      major-faults 

          100122071      iTLB-load-misses 

             447793      dTLB-load-misses 

              13655      dTLB-store-misses 

          201620583      branch-misses 

      <not counted>      cache-misses               (0.00%)
      <not counted>      cycles                     (0.00%)
      <not counted>      dtlb_misses_walk_duration  (0.00%)
      <not counted>      dtlb_misses_walk_completed  (0.00%)
      <not counted>      itlb_misses_walk_duration  (0.00%)
      <not counted>      itlb_misses_walk_completed  (0.00%)

No matter how many events are traced, just 8 events are showed with 
meaningful data, all others are showed up as "not counted".

Any hint is appreciated.

Regards,
Yang
