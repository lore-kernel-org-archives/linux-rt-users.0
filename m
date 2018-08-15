Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from [195.159.176.226] ([195.159.176.226]:44289 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeHOI7U (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Aug 2018 04:59:20 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glru-linux-rt-users@m.gmane.org>)
        id 1fpowo-0006kd-RN
        for linux-rt-users@vger.kernel.org; Wed, 15 Aug 2018 08:06:22 +0200
From: Tim Blechmann <tim@klingt.org>
Subject: SCHED_DEADLINE as user
Date: Wed, 15 Aug 2018 14:08:20 +0800
Message-ID: <pl0fsj$ohn$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

hi all,

i wonder, what's the preferred way to obtain SCHED_DEADLINE privileges
as non-root user?
for SCHED_RR/SCHED_FIFO i'm typically using pam_limits/limits.conf, but
i haven't found any resources on how SCHED_DEADLINE can be obtained ...

thanks in advance,
tim
