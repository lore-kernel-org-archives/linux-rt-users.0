From: "Husak, Jan" <jan.husak@siemens.com>
Subject: RE: Locating processes impacting my rt application
Date: Fri, 19 Nov 2010 16:11:35 +0100
Message-ID: <3E4278088AD82C48B4663DDFE762CEF3084CD74A@prga004a.ww300.siemens.net>
References: <4CE428CB.20808@willowgarage.com> <4CE480BF.7050603@linux.intel.com> <4CE5A4A3.4040202@cygnusx-1.org> <B5339992F194184BABF87ECF0296990D034E5F0F@GLKMS2105.GREENLNK.NET>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mxs2.siemens.at ([194.138.12.133]:55873 "EHLO mxs2.siemens.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754778Ab0KSPWQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Nov 2010 10:22:16 -0500
Received: from vies1k7x.sie.siemens.at ([158.226.129.83])
	by mxs2.siemens.at  with ESMTP id oAJFBbJ1014148
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Nov 2010 16:11:37 +0100
Received: from nets139a.ww300.siemens.net ([192.168.217.3])
	by vies1k7x.sie.siemens.at (8.12.11.20060308/8.12.1) with ESMTP id oAJFBaCq023844
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Nov 2010 16:11:36 +0100
Content-class: urn:content-classes:message
In-Reply-To: <B5339992F194184BABF87ECF0296990D034E5F0F@GLKMS2105.GREENLNK.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Try ftrace, with sched_switch tracer, to see threads switching.

Jan 

-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org
[mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Leggo, Adam
(UK)
Sent: 19. listopadu 2010 13:05
To: linux-rt-users@vger.kernel.org
Subject: Locating processes impacting my rt application

Hello, 

I have been working on a simulator that sends large amount of data to
another system. I am having a problem where something in the system is
interupting my processing loops for an extended period. I would like
some suggestions on how to find the offending process and prevent it
from impacting my applications while it is running.

The purpose of the simulator is to receive an instruction every 4ms and
then responses by sending 400KB chunks of data on each of 8 sFPDP fibre
channels to the system under test before the next instruction. The
current simulator can match the 4ms frequency most of the time, but
every 300 or so instructions a delay occurs of up to 15ms that impacts
the system under test.

The simulator is running on an 8 core HP server running openSUSE 11.3
with real time kernel 2.6.33.1-rt11. The instruction processing thread
is locked to cpu 4 and the four data sending threads are locked to cpu's
5-8. 

How do you either find the offending processes or prevent other
processes using the real time CPU cores? I have tried oprofile to
profile the system and haven't found anything. I may not be interpreting
the results correctly.

I tried the suggestions in the following website, but I may not have set
it up correctly.
https://rt.wiki.kernel.org/index.php/CPU_shielding_using_/proc_and_/dev/
cpuset

Any suggestion would be helpful.

Regards
Adam Leggo

********************************************************************
This email and any attachments are confidential to the intended
recipient and may also be privileged. If you are not the intended
recipient please delete it from your system and notify the sender.
You should not copy it or use it for any purpose nor disclose or
distribute its contents to any other person.
********************************************************************

--
To unsubscribe from this list: send the line "unsubscribe
linux-rt-users" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
