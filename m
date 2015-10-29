From: "mr. sindar" <npc.sindar@gmail.com>
Subject: Variscite VAR-SOM-AM33 with patch-3.12.10-rt15
Date: Thu, 29 Oct 2015 11:38:00 +0300
Message-ID: <5631DAE8.3000200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36584 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbbJ2IiI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Oct 2015 04:38:08 -0400
Received: by lffz202 with SMTP id z202so15164712lff.3
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2015 01:38:06 -0700 (PDT)
Received: from MacBook-Pro-sindar.local ([79.120.48.186])
        by smtp.googlemail.com with ESMTPSA id 200sm83281lfz.48.2015.10.29.01.38.05
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2015 01:38:06 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello. I need some help or maybe just advice of right use of 
realtime-kernel. We are(company where i work) now developing PLC based 
on Variscite VAR-SOM-AM33 processor 
module(http://www.variscite.com/products/system-on-module-som/cortex-a8/var-som-am33-cpu-ti-am335x-am3354-am3352). 
Variscite provides it with kernel version 3.12. I've patched it with 
patch-3.12.10-rt15 and chose Full Preemptible Kernel(RT) preemption model.
As result when i run cyclictest(like said in wiki - 
https://rt.wiki.kernel.org/index.php/Cyclictest) with no other load in 
system, i've got following results:
cyclictest -t1 -p 80 -n -i 10000 -l 10000
System without RT-patch:
T: 0 ( 1399) P:80 I:10000 C:  10000 Min:     35 Act:   69 Avg:   63 Max: 
     247
System with RT-patch:
T: 0 ( 1534) P:80 I:10000 C:  10000 Min:     39 Act:   61 Avg:   61 Max: 
      91
So it works.

But when i enable load with codesyscontrol-system(about 80% CPU load), i 
have following results:
System without RT-patch:
T: 0 ( 1412) P:80 I:10000 C:  10000 Min:      8 Act:   16 Avg:   13 Max: 
     572
System with RT-patch:
T: 0 ( 1549) P:80 I:10000 C:  10000 Min:     11 Act:   14 Avg:   17 Max: 
    2492
Is it normal that max jitter in system with RT-patch more(almost 5x 
time) than in system without RT-patch, in this case?
Sorry, if this question silly. I've used only DOS-like(one-task) systems 
earlier and wrote firmwares with one task only in embedded systems, and 
Linux only on desktop and servers, without realtime.
Thanks, in advance.

-- 
Best regards, Sergey.
