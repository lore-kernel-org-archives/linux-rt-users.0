Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA94C43334
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Jul 2022 20:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiGFUXU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGFUXT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Jul 2022 16:23:19 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0439A21E08
        for <linux-rt-users@vger.kernel.org>; Wed,  6 Jul 2022 13:23:19 -0700 (PDT)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5D3633F103;
        Wed,  6 Jul 2022 20:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657138997;
        bh=1eGXGQCPo0MoK0iFGGIu+p2feFk22+/CSQs+e4rjt/c=;
        h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
        b=OjE9wRZELy9fBFKOX0t/89sFRSZpU70br+ASarg4UYadYYPFLTXJyUte8RcaCKDSp
         H83DgjEvNOEJbdP112/NldxXejernMmhFAhjZUWjMkMuTvPG5T/ohwbuSwV5X0H2e8
         XlT8cHJDZSPz3pmyOviy883ptRK44ufYfC13XVfZlJeoIP0LtLDUyfHKbn7KVEeK97
         7R+WKtVC6/1hGdQ052rTgogD57+ccth8BtNdqvWUPmxnlIjNZXoyizQTPC4TBE3vTZ
         0sbIQLPm2b/us36MTAPSYGjnPuc5lK4SAYOvL7xhHb5YOHY6zljobzc/1EmoDAmItT
         FundDzgfi/P4A==
Message-ID: <456adbc0-63d4-7d8f-a700-b5e65e81d885@canonical.com>
Date:   Wed, 6 Jul 2022 16:23:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        williams@redhat.com
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Question Regarding [PATCH 098/167] in the 5.15 real-time patchset
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

An end user reported a bug[1] when attempting to use an Ubuntu kernel 
with the 5.15 real-time patches applied.  The user reports an issue with 
missing cg memory when Kubernetes is used with the 5.15 patchset.

After an investigation, it was found the issue is happens if the 
CONFIG_MEMCG config is not enabled.  That config is usually enabled for 
the generic Ubuntu kernel.  However, the config is disabled by the 
following patch in the 5.15 real-time patch set:

[PATCH 098/167] mm/memcontrol: Disable on PREEMPT_RT

I don't see this patch in the 5.16 and newer patch sets.  Is there a fix 
in mainline or in the newer 5.16 patches that allows the 'mm/memcontrol: 
Disable on PREEMPT_RT' patch to be dropped?  If so, I could assist with 
backporting the fix to 5.15 and older.

Thanks in advance!

Joe


[0] https://bugs.launchpad.net/ubuntu-realtime/+bug/1978814



