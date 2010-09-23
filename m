From: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Subject: Regarding interrupt task latency
Date: Thu, 23 Sep 2010 19:00:29 -0400
Message-ID: <AANLkTi=EmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:37231 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab0IWXAa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Sep 2010 19:00:30 -0400
Received: by pxi10 with SMTP id 10so646404pxi.19
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 16:00:30 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

       I have a doubt regarding interrupt task latency.
       I know that whenever interrupt context and its associated BH
are finished, then need_resch is checked whether to call schedule
       In such case then the latency is deterministic and one need not
to bother about this latency. Why is that rt still considers this as
       bottle neck on this issue.

       Any explanation is appreciated. Thanks.

-- 
Regards,
Sri.
