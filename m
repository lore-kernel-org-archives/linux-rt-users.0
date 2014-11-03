From: Chris Friesen <chris.friesen@windriver.com>
Subject: which kernel thread handles NMIs?
Date: Mon, 3 Nov 2014 15:08:19 -0600
Message-ID: <5457EEC3.5010506@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36296 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbaKCVJg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Nov 2014 16:09:36 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id sA3L8LoB018108
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Mon, 3 Nov 2014 13:08:21 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We're running with the 3.4 kernel with RT patch, and we're trying to 
debug some issues.

One of the issues is that the magic sysrq "l" command to show a stack 
backtrace on all CPUs doesn't seem to work, though other magic sysrq 
commands do work properly.

Looking at the code, for X86 it seems to call 
apic->send_IPI_all(NMI_VECTOR);

Does anyone know what kernel thread would handle NMI_VECTOR?  I want to 
make sure its priority is sufficiently high.

Thanks,
Chris
