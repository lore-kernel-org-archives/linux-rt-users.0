From: "Kaya, Sinan" <sinan.kaya@siemens.com>
Subject: preemption issue
Date: Mon, 13 Aug 2007 15:54:24 +0300
Message-ID: <725A29F6B5035C45A40BDE230A5B92190E693977@TRISTK010MSX.tr001.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.siemens.com.tr ([212.133.141.62]:42319 "EHLO
	karya.siemens.com.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S945694AbXHMNB6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Aug 2007 09:01:58 -0400
Received: from tristk010msx.tr001.siemens.net (kapadokya.siemens.com.tr [141.29.16.101])
	by karya.siemens.com.tr (8.13.4/8.13.4/Debian-3) with ESMTP id l7DD1eAM011961
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Aug 2007 16:01:40 +0300
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello All,
I have got an interesting lock up situation using 2.6.21.5 kernel
together with rt15 patch. I'll try also with 22.1 before that i wanted
to check if anybody else has faced it.  

I have one application communicating with a kernel driver. A character
driver has been implemented as an interface. The situation is a classic
provider-consumer case. Kernel driver provides data and application
consumes it. I have difficulties with triggering the application. 


The provider receives a frame from the network and feeds this into the
application. The proiroities are configured with the following script:

So hrtimer has the highest priority with 99 and net-rx and net-tx is
configured with 55. The application is configured for 70.

The application runs smoothly for a while and then, the computer
completely locks up. I am unable to enter any keyboard data. When i
unplug the network cable, i see the message that it has been
disconnected. So, the kernel driver is still alive. 

What could be the reason for this lock up. I also tried with round robin
policy. It has been much more stable but it also locks up after a while.

Thanks and regards,
Sinan.
