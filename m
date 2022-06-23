Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A95C43334
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jun 2022 12:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiFWMDW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jun 2022 08:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiFWMDK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jun 2022 08:03:10 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C04EA26
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 05:02:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F0D616141887;
        Thu, 23 Jun 2022 14:02:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ODogzjK5POzB; Thu, 23 Jun 2022 14:02:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 911F961B8B4F;
        Thu, 23 Jun 2022 14:02:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PbpC0lVei8OP; Thu, 23 Jun 2022 14:02:44 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 716986141887;
        Thu, 23 Jun 2022 14:02:44 +0200 (CEST)
Date:   Thu, 23 Jun 2022 14:02:44 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     bigeasy <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com
Message-ID: <1958751921.205825.1655985764383.JavaMail.zimbra@nod.at>
In-Reply-To: <YrRNJqo94yLPDa7Z@linutronix.de>
References: <20220622110506.10534-1-richard@nod.at> <YrRNJqo94yLPDa7Z@linutronix.de>
Subject: Re: [v5.15 0/4] Backport MEMCG changes from v5.16
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Backport MEMCG changes from v5.16
Thread-Index: yfHtI7O0iMLSiCgLjmoIcV6N9kXsrw==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sebastian,

----- Ursprüngliche Mail -----
> Von: "bigeasy" <bigeasy@linutronix.de>
> An: "richard" <richard@nod.at>
> CC: linux-rt-users@vger.kernel.org, williams@redhat.com
> Gesendet: Donnerstag, 23. Juni 2022 13:23:18
> Betreff: Re: [v5.15 0/4] Backport MEMCG changes from v5.16

> On 2022-06-22 13:05:02 [+0200], Richard Weinberger wrote:
>> This is a backport of Sebastian's MEMCG changes to v5.15, with these patches
>> applied,
>> it is possible to use memory cgroups together with PREEMPT_RT on v5.15, just
>> like on v5.16.
>> 
>> Richard Weinberger (1):
>>   Allow MEMCG on PREEMPT_RT
>> 
>> Sebastian Andrzej Siewior (3):
>>   mm/memcg: Disable threshold event handlers on PREEMPT_RT
>>   mm/memcg: Protect per-CPU counter by disabling preemption on
>>     PREEMPT_RT where needed.
>>   mm/memcg: Add a local_lock_t for IRQ and TASK object.
> 
> So you took the four patches from v5.16 and added it to v5.15.

Exactly.

> I would prefer taking what ended up in v5.17 as of v5.17.1-rt17
> 
> - 0001-mm-memcg-Revert-mm-memcg-optimize-user-context-objec.patch
> - 0002-mm-memcg-Disable-threshold-event-handlers-on-PREEMPT.patch
> - 0003-mm-memcg-Protect-per-CPU-counter-by-disabling-preemp.patch
> - 0004-mm-memcg-Opencode-the-inner-part-of-obj_cgroup_uncha.patch
> - 0005-mm-memcg-Protect-memcg_stock-with-a-local_lock_t.patch
> - 0006-mm-memcg-Disable-migration-instead-of-preemption-in-.patch
> - 0007-mm-memcg-Add-missing-counter-index-which-are-not-upd.patch
> - 0008-mm-memcg-Add-a-comment-regarding-the-release-obj.patch
> - mm-memcg-Only-perform-the-debug-checks-on-PREEMPT_RT.patch
> 
> since this is what finally landed upstream. So we don't have an
> intermediate step from an not supported kernel in a supported one.

Okay. 

Thanks,
//richard
