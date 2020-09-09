Return-Path: <SRS0=FZAt=CS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD2C43461
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 05:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5918521941
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 05:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhopoWIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgIIFvS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725983AbgIIFvQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Sep 2020 01:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599630675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=il5f2exuzL5JakB/RTDDV/wE8hpRfPQoB+xkGYphses=;
        b=IhopoWILrOhB/PAnjNb3E4l4Kb0HXBBS9cYKzx+SABDOu4t2qxFyzYuwRlb/RMCx3AEHJI
        1W0cvKaBlCAzr0EGNFCN+97u7rkFSQN8akg8xPuRN4k8NcUKRyEMUlafdI/qkTVtoKFzTa
        kz1Rw8ZwJZSz3mUm6ibymKoz0KB/mqY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-vv31TV9bOnu9bKtuai5VCQ-1; Wed, 09 Sep 2020 01:51:08 -0400
X-MC-Unique: vv31TV9bOnu9bKtuai5VCQ-1
Received: by mail-wr1-f69.google.com with SMTP id k13so532908wrl.4
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Sep 2020 22:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=il5f2exuzL5JakB/RTDDV/wE8hpRfPQoB+xkGYphses=;
        b=CBO0T9MvimWb+cUPIjU79dL45W4B6Eh3JImxD/sXvjvAaWf/ON7qvyd6f29ng8odqq
         GZYpGeCCgXt99HieX63FPhs5czSYq+i1PXgLaRi6xamZadhcG4bdQ1TFZIc4aeQlZKUT
         z2SmuC0KSJ3ksWE4Q7txDzYmK1++HnlQC9a2VSH4bFz4NP9Raoa++9bosCxsFl5laE1o
         NFw4PCuIiRR7gtQfVt61a1KNqFyfGy+gld3F0gRWJXMdNF7Wp9h6Gw2ledaomBnVYLaq
         fDdDdKUU62nP6AyVThSQUdSc0fHmgzfOwLrxh8tZjVTuhuIHuBOQ101r1HPZC6OyYBQp
         djQQ==
X-Gm-Message-State: AOAM533hQoFCNWX/WWRWx13Bq+NnEYkOyll93TRueLWVazrHUyYKbqoR
        Gr+bwapLCHk0EnxvYcfM7AJsXbeSALhFYAduEq+vvjMpYWi4TtFKCNPlBvaoLgMbGXRBTLA7h54
        1E+pyie1jWPNRL9pUqNprz93teKg=
X-Received: by 2002:a7b:c768:: with SMTP id x8mr1885701wmk.189.1599630667671;
        Tue, 08 Sep 2020 22:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMkW1TqwP4Ye4ockimpubn1IIW7MJimFAD5OWipotdjICi8VTmGvrUnlcAK5spXy824A0ytw==
X-Received: by 2002:a7b:c768:: with SMTP id x8mr1885676wmk.189.1599630667450;
        Tue, 08 Sep 2020 22:51:07 -0700 (PDT)
Received: from localhost.localdomain (ca-18-214-147.service.infuturo.it. [151.18.214.147])
        by smtp.gmail.com with ESMTPSA id f6sm2630914wme.32.2020.09.08.22.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 22:51:06 -0700 (PDT)
Date:   Wed, 9 Sep 2020 07:51:03 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 0/6] SCHED_DEADLINE server infrastructure
Message-ID: <20200909055103.GA18215@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200908222252.GC1005@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908222252.GC1005@bug>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Pavel,

On 09/09/20 00:22, Pavel Machek wrote:
> Hi!
> 
> > This is RFC v2 of Peter's SCHED_DEADLINE server infrastructure
> > implementation [1].
> > 
> > SCHED_DEADLINE servers can help fixing starvation issues of low priority tasks (e.g., 
> > SCHED_OTHER) when higher priority tasks monopolize CPU cycles. Today we have RT 
> > Throttling; DEADLINE servers should be able to replace and improve that.
> 
> It would be worth noting what "server" is in this context.

It comes from Constant Bandwidth Server (CBS), that SCHED_DEADLINE is
implementing [1].

> 
> It is not white box with CPU inside, it is not even an userland process, afaict.
> 
> Subject is quite confusing.

Best,
Juri

1 - https://elixir.bootlin.com/linux/latest/source/Documentation/scheduler/sched-deadline.rst#L42

