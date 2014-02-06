From: Corey Minyard <cminyard@mvista.com>
Subject: Couple of questions about details of the RT patch
Date: Thu, 06 Feb 2014 12:17:11 -0600
Message-ID: <52F3D1A7.8020809@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:39257 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbaBFSRN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Feb 2014 13:17:13 -0500
Received: by mail-oa0-f52.google.com with SMTP id i4so2791014oah.39
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Feb 2014 10:17:12 -0800 (PST)
Received: from t430.minyard.home (pool-173-57-152-84.dllstx.fios.verizon.net. [173.57.152.84])
        by mx.google.com with ESMTPSA id oo13sm10119258oeb.0.2014.02.06.10.17.11
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 10:17:11 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I was looking over the RT patch and I had a couple of questions:

Is there a reason that the PREEMPT_LAZY code is not ifdef-ed out when
PREEMPT_LAZY is disabled.  I can't see a reason to leave it in, it's
just dead code at that point.  I'd be happy to do a patch to fix this.

Why does preempt_disable_rt() become a barrier when PREEMPT_RT is
disabled?  Why isn't it just nothing?

Thanks,

-corey
