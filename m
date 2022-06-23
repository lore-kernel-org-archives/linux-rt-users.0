Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815B9C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jun 2022 11:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiFWLXZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiFWLXX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jun 2022 07:23:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E7929CBF
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 04:23:22 -0700 (PDT)
Date:   Thu, 23 Jun 2022 13:23:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655983400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L6B7HkFj9w8/1GRc5qCrc7c780engZlmFFoF2UE02no=;
        b=RSEjS9WDkJozo0jkcAVnn9aqvScSKLPVSssWy2xq8D0DpuY7LqE6BhsNS6Aj7heFIAPTzU
        Bo7FlmW8KLRyoXfmyWZ3yCt2T9JhbfqhGDibUVwHE31NmJomgorFCA9gf4G5T3aZyqFEz2
        8CuWWE1jRPLjhzBe5aqEjjQ5K0ACg1QUgHJqqyJG+iJVf00rM/BID+tSINrNQuaWX8GRGG
        UhYRQbERnIrPM3UJXJ7yM5CrVvhR0q1dh2hLTQcwXigaqwJo05peoWxQxZBb2idC+g6Oki
        xM9ieuuNbCwnDk8GDdS6XWYbHLtReKbl4761+wSMCFVKZ/CsYxZv+vqFoVvOcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655983400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L6B7HkFj9w8/1GRc5qCrc7c780engZlmFFoF2UE02no=;
        b=rAg5vfqUd3UasdIU2CaieEKKoRiq7nJLeNdJhbxHAetTkxJoOnafi8HJ14SF/NzalWqQAM
        rGiPUjalMc4vM5CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [v5.15 0/4] Backport MEMCG changes from v5.16
Message-ID: <YrRNJqo94yLPDa7Z@linutronix.de>
References: <20220622110506.10534-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622110506.10534-1-richard@nod.at>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-22 13:05:02 [+0200], Richard Weinberger wrote:
> This is a backport of Sebastian's MEMCG changes to v5.15, with these patches applied,
> it is possible to use memory cgroups together with PREEMPT_RT on v5.15, just like on v5.16.
> 
> Richard Weinberger (1):
>   Allow MEMCG on PREEMPT_RT
> 
> Sebastian Andrzej Siewior (3):
>   mm/memcg: Disable threshold event handlers on PREEMPT_RT
>   mm/memcg: Protect per-CPU counter by disabling preemption on
>     PREEMPT_RT where needed.
>   mm/memcg: Add a local_lock_t for IRQ and TASK object.

So you took the four patches from v5.16 and added it to v5.15.
I would prefer taking what ended up in v5.17 as of v5.17.1-rt17

- 0001-mm-memcg-Revert-mm-memcg-optimize-user-context-objec.patch
- 0002-mm-memcg-Disable-threshold-event-handlers-on-PREEMPT.patch
- 0003-mm-memcg-Protect-per-CPU-counter-by-disabling-preemp.patch
- 0004-mm-memcg-Opencode-the-inner-part-of-obj_cgroup_uncha.patch
- 0005-mm-memcg-Protect-memcg_stock-with-a-local_lock_t.patch
- 0006-mm-memcg-Disable-migration-instead-of-preemption-in-.patch
- 0007-mm-memcg-Add-missing-counter-index-which-are-not-upd.patch
- 0008-mm-memcg-Add-a-comment-regarding-the-release-obj.patch
- mm-memcg-Only-perform-the-debug-checks-on-PREEMPT_RT.patch

since this is what finally landed upstream. So we don't have an
intermediate step from an not supported kernel in a supported one.

Sebastian
