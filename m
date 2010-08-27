From: Bob Liu <lliubbo@gmail.com>
Subject: Is there borken out patch for patch-2.6.33.7-rt29.gz?
Date: Fri, 27 Aug 2010 18:47:18 +0800
Message-ID: <AANLkTinQz_rmMfCtjq=wcx1bkDoX0MBAR1YsJHHJXVDB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47571 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0H0KrS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Aug 2010 06:47:18 -0400
Received: by qyk9 with SMTP id 9so473389qyk.19
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2010 03:47:18 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, All

I want to use preempt-rt for our kernel 2.6.34 in a project.
The lastest preempt-rt patch is 2.6.33.7 but I still try to patch it to 2.6.34.

Is there borken out patch for patch-2.6.33.7-rt29.gz?
This can make things simple, eg out platform is arm and don't use
network,so I can ignore all the no-arm platform patch and network patch.

Thanks!
-- 
Regards,
--Bob
