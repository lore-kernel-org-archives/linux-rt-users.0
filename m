Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F52FC19F28
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Aug 2022 09:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiHCJRa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiHCJRa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Aug 2022 05:17:30 -0400
Received: from mail.infraroot.at (mail.infraroot.at [IPv6:2001:41d0:701:1100::afc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2A020F46
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Aug 2022 02:17:25 -0700 (PDT)
Received: from [10.115.254.165] (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id 77D0840FCF;
        Wed,  3 Aug 2022 11:17:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 77D0840FCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1659518242;
        bh=G4XKCWXKrzV7k3rSEGTQR2ceqgM47Yhv/9A00tpRRsE=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=PFz5nJ02O8d68dLaA1539+95w4WkFR+qJFHEVHqkCFqcd2F80SDj3WXl13fmFROfm
         EBhb7MoG6gx1Ldrwa9SUPFHl6RpbtWU3aZdk2o3w1ZZyYnRupdq5p+648igHmjg9Wf
         RnWNsnHFlVXlpvQH06CJwR1ZMKAPmxez++SS2D8Y=
Message-ID: <9263b71b-369c-6ec3-c55a-ed498b44cf66@infraroot.at>
Date:   Wed, 3 Aug 2022 11:17:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   David Oberhollenzer <goliath@infraroot.at>
Subject: Re: [PATCH 0/4] Backport MEMCG changes from v5.17
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com, richard@nod.at
References: <20220712112238.18824-1-goliath@infraroot.at>
 <Yuobh/+/Sv8VTjTP@linutronix.de>
Content-Language: en-US
In-Reply-To: <Yuobh/+/Sv8VTjTP@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On 8/3/22 08:53, Sebastian Andrzej Siewior wrote:
> On 2022-07-12 13:22:34 [+0200], David Oberhollenzer wrote:
>> This is a backport of Sebastian's MEMCG changes to v5.15. With these
>> patches applied, it is possible to use memory cgroups together
>> with PREEMPT_RT on v5.15, just like on v5.17.
> 
> This isn't the series that was merged upstream:
> | 0001-mm-memcg-Revert-mm-memcg-optimize-user-context-objec.patch
> | 0002-mm-memcg-Disable-threshold-event-handlers-on-PREEMPT.patch
> | 0003-mm-memcg-Protect-per-CPU-counter-by-disabling-preemp.patch
> | 0004-mm-memcg-Opencode-the-inner-part-of-obj_cgroup_uncha.patch
> | 0005-mm-memcg-Protect-memcg_stock-with-a-local_lock_t.patch
> | 0006-mm-memcg-Disable-migration-instead-of-preemption-in-.patch
> | 0007-mm-memcg-Add-missing-counter-index-which-are-not-upd.patch
> | 0008-mm-memcg-Add-a-comment-regarding-the-release-obj.patch
> | mm-memcg-Only-perform-the-debug-checks-on-PREEMPT_RT.patch
> 
> any reason why not backport those?
> 

this patch set is based on the one Richard submitted in late
June, but was asked to use the changes from v5.17 instead
of v5.16. I was under the impression that this meant to use
the state of the code in v5.17 instead, as some of the back
ported code was refactored a bit further upstream.

I tried to stick to Richards patch set, picking the equivalent
changes in mm from the git history, leading up to the v5.17.1-rt17
tag in linux-rt-devel. So, except for the changes to make it work
on v5.15.49-rt47 in linux-stable-rt, those patches should represent
what ended up in 5.17.1-rt17, right?

Greetings,

David
