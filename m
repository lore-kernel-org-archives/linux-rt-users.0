From: Yang Shi <yang.shi@windriver.com>
Subject: Fix two sleeping function called in atomic context bug
Date: Mon, 16 Sep 2013 14:09:17 -0700
Message-ID: <1379365759-5743-1-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <paul.gortmaker@windriver.com>, <yang.shi@windriver.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:32865 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab3IPVOL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Sep 2013 17:14:11 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r8GLEAQv000383
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Mon, 16 Sep 2013 14:14:11 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


This patch series fix up two "sleeping function called from invalid context"
bugs triggerred by ltp test cases (leapsec_timer and oom) on 3.10 rt.
