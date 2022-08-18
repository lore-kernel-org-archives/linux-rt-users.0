Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F0EC00140
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Aug 2022 15:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbiHRP4v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbiHRP4e (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Aug 2022 11:56:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D065DC
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Aug 2022 08:56:00 -0700 (PDT)
Date:   Thu, 18 Aug 2022 17:55:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660838159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3yO877OsGQib7c3yFw5KihHi8i446fMMJCGBlTPyA4=;
        b=mnmZQDIZAOHkCZ3dqym5YZE7Y5xV/vUDRJkFdw52eBhdF0sQTU0jwrfDXvFSi9lwTdJxDo
        BA0bhoSAUkv74jXIIjGvpE+/lUecITPRIRTWZP6gm952/wtlujuVmM9DpWQ6GMwdO/pnxT
        626EqU0Oup/TwPEEZ1qfa7RjlvpM6oqio4A5mhatWFlfNv1lvN+5mWH75uoDMt+BhfZBKk
        Aypi3Vl6YBS67ldNuEt59kiMK0O14cwW3fGroy3I5aPA+oxb8u7Hbg8zyu46FrXFJVozGn
        98H+FC43GQ/mH+f7cK02w8VQYPq2R8jUfmFcKR9/8r5S4tpS3kfIgwqS6sFDSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660838159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3yO877OsGQib7c3yFw5KihHi8i446fMMJCGBlTPyA4=;
        b=1vr7TyqDC3YFL/Yb9MevNSr275uaZNTvrhcx6Bf5wOmmS9ujUqjcDJswztgMEssJqZtp9G
        LMqqPn3pA6tiK0Dg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Oberhollenzer <goliath@infraroot.at>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        richard@nod.at, joseph.salisbury@canonical.com
Subject: Re: [PATCH v2 00/10] Backport MEMCG changes from v5.17
Message-ID: <Yv5hDthdk5REuJEh@linutronix.de>
References: <20220808125602.97747-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220808125602.97747-1-goliath@infraroot.at>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-08-08 14:55:52 [+0200], David Oberhollenzer wrote:
> This is a backport of Sebastian's MEMCG changes to v5.15. With these
> patches applied, it is possible to use memory cgroups together
> with PREEMPT_RT on v5.15, just like on v5.17.
> 
> The patch set was tested on my end by building an x86_64 kernel
> with PREEMPT_RT, cgroup debug and lockdep enabled. The kernel was
> run in Qemu, where a small number of child cgroups were created,
> with memory controller enabled for each and an instance of a small
> test program running.

This looks good, thank you.

Sebastian
