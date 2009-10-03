From: Gautam Thaker <gautam.h.thaker@lmco.com>
Subject: is there a PREEMPT-realtime  patch for stable kernel version 2.6.31.1 ??
Date: Sat, 03 Oct 2009 17:23:08 -0400
Message-ID: <4AC7C0BC.70301@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailgw2a.lmco.com ([192.91.147.7]:46188 "EHLO mailgw2a.lmco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbZJCV75 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 Oct 2009 17:59:57 -0400
Received: from emss01g01.ems.lmco.com (relay1.ems.lmco.com [137.249.139.141])by mailgw2a.lmco.com  (LM-6) with ESMTP id n93LNDAw025567for <linux-rt-users@vger.kernel.org>; Sat, 3 Oct 2009 17:23:13 -0400 (EDT)
Received: from CONVERSION2-DAEMON.lmco.com by lmco.com (PMDF V6.3-x14 #31428)
 id <0KQY00901JEPIV@lmco.com> for linux-rt-users@vger.kernel.org; Sat, 03 Oct 2009 14:23:13 -0700 (PDT)
Received: from enterprise.atl.lmco.com ([166.17.240.20]) by lmco.com (PMDF V6.3-x14 #31428)
 with ESMTP id <0KQY004Z0JEKON@lmco.com> for linux-rt-users@vger.kernel.org; Sat, 03 Oct 2009 14:23:08 -0700 (PDT)
Received: from [166.17.240.47] (sophie [166.17.240.47])	by enterprise.atl.lmco.com (Postfix)
 with ESMTP id 352F6B6C7	for <linux-rt-users@vger.kernel.org>; Sat, 03 Oct 2009 17:23:08 -0400 (EDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Also, as I was reading the RT_PREEMPT_HOWTO at:

http://rt.wiki.kernel.org/index.php/Main_Page 	

I noticed that the image shown by this link:	


http://www.pengutronix.de/images/rt-wiki/menuconfig3.PNG

is possibly outdated, I could not find

"Non-preemptible critical section latency timing" option when I did

make menuconfig.


I have built and booted many RT kernels over the years, but not in the last 6 
months to a year. Somehow I am having trouble getting 2.6.31-rt11  to boot. 
(No doubt I have forgotten some important step, so I am doing things step by 
step per the wiki pages.)

Gautam
