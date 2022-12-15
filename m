Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0845DC4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Dec 2022 18:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiLOSj4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Dec 2022 13:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLOSjw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Dec 2022 13:39:52 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51101BB
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Dec 2022 10:39:48 -0800 (PST)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 58CC942807;
        Thu, 15 Dec 2022 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1671129584;
        bh=3qV4mYIB52/VJQiT1Z2NDahbK6t0DJK9gqlgYyEqRVs=;
        h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
        b=MTDH8SSD8Hq7tDq9Iv0fedIS21ylrKSOfyU0YOLvT3HPFSQLtyI0qJZxhMArFRsEN
         ldMwdoirwlwjxfXp48ouQNOSF4xxDKAMi9m29/CW2Xuoz+NJ4Bngn1f6FiCn/krGPO
         U1g9OU3E5cEJX/VEgHGVMzPBeWC38Sm10IeeV5hqpLa/4OTUaHn4Unbquj6YUAHFHo
         yEjIfZDBNDoAwN9avRZRafCe8LvjOpwKakB7jz1YmBjmBryhzDAlO3tSOXnlFxUR24
         P6LMJVCMlKfPW/K9uFwjI6CeCzpEAGkZ8rndQj8ugz6csZ9aVPkMNzPrp5mEGyMyGN
         c+12xj7/9TX0Q==
Message-ID: <fe5974c9-3ed0-938a-f43c-4d301f603e92@canonical.com>
Date:   Thu, 15 Dec 2022 13:39:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: System Hang With 5.15.79-rt54 Patch Set
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

A bug has been reported[0] against a linux-5.15.y based Ubuntu kernel 
that has the 5.15.79-rt54 real-time patch set applied.

This bug is causing a system hang when running disk tests with the 
stress-ng[1] test suite.  A 'hung task' call trace is being generated[2] 
just prior to the system hanging.  It appears the hang is happening 
during a call to schedule.

To see if this was a regression, I also tested prior real-time patch 
sets, going as far back to rt38 and all versions exhibit this bug. I 
will test back further to see if this is in fact a regression and a 
kernel bisect can be done.  I also confirmed the same kernel without the 
rt54 patch set applied does not exhibit this bug.

I will continue to debug this issue, but I wanted to send this message 
upstream in case anyone else runs into it.  Any specific tests, tracing 
or debugging steps would be greatly appreciated. Otherwise, I'll report 
back to this thread with any findings.

Thanks,

Joe


[0] https://bugs.launchpad.net/ubuntu-realtime/+bug/1998536
[1] https://github.com/ColinIanKing/stress-ng
[2] https://launchpadlibrarian.net/637058129/dmesg_dl110_rt_kernel.txt
