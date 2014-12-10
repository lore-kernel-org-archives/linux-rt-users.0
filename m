From: Yadi Hu <yadi.hu@windriver.com>
Subject: [PATCH 3.14.x-rt] ARM: enable irq in translation/section permission fault handlers
Date: Wed, 10 Dec 2014 10:32:08 +0800
Message-ID: <1418178729-2279-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <yadi.hu@windriver.com>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:51911 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaLJCdq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Dec 2014 21:33:46 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id sBA2WQc0019894
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Tue, 9 Dec 2014 18:32:26 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[PATCH 3.14.x-rt] ARM: enable irq in translation/section permission fault handlers

_might_sleep() is used to check whether current context is atomic 
in preempt-rt kernel. According to discussion on http://www.spinics.net/
lists/linux-rt-users/msg11398.html, this case is a bug in RT. 

local_irq_save();
    some_function();
        rt_spin_lock() --> this calls __might_sleep
local_irq_restore(); 

----
arch/arm/mm/fault.c |    6 ++++++
 1 file changed, 6 insertions(+)

