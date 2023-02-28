Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B465C64EC7
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Feb 2023 12:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjB1MvX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 07:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB1MvW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Feb 2023 07:51:22 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E03A2BED7
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Feb 2023 04:51:21 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id i9so13011651lfc.6
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Feb 2023 04:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677588680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bHqUh8OQDG6rDz63kVBgv6XGN6bgRLWoC4HoaBiC85I=;
        b=A4o1YkyhHr/g+BcxRzG+4YIE/YWep/14XFQtbkeBY9qiRWslp40IXJFN28tlsClVQx
         aGEAY/qNoqzWxAQqQJDw2R9TlGMZ5vF9Yo18+qvGuVnjVRuXJdQ79Rm8u074h/PS529Y
         ThZ2Ljl/+kkGxYAXYalsgP6m4PJE2YRB5eJy+ttP5qOsZpXcFaNlLCN6GvEmcJCfOiK+
         KtO7xMjCguLbqi5qdCi0uX5HCHJGVb5KhYsyxp7JBEm5GCbu/zhNOqn/9Ho+WDoIdUJ/
         cWl8x/7IFoa0FYcC8RoG5zYx97vLYLy2ApciygAQXD11zH9gUKo3VJVsAgRmsK4W2RFq
         ow7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677588680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHqUh8OQDG6rDz63kVBgv6XGN6bgRLWoC4HoaBiC85I=;
        b=y0qL0nrdVVMdjMiIMx9PuwR/2L1H/P2m5gnIjX1ypb0uoTJbcOzS7zPGqLu237qC7I
         JOJXZ7bXTMZCIgR8wsEf3NIGUTUMFiTT4qGBCVD+srisNeS8fnPmJsSba2i7x72TVZuI
         UKyVcr0NqzLISKcsJruzpjgL2hz8+FWK13FoPSCRczb3V3Mr1g1y5bZzTd6pCnwKl7Ng
         QBK9xpiTD/EXBI3DfOBt2TQ3DeDtrEG98hH6oMyldPmenrF+Eq/sBDh67Z5JrOwByke8
         YeJUPKBbyg06QapnlEIE3V2oaFI9uWR4/8RuqHOlrSPZBjuMlNrk2KBiZovlXcBAShGT
         70+g==
X-Gm-Message-State: AO0yUKWRJ5WbtUUVfkkKKKzDlrGMz+SZA3mt1aTXSMRB5BqkYmJyaKPf
        yuoqh0fnAhYLFMB2pMtyBciSrGwS4MiNngpO/KWIpin0prw=
X-Google-Smtp-Source: AK7set/FNETa9xAZAahtrdzh3VrRDXrsnl+eYwP4dFb0MZVBFSfBxpSMCCH9j2ZPMXO15QZBoMkPEqWF/FHT2KI5tfU=
X-Received: by 2002:ac2:4432:0:b0:4db:38ba:618d with SMTP id
 w18-20020ac24432000000b004db38ba618dmr677941lfl.12.1677588679695; Tue, 28 Feb
 2023 04:51:19 -0800 (PST)
MIME-Version: 1.0
References: <CA+cAkeoDrm-33JkuL6nQa7s7foqdCWvwt9Y9PZa5Qj58gATqtQ@mail.gmail.com>
 <CA+cAkeq+z8D3j7FQFrW4BxfS97a490B_U3yskYm8+oatYfxZAg@mail.gmail.com> <Y/yrHe4OIYcWFbNO@linutronix.de>
In-Reply-To: <Y/yrHe4OIYcWFbNO@linutronix.de>
From:   =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= 
        <frederic.martinsons@gmail.com>
Date:   Tue, 28 Feb 2023 13:51:08 +0100
Message-ID: <CA+cAkerxCFdNfJaR=WJO9fbbLk5DvpgRxxQ6sMrUUgLr_kBsbQ@mail.gmail.com>
Subject: Re: Kernel lock during cryptsetup luksClose
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

>
> That has been used before and the rcu-wait mechanism is what we use
> upstream. That revert should case no harm.
> I would need to reproduce this to figure out if this is a generic
> problem or if the backport is bad.
> Basically speaking (and you could add printks to figure that out)
> manage_workers() should wake on task and that should be the one waiting
> in put_unbound_pool(). But this is somehow not happening based on your
> description.
>
> Sebastian

Thank you very much for the answer. I added printk in put_unbound_pool
with the following patch:

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a9f3cc02bdc1..5aacb02b8ec5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2025,7 +2025,9 @@ static bool manage_workers(struct worker *worker)

        pool->manager = NULL;
        pool->flags &= ~POOL_MANAGER_ACTIVE;
+       printk(KERN_INFO "manage_worker call rcuwait_wake_up , created
pool id %d, node id %d, refcnt %d", pool->id, pool->node,
pool->refcnt);
        rcuwait_wake_up(&manager_wait);
+       printk(KERN_INFO "manage_worker rcuwait_wake_up end, pool id
%d, node id %d, refcnt %d", pool->id, pool->node, pool->refcnt);
        return true;
 }

@@ -3371,20 +3373,21 @@ static void put_unbound_pool(struct worker_pool *pool)
 {
        DECLARE_COMPLETION_ONSTACK(detach_completion);
        struct worker *worker;
-
+       printk(KERN_INFO "put_unbound_pool starts pool id %d, node id
%d, refcnt %d", pool->id, pool->node, pool->refcnt);
        lockdep_assert_held(&wq_pool_mutex);

        if (--pool->refcnt)
                return;
-
+       printk(KERN_INFO "put_unbound_pool starts 2, pool id %d, node
id %d, refcnt %d", pool->id, pool->node, pool->refcnt);
        /* sanity checks */
        if (WARN_ON(!(pool->cpu < 0)) ||
            WARN_ON(!list_empty(&pool->worklist)))
                return;
-
+       printk(KERN_INFO "put_unbound_pool starts 3, pool id %d, node
id %d, refcnt %d", pool->id, pool->node, pool->refcnt);
        /* release id and unhash */
        if (pool->id >= 0)
                idr_remove(&worker_pool_idr, pool->id);
+       printk(KERN_INFO "put_unbound_pool starts 4, pool id %d, node
id %d, refcnt %d", pool->id, pool->node, pool->refcnt);
        hash_del(&pool->hash_node);

        /*
@@ -3394,6 +3397,7 @@ static void put_unbound_pool(struct worker_pool *pool)
         * Because of how wq_manager_inactive() works, we will hold the
         * spinlock after a successful wait.
         */
+       printk(KERN_INFO "put_unbound_pool lock pool id %d, node id
%d, refcnt %d", pool->id, pool->node, pool->refcnt);
        raw_spin_lock_irq(&pool->lock);
        rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
                           TASK_UNINTERRUPTIBLE);
@@ -3403,6 +3407,7 @@ static void put_unbound_pool(struct worker_pool *pool)
                destroy_worker(worker);
        WARN_ON(pool->nr_workers || pool->nr_idle);
        raw_spin_unlock_irq(&pool->lock);
+       printk(KERN_INFO "put_unbound_pool unlock pool id %d, node id
%d, refcnt %d", pool->id, pool->node, pool->refcnt);

        mutex_lock(&wq_pool_attach_mutex);
        if (!list_empty(&pool->workers))


And I have the following associated traces before the lockup:

[   45.017508] manage_worker call rcuwait_wake_up , created pool id 5,
node id -1, refcnt 1
[   45.017514] manage_worker rcuwait_wake_up end, pool id 5, node id
-1, refcnt 1
[   45.076736] put_unbound_pool starts pool id 5, node id -1, refcnt 1
[   45.092553] put_unbound_pool starts 2, pool id 5, node id -1, refcnt 0
[   45.099022] put_unbound_pool starts 3, pool id 5, node id -1, refcnt 0
[   45.105762] put_unbound_pool starts 4, pool id 5, node id -1, refcnt 0


So it seems that it is the line hash_del(&pool->hash_node) that never returned.

Sorry but I have 0 experiences in kernel hacking but if you tell me
what info should be printed to help you
pinpoint the issue, I'll do it.
