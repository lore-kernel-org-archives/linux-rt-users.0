Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED16CC19F28
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Aug 2022 06:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiHCGyE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiHCGyD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Aug 2022 02:54:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1804B0E0
        for <linux-rt-users@vger.kernel.org>; Tue,  2 Aug 2022 23:54:02 -0700 (PDT)
Date:   Wed, 3 Aug 2022 08:53:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659509640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eikrkKKIvyjhgb4ZVBPwEXgSU8aiwUc/Q+TNVxk/Dyg=;
        b=J6YSK+5xSY/DimMeuJVQnSWeVpjXdREVgDKYfSVwjXN+aznwIA+3tyh2yaSfOBwuVu/iT0
        3ivLybXfRqSe2w4/H7oFZARMv8kR+2r4N6G3BlIHS8Tp9hLryZOjI4+x8ykJ+hEdVvBRt9
        Chg8gF8a7dNh2bLZyu0XBAlv+H5FPq8MW2VxUsj5whOLkcvfNKjFKAHE5fB6sV/GkUq2MP
        ypNf0tScYVzDXt2BTaLRCA1dSgZ+zrxwa/vB51wW6M0xzkwPTvh1W7SEeY6hJYJS71OUDf
        nilVJPNHaStWMhbhoLpm3iQAX6l1/zB4qgmESktnt3aHwRMqM/jc7Ezf5Xtw3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659509640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eikrkKKIvyjhgb4ZVBPwEXgSU8aiwUc/Q+TNVxk/Dyg=;
        b=oZ2490u9CDmz/bBrlxKPF/oqAWxnM7074BPTJmCQBEihrbVeyLfjUtbfGOBsIA+q7l7KNT
        eY5tmGBOmIBQDLCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Oberhollenzer <goliath@infraroot.at>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com, richard@nod.at
Subject: Re: [PATCH 0/4] Backport MEMCG changes from v5.17
Message-ID: <Yuobh/+/Sv8VTjTP@linutronix.de>
References: <20220712112238.18824-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220712112238.18824-1-goliath@infraroot.at>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-07-12 13:22:34 [+0200], David Oberhollenzer wrote:
> This is a backport of Sebastian's MEMCG changes to v5.15. With these
> patches applied, it is possible to use memory cgroups together
> with PREEMPT_RT on v5.15, just like on v5.17.

This isn't the series that was merged upstream:
| 0001-mm-memcg-Revert-mm-memcg-optimize-user-context-objec.patch
| 0002-mm-memcg-Disable-threshold-event-handlers-on-PREEMPT.patch
| 0003-mm-memcg-Protect-per-CPU-counter-by-disabling-preemp.patch
| 0004-mm-memcg-Opencode-the-inner-part-of-obj_cgroup_uncha.patch
| 0005-mm-memcg-Protect-memcg_stock-with-a-local_lock_t.patch
| 0006-mm-memcg-Disable-migration-instead-of-preemption-in-.patch
| 0007-mm-memcg-Add-missing-counter-index-which-are-not-upd.patch
| 0008-mm-memcg-Add-a-comment-regarding-the-release-obj.patch
| mm-memcg-Only-perform-the-debug-checks-on-PREEMPT_RT.patch

any reason why not backport those?

Sebastian
