From: "Chris Caudle" <chris@chriscaudle.org>
Subject: replacement of tasklet_hrtimer_init in RT
Date: Tue, 24 Oct 2017 11:33:46 -0500
Message-ID: <69d8d76f1173a449bce4a3bc3a9e1a06.squirrel@email.powweb.com>
Reply-To: chris@chriscaudle.org
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from walmailout09.yourhostingaccount.com ([65.254.253.73]:53208 "EHLO
        walmailout09.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751484AbdJXREu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Oct 2017 13:04:50 -0400
Received: from mailscan08.yourhostingaccount.com ([10.1.15.8] helo=walmailscan08.yourhostingaccount.com)
        by walmailout09.yourhostingaccount.com with esmtp (Exim)
        id 1e729F-0001Uu-Bc
        for linux-rt-users@vger.kernel.org; Tue, 24 Oct 2017 12:33:49 -0400
Received: from [10.114.3.33] (helo=walimpout13)
        by walmailscan08.yourhostingaccount.com with esmtp (Exim)
        id 1e729F-00013y-6D
        for linux-rt-users@vger.kernel.org; Tue, 24 Oct 2017 12:33:49 -0400
Received: from [127.0.0.1] (helo=email.powweb.com)
        by walwebmail04.yourhostingaccount.com with esmtp (Exim)
        id 1e729C-0001VV-21
        for linux-rt-users@vger.kernel.org; Tue, 24 Oct 2017 12:33:46 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I recently began helping someone test a new multimedia driver (network
audio) and found that the driver would not compile on my machine running
an RT kernel because the driver used tasklet_hrtimer_init(), but that
function is not defined in interrupt.h in the RT  patched kernel.

What should be used in place of that, and where should be look for
documentation describing any differences that need to be accomodated?

-- 
Chris Caudle




