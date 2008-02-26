From: "CHAVENT Paul" <Paul.CHAVENT@criltechnology.com>
Subject: Can you explain PCI DMA latency please ?
Date: Tue, 26 Feb 2008 10:51:05 +0100
Message-ID: <631F24C6E5322142A5BDEFA2E85180802978A4@tls01.criltechnology.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 171.192.65-86.rev.gaoland.net.192.65.86.in-addr.arpa ([86.65.192.171]:3520
	"EHLO criltechnology.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752945AbYBZKCi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2008 05:02:38 -0500
Received: from cril01.criltechnology.net by criltechnology.com
	(MDaemon PRO v9.6.0)
	with ESMTP id md50000228153.msg
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Feb 2008 10:51:08 +0100
content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everyone.

You write (and we can read on some docs) that DMA an PCI acess can cause long-latency. I don't understand why.

I'am not a guru and knwo perfectly how the dma work but i thought that the cpu ask for a dma to a device. The device is then autonomous for acessing the memory. I wonder why the cpu is "locked" ? What the dma brings if the cpu can't continue his work ?

Thanks for your help.

Paul.
