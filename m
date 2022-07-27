Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F886C04A68
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jul 2022 20:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiG0Ufu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Jul 2022 16:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiG0Ufu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Jul 2022 16:35:50 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A466E6259
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Jul 2022 13:35:48 -0700 (PDT)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 109283F11A;
        Wed, 27 Jul 2022 20:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658954146;
        bh=580w4J/BfYyb+FIVnc5HEJGq/pL7RUAKEjbnK3RViIk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=d0HCTy5ZzroErvpmJjzk3nIDN6b4bbKuHUraOpwXqI1ZmCJ7+3q1J4Gx8oQBsMUsT
         7WJhAxma6ocmtNC49I7NZaL8MS6dFUsyAgIXOsWcFTisBwrp4wTtlBRCKMcF1zFyE7
         Vwf8N9zKB/RXJ6FFuIayOC02scq4bZX6494h3YHBvS7YGO7N65shFZtWwtcwzozrXY
         xYZXpL+JGG3ifBGdT7RMsIVF2LAbZ0tA7p4gcVDaJXHcKIsXnFj4s8y8AXNT4LYmGr
         camVG3IGPuqk7P5D8qadb1vplRCp46AvX0uttLvFmCKa/A6gV9LKDdvnAPYa6dKIXV
         6+QbW3KilRjsw==
Message-ID: <60f230fb-de97-ead8-b3a3-12a591804c32@canonical.com>
Date:   Wed, 27 Jul 2022 16:35:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] Backport MEMCG changes from v5.17
Content-Language: en-US
To:     David Oberhollenzer <goliath@infraroot.at>,
        linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at
References: <20220712112238.18824-1-goliath@infraroot.at>
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
In-Reply-To: <20220712112238.18824-1-goliath@infraroot.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 7/12/22 07:22, David Oberhollenzer wrote:
> This is a backport of Sebastian's MEMCG changes to v5.15. With these
> patches applied, it is possible to use memory cgroups together
> with PREEMPT_RT on v5.15, just like on v5.17.
>
> David Oberhollenzer (1):
>    Allow MEMCG on PREEMPT_RT
>
> Sebastian Andrzej Siewior (3):
>    mm/memcg: Disable threshold event handlers on PREEMPT_RT
>    mm/memcg: Protect per-CPU counter by disabling preemption on
>      PREEMPT_RT where needed.
>    mm/memcg: Add a local_lock_t for IRQ and TASK object.
>
>   .../admin-guide/cgroup-v1/memory.rst          |    2 +
>   init/Kconfig                                  |    1 -
>   mm/memcontrol.c                               | 1264 +++++++++--------
>   3 files changed, 671 insertions(+), 596 deletions(-)
>
Hi David,

Do you know if these patches will be merged into the 5.15 patchset?

Thanks,

Joe
