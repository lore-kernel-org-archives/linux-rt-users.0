Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D28C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jan 2022 21:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbiA1VIv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jan 2022 16:08:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239231AbiA1VIu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jan 2022 16:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643404129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHTsWtCEcr+IGoA4512/UAmxtgoR+fdwcw5F/tr4kO4=;
        b=O0n0oYnVh0kbCLVJZjd+ZVDssk/GPkZ4Xkzsra5qe4IsgXFxIwCFQct1fes9jOCmY/xaZL
        Z9mrTdjZVMuBEQo86HvVBr5vHcIY8YqHylPT3CkJZaEdE4s2vR6XmqoVmp+VJ7o+m4C23/
        Nsn3pVbd2EQBE4H+jMbXvqyEXpqcnL0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-ok4NsaoUNxiC7o6mGJlbcw-1; Fri, 28 Jan 2022 16:08:48 -0500
X-MC-Unique: ok4NsaoUNxiC7o6mGJlbcw-1
Received: by mail-qk1-f200.google.com with SMTP id t79-20020a37aa52000000b0047ebe27cb48so5743971qke.16
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jan 2022 13:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=KHTsWtCEcr+IGoA4512/UAmxtgoR+fdwcw5F/tr4kO4=;
        b=OF/nc7PQKZRirlSvnlqTpit+tcpB1gw0+02iPdF6y/k4VOJnjeYiGhiQUrsYsc+QZx
         jh94g4eRxZ/JkO/xehpvfyuZbeuIv5STazeugXUqxP+DZVqEdKRkn9p2NxETurlBUKLW
         AW5WtyfsB4kWt7x+ofPvDaMJb9SssnqO7XWhVH8ehFH7iFQKoEpRS/xVKUn5WlRVux2V
         hPUQYS29GVhVEnII9XEqU2xgq4SBx+PQYpaXZJ/ZKzKtpkOPrqhsyVknLxg6Y5ckT/f6
         CQZPwOUsgQlr6/ZNVt/mKyUYYhZg94OYMgySQ5Z4ikI9nAZKlXLB/MDeEiKf6a7ySW8N
         E3fw==
X-Gm-Message-State: AOAM5312uvyXCWZaYM8FMLVDw1b6eotR/oR73Cf5ZkjTsQIxAYsaGZYm
        cbxUa36V+w95sIz/uPQAQ1IoG5OD1QQkiT248Woa9sFP55C0wkaddM89xe1oOc2e1PywTW7x4MH
        Q7r+onO7AdANYv/JE0E13z1NULPo=
X-Received: by 2002:a05:622a:1a18:: with SMTP id f24mr7520720qtb.433.1643404127616;
        Fri, 28 Jan 2022 13:08:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjTDrLj9dnKA7bzAKUhlbavmcEiKTjLZmO/RSDsn0gunRct6DI+lzz7ZJqKLOB8koM+xPITg==
X-Received: by 2002:a05:622a:1a18:: with SMTP id f24mr7520708qtb.433.1643404127406;
        Fri, 28 Jan 2022 13:08:47 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id s7sm4084654qki.20.2022.01.28.13.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 13:08:46 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:08:45 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rt-numa: ignore runtime cpumask if -a CPULIST is
 specified
In-Reply-To: <YfQzN4/oxz9o92Va@linutronix.de>
Message-ID: <97ed969-a641-ae8d-3731-34fab5fab456@redhat.com>
References: <YerAW90QwEg9yXAb@fuller.cnet> <YfBEDR4E2dNK8XzK@fuller.cnet> <YfBFaNrP/1LCgWoN@fuller.cnet> <7ba75eb3-8a8d-65fa-8458-f7f38bad2cb4@redhat.com> <YfQzN4/oxz9o92Va@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 28 Jan 2022, Sebastian Andrzej Siewior wrote:

> On 2022-01-28 12:44:14 [-0500], John Kacur wrote:
> > I agree that our current method is too restrictive, so I like the basic 
> > idea here.
> > 
> > I think we also need to differentiate between -a with no arguments
> > and -a all. -a with no arguments should inherit the cpumask from the 
> > runtime environment but -a all, should be the same as specifying all the 
> > cpus and ignoring the inherited cpumask.
> 
> do you consider number of online CPUs to not deploy more threads than
> CPUs online in case some were shutdown?

Not sure I understand your question, but what I am saying is that we can 
inherit a cpumask that has less cpus than cpus that are online. So in the 
case of -a, just use the cpus available in the inherited cpumask
in the case of -a all, use all available cpus.

> 
> > Thanks
> > 
> > John
> 
> Sebastian
> 
> 

