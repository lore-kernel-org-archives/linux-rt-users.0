From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
	<alexander.haenel-baas@sieb-meyer.de>
Subject: CONFIG_PREEMPT_RT_FULL an usb gadget
Date: Tue, 27 Aug 2013 14:54:35 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC91232F954E81@SMExchange01.siebmeyer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smnotes1.sieb-meyer.de ([213.252.170.194]:28355 "EHLO
	mail.sieb-meyer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab3H0PAB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Aug 2013 11:00:01 -0400
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello rt-community,

i use the kernel 3.10.4 with the 3.10.4-rt-1 patch
and the usb RNDIS connection to a windows pc.

In the kernelconfig i set the low-latency desktop with CONFIG_PREEMPT_LL=y and the usb Ethernet gadget works fine.

Now i change the kernelconfig to CONFIG_PREEMPT_RT_FULL=Y and now it is not possible to get a working usb gadget connection.

In both situation i see that windows detect the RNDIS device in the device manager. 

The next step was to enable the USB gadget debugging messages to see what is going on.
At this time I see many usb-gadget outputs:

#dmesg
[   84.085953] gen_ndis_query_resp: RNDIS_OID_GEN_RCV_NO_BUFFER
[   84.093266] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
[   84.093621] g_ether gadget: rndis req21.00 v0000 i0000 l36
[   84.101284] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
[   84.101680] g_ether gadget: rndis req21.00 v0000 i0000 l36
[   84.109265] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
[   84.109663] g_ether gadget: rndis req21.00 v0000 i0000 l36
[   84.109782] gen_ndis_query_resp: RNDIS_OID_GEN_RCV_NO_BUFFER
...

But I can't find a difference between the working config (low-latency)
and the full-rt configuration.

What can I do to get a working fully pre-emptible usb gadget?	

kind regards
Alexander Haenel-Baas





