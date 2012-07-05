From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: cpu stall and hyperthread
Date: Fri, 06 Jul 2012 00:48:53 +0200
Message-ID: <4FF619D5.3090206@osadl.org>
References: <4FEBCDDE.60503@gmail.com> <4FF351C6.3000100@gmail.com> <4FF4C94A.6040105@osadl.org> <4FF5DFDC.9010501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Dong Liu <dliu.cn@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:40963 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163Ab2GEWwI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Jul 2012 18:52:08 -0400
In-Reply-To: <4FF5DFDC.9010501@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Dong,

> I tried to disable CONFIG_RT_GROUP_SCHED, but I still got cpu stalls!
Hmm, sorry. I hoped it would work.

> Is there a recommended config for the RT patch?
Not really. In the x86 distro case, we base everything on the distro 
configuration, e.g. using
   cp /boot/config-`uname -r` .config

We then disable CONFIG_RT_GROUP_SCHED and CONFIG_DEBUG_STACKOVERFLOW, 
because they are known to cause trouble and long latencies, 
respectively. In addition, we enable diagnostics such a latency 
histograms. That's all.

An alternative approach would be to select a QA farm system that is 
close to your hardware and distro and use the same settings on your 
system. A list of all farm systems sorted by distro is here -> 
https://www.osadl.org/?id=1070; clicking on the system name in the first 
row of this table will display its entire profile. This includes kernel 
parameter, hardware data and, of course, the kernel configuration. 
Sometimes, there is also a quilt series, in case we temporarily use 
off-tree patches that are on their way to mainline. Would be interesting 
to see whether your system also stalls when a configuration is used that 
is successful here.

	-Carsten.
