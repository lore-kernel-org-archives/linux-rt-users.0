From: Vivek Satpute <vivek@linsyssoft.com>
Subject: [PATCH-rt 0/1] Fix spinlock issue in net/core/sock.c
Date: Thu, 25 Jun 2009 17:28:08 +0530
Message-ID: <1245931088.6269.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, prtproj@linsyssoft.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:45595 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbZFYL6L (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Jun 2009 07:58:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so509393wfd.4
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Jun 2009 04:58:15 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I would be sending patch to fix spinlock issue in subsequent mail for
PREEMPT_RT.

Thanks and Regards,
Vivek Satpute
System Software Engineer
LinSysSoft Technologies, Pune

