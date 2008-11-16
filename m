From: Amir Aharon <amira@waves.com>
Subject: few question about the platform tested and in use with
 config_preempt_rt...
Date: Sun, 16 Nov 2008 08:59:37 -0500
Message-ID: <A58BC43ACBDDA54393A506C9A68AB8B402FB3AF3AE@maxx.waves.com>
References: <A58BC43ACBDDA54393A506C9A68AB8B402F8EB14DD@maxx.waves.com>
 <491BDA3D.8040904@osadl.org>
 <A58BC43ACBDDA54393A506C9A68AB8B402F8EB1784@maxx.waves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: RT-Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from maxx.waves.com ([12.34.136.4]:56933 "EHLO maxx.waves.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbYKPN7d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 16 Nov 2008 08:59:33 -0500
In-Reply-To: <A58BC43ACBDDA54393A506C9A68AB8B402F8EB1784@maxx.waves.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi all,

I have few questions regarding the platform tested with the config_preempt_rt:

1. When was last time the table at <http://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch> updated?

2. Was the worse case latency measured under stress? If so which stress test was used? 

3. What kind of network tests has been used? Does the worse case latency valid for network application (RT low latency audio streaming)?

3. Were there any additional hardware tweaking done on the tested system (e.g. bios option tweaking such as turning off fan control)?

4. Were there any additional kernel option tweaking done, e.g. - clock source, tick-less kernel?

5. Which kernel modules were loaded on the measured system (USB module, keyboard controller, Ethernet driver etc...)?

6. What bios version was used? Was it the latest version?

7. Could you share the contents of /proc/interrupts file of the tested system?

Thanks,
Amir.

