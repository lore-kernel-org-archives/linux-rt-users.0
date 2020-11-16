Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A50C5519F
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 11:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED80F2224B
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 11:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Efa0jpkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgKPKdE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:33:04 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:43468 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgKPKdE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Nov 2020 05:33:04 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 6306289DC3C;
        Mon, 16 Nov 2020 11:32:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1605522770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+P9yNAjt+158pLr2kX8CBCVf/7cNZa0GYdEZdsOE7AQ=;
        b=Efa0jpkAOJP11UmUxjE9vPa/dUd7XHXSyAtNPB/kidl4YVnATuwS9NAjXMIIT6iT++3o/X
        RNGoHnVqeNLlxKSQX/xoiKpKMViuRFnU2qmGiQBHqnFxGB+cwOlMSTQzlLrkNihHTHWrkS
        mEYpF/UO1ub4F008XrIC8q8+wiHvVQU=
MIME-Version: 1.0
Date:   Mon, 16 Nov 2020 11:32:50 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org
Subject: Re: WARNING at kernel/sched/core.c:2013
 migration_cpu_stop+0x2e3/0x330
In-Reply-To: <jhjzh3hwq33.mognet@arm.com>
References: <a1fd0d9c6c8cd90a74879b61467ae48d@natalenko.name>
 <jhj3619y63v.mognet@arm.com>
 <41d6aca71c6a52df8437cdb7b4a1b1c4@natalenko.name>
 <jhjzh3hwq33.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <8a9213a22bec71218b66884b560fa9f9@natalenko.name>
X-Sender: oleksandr@natalenko.name
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 16.11.2020 11:31, Valentin Schneider wrote:
> On 16/11/20 10:27, Oleksandr Natalenko wrote:
>> Hi.
> [...]
>> Not sure whether the check is legitimate, but FWIW I've managed to put 
>> a
>> test task [1] (it spawns a lot of threads and applies affinity) into a
>> permanent unkillable D state here:
>> 
>> ```
>> [<0>] affine_move_task+0x2d3/0x620
>> [<0>] __set_cpus_allowed_ptr+0x164/0x210
>> [<0>] sched_setaffinity+0x21a/0x300
>> [<0>] __x64_sys_sched_setaffinity+0x8c/0xc0
>> [<0>] do_syscall_64+0x33/0x40
>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> ```
> [...]
>> 
>> I'm not positive about this being directly related to the original
>> report, but I think it is still worth mentioning.
>> 
> 
> Aye, thanks, that one should be fixed by:
> 
> https://lore.kernel.org/r/20201113112414.2569-1-valentin.schneider@arm.com

Great, thanks, I'll pick it up now.

> 
>> Thanks.
>> 
>> [1] https://gitlab.com/post-factum/burn_scheduler

-- 
   Oleksandr Natalenko (post-factum)
