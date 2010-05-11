From: "Asier Tamayo" <asier.tamayo@ona-electroerosion.com>
Subject: PREEMPT_RT patch vs RTAI/Xenomai
Date: Tue, 11 May 2010 16:42:33 +0200
Message-ID: <DFFBF4EB468A894AB1474ED220F05AF60134C0BF@srv-dc.ona-electroerosion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.ona-electroerosion.com ([212.81.200.66]:43944 "EHLO
	mail.ona-electroerosion.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754620Ab0EKO5t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 May 2010 10:57:49 -0400
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello all:

I'm just a newbie to this list, so just forgive me if my question is obvious or has been answered many times ;-)

I want to do a port from an old system running a proprietary RTOS to a new one based in Linux. My system runs many applications at the same time (GUI, parsers, ...), a few of which are hard real-time. 

I've searched the web, but am still unable to decide which system to use: RTAI, Xenomai or the PREEMPT_RT patch. Can anyone give me some clue in this issue? Are there any advantages in choosing the PREEMPT_RT patches over Xenomai or RTAI? Running the GUI, which demands a lot of CPU and RAM, can have any effect on the real-time behaviour?

I've seen many comparisons, but in this fast-changing world, most of them seem to me to be quite out of date.

Any hint will be really helpful,

Best regards,

Asier
