From: Matthieu Bec <mbec@gmto.org>
Subject: good load / stress suite?
Date: Tue, 15 May 2012 16:08:13 -0700
Message-ID: <4FB2E1DD.7020203@gmto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rainbow.obs.carnegiescience.edu ([192.91.178.46]:52079 "EHLO
	rainbow.gmto.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758164Ab2EOXYf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 19:24:35 -0400
Received: from localhost.localdomain ([216.2.92.138])
	(authenticated bits=0)
	by rainbow.gmto.org (8.14.4/8.14.4) with ESMTP id q4FN8DMI009334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Tue, 15 May 2012 16:08:13 -0700
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello all,

I was wondering what people used to check RT_PREEMPT behavior under 
load/stress?

I'm trying to test the accuracy of my timers and have a test where I 
setup a kernel module with an hr-timer flipping RTS bit on serial COM0 
periodically, which I can look on an oscilloscope. the scope triggers on 
rising edge, I call jitter what shows on the falling side:
under no specific load I get ~ 10 us (worst case waiting a long time)


My initial idea for stressing the system was to compile a kernel, make 
-j 8 (#cores) that I thought would exercise CPU and IO if anything. As 
it happens, it's "mostly good" but I do get occasional (but repeatable) 
wild excursions (>100us)

Looking around, I found a tool called 'stress' - 
http://weather.ou.edu/~apw/projects/stress/
Under these new conditions, the system behaves really well again ~20 us 
stable all the way.

So both tests give different result, I'm not sure which to trust.
I was thinking maybe there is some weird interaction with the kernel and 
building the kernel that make the 'bad' test invalid?

I have RT_PREEMPT 3.0.18-rt34 SMP x86_64

Thanks,
-- 
Matthieu

