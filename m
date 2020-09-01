Return-Path: <SRS0=uG0Q=CK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E04C433E2
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Sep 2020 07:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C23204EC
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Sep 2020 07:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qPIad0Ut";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dzQfVqij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgIAHlL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:41:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38234 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAHlK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Sep 2020 03:41:10 -0400
Date:   Tue, 1 Sep 2020 09:41:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598946068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a01kqMrBzYwGWYv4WxVBdnaGp0snBWtL5mk5Fkm/jbY=;
        b=qPIad0UtNn8RTBtF3CXfebJPPt+gcYg1t7+1ElChHoimY7RMJEH6O1WuR/TLS8zR9PiH+D
        wpdMySRyZuHWkFPzzYFMx/c1Qf6EBAyY6Tw+FXPZTy98E0+gLswtz/O7w4x35rqFwac4Vh
        Gt3SeCtWi1RaqhFTqUY/vS3CLZ7PTvQIFL4gTgBSzzQ3j5mU5yxpD1+fj35oIxNLJPaQYE
        L5jges1a3/9lRoE9PyZSUvaIQUkHfLCNQxXE1hOnetzoV3HtuhlEhfhBSjXVJb4WVVxw1E
        FdoW26NsM+EMHC2fipMpvBjF6xdhQkRaPcxUf1icWcwCL7Du6UYwQQFsTEKdBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598946068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a01kqMrBzYwGWYv4WxVBdnaGp0snBWtL5mk5Fkm/jbY=;
        b=dzQfVqijbKR/LqN87VCh+3Qhf2zUfonRqlSZGtnvN+/1fi25PRA5zq4OBL0hANnS6wVtLK
        KKVOkOZVjvRci3DQ==
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     Thomas Graziadei <thomas.graziadei@omicronenergy.com>
Cc:     Mark Marshall <markmarshall14@gmail.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mark Marshall <mark.marshall@omicronenergy.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
Message-ID: <20200901074107.ozrthr5piqu723pa@linutronix.de>
References: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
 <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de>
 <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
 <20200529161518.svpxhkeljafbtdz2@linutronix.de>
 <20200529163722.mdxzrj4n3lyzjtfu@linutronix.de>
 <20200706165004.7m57fvspmwnjcjxh@linutronix.de>
 <eeeae7d9-c028-47f0-ab5b-7983e32f36cb@EXC03-ATKLA.omicron.at>
 <c1ef757b-4cd6-410e-a647-a3303cef4b1b@EXC03-ATKLA.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1ef757b-4cd6-410e-a647-a3303cef4b1b@EXC03-ATKLA.omicron.at>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-12 14:45:22 [+0200], Thomas Graziadei wrote:
> Hi Sebastian,
Hi Thomas,

> any progress on your side?
> 
> Do you think the patch could be applied for the next versions?

Yes.  The ->active_mm change needs to be protected against scheduling
regardless of the arch/mmu. Otherwise the mm will be put twice. For this
to trigger you need to exec from a kernel thread and get preempted.
This will be addressed in use_mm() by commit
    38cf307c1f201 ("mm: fix kthread_use_mm() vs TLB invalidate")

which is in v5.9-rc1 and exec_mmap() is under discussion at
    https://lore.kernel.org/linux-arch/20200828100022.1099682-2-npiggin@gmail.com/

> Regards,
> Thomas

Sebastian
