From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: CONFIG_PREEMPT_RT_FULL an usb gadget
Date: Thu, 29 Aug 2013 13:35:21 +0200
Message-ID: <20130829113521.GB15360@linutronix.de>
References: <9BA84827B30CBE4996725F98F7DC91232F954E81@SMExchange01.siebmeyer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander
	<alexander.haenel-baas@sieb-meyer.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49258 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab3H2LfW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Aug 2013 07:35:22 -0400
Content-Disposition: inline
In-Reply-To: <9BA84827B30CBE4996725F98F7DC91232F954E81@SMExchange01.siebmeyer.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* H=C3=A4nel-Baas, Alexander | 2013-08-27 14:54:35 [+0000]:

>Hello rt-community,
Hi,

>i use the kernel 3.10.4 with the 3.10.4-rt-1 patch
>and the usb RNDIS connection to a windows pc.

So you use an x86 based UDC/machine if you are using v3.10.4-rt1 here.

>In the kernelconfig i set the low-latency desktop with CONFIG_PREEMPT_=
LL=3Dy and the usb Ethernet gadget works fine.
>
>Now i change the kernelconfig to CONFIG_PREEMPT_RT_FULL=3DY and now it=
 is not possible to get a working usb gadget connection.

Is a different gadget working? Say usb-storage against Windows oder
g_ncm against Linux?

>In both situation i see that windows detect the RNDIS device in the de=
vice manager.=20
>
>The next step was to enable the USB gadget debugging messages to see w=
hat is going on.
>At this time I see many usb-gadget outputs:
>
>#dmesg
>[   84.085953] gen_ndis_query_resp: RNDIS_OID_GEN_RCV_NO_BUFFER
>[   84.093266] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
>[   84.093621] g_ether gadget: rndis req21.00 v0000 i0000 l36
>[   84.101284] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
>[   84.101680] g_ether gadget: rndis req21.00 v0000 i0000 l36
>[   84.109265] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
>[   84.109663] g_ether gadget: rndis req21.00 v0000 i0000 l36
>[   84.109782] gen_ndis_query_resp: RNDIS_OID_GEN_RCV_NO_BUFFER
>...
>
>But I can't find a difference between the working config (low-latency)
>and the full-rt configuration.
>
>What can I do to get a working fully pre-emptible usb gadget?=09

Try to enable lock debuging and see if the kernel complains about
something.
So after enabling debug you don't see a difference in the communication=
?
Can you try against Linux RNDIS and see if that is working? If that als=
o
fails then you get a chance to debug.

>
>kind regards
>Alexander Haenel-Baas

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
