Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15428C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Mar 2022 16:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiC2Q7k (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiC2Q7j (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Mar 2022 12:59:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E56B0D13;
        Tue, 29 Mar 2022 09:57:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gb19so18087971pjb.1;
        Tue, 29 Mar 2022 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=94zP/jLn1L+Xrank8hwMs73OTAQl/2oxOGU8uUoGhTI=;
        b=W1xfrD0nMlE4TBaKt9iksGu5nMHAKpP7NliAWLypf0K0qenTxU4EELYpz0X3KXiiTx
         bzntRG43EGSIxpZJhNuBlJ2PudeZnte3O0M5cwrr9FMj59HLQppyFRVlYhi/nuiBtdNo
         9YToBE3ptd3Uhr8TaQqfFRwABlpWyO7oERcNXxkyaFOygY/4BZPgdn4n3hM+Fg3dH4sh
         9exd7djH694obC67d5qmvy98iU6C13AqLS6mAyZv2hb1DlnpchhsgKherEvYct8HiEnm
         4ozhME6Rvu4UYrILqoLWp2lgy5+ksCr16XR3o+XV5XTdJoMfeqGoZGQzVDVdn6SICCzl
         Mgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=94zP/jLn1L+Xrank8hwMs73OTAQl/2oxOGU8uUoGhTI=;
        b=MtXp7LzCRWFZgLRw5dBaW9Bp/gZrQIDh8jKr/y5SY3plwgu6eb4dKDq7Drtw/zeCTo
         pOdDd3N7ozr/8eg/oXhvdpm8op/ca8MjZUzRyofxwsi8X4f2ca1EUoRVwf5/FVuHZeP5
         7mHGyVMxzfE1t8ErUkVMMdroC5torxx6Z5AfwV7JPA60uAEZNaf4impoANo3Vm38YGvm
         ppZD/g8f6qgypwkqBn0dviE5OVVYuIqfcsr7SGaJVjND4+Ohktax1JmDJDFmB8iwK3b4
         R87E/bCIJDT820LHjSxWl+w7gtJA6SeaxnF0k6Hz+fNtnijUc+Odh6HcGt6U9/ViM+YY
         XqIA==
X-Gm-Message-State: AOAM531hs7LhzVaXtN8r6bwNgyD9R0le01bBo55qI/KlH4uONWe+idwb
        K5+MRJE9SpVgb4aAvnjocbQ=
X-Google-Smtp-Source: ABdhPJw5hqO9n5W68aIyFix6+aqAO9D2sR5YOlrwcYOt/n8Z2BiEvOzeNScxpb60v+N662TLqh/9xQ==
X-Received: by 2002:a17:90b:4ccb:b0:1c9:c1de:9c9d with SMTP id nd11-20020a17090b4ccb00b001c9c1de9c9dmr71545pjb.105.1648573075693;
        Tue, 29 Mar 2022 09:57:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7749])
        by smtp.gmail.com with ESMTPSA id x38-20020a056a0018a600b004fafd05ac3fsm17848303pfh.37.2022.03.29.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:57:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Mar 2022 06:57:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Esben Haabendal <esben@geanix.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?iso-8859-1?Q?Andr=E9?= Pribil <a.pribil@beck-ipc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] RT scheduling policies for workqueues
Message-ID: <YkM6keHS22ajPks5@slm.duckdns.org>
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
 <YkGIhYKJG+w4L7ge@linutronix.de>
 <20220328100927.5ax34nea7sp7jdsy@pengutronix.de>
 <YkHyzcfiyjLfIVOo@slm.duckdns.org>
 <YkKnlUUsufZPiZxM@linutronix.de>
 <8b21ad64-ea9c-84f2-c798-222c9383e3de@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b21ad64-ea9c-84f2-c798-222c9383e3de@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

On Tue, Mar 29, 2022 at 10:33:19AM +0200, Rasmus Villemoes wrote:
> On 29/03/2022 08.30, Sebastian Andrzej Siewior wrote:
> > On 2022-03-28 07:39:25 [-1000], Tejun Heo wrote:
> >> Hello,
> > Hi,
> > 
> >> I wonder whether it'd be useful to provide a set of wrappers which can make
> >> switching between workqueue and kworker easy. Semantics-wise, they're
> >> already mostly aligned and it shouldn't be too difficult to e.g. make an
> >> unbounded workqueue be backed by a dedicated kthread_worker instead of
> >> shared pool depending on a flag, or even allow switching dynamically.
> 
> Well, that would certainly not make it any easier for userspace to
> discover the thread it needs to chrt().

Each workqueue have a name and it's not difficult to make dedicated workers
created this way to inherit the name. From user's pov, it's not that
complicated - if kttyd (or whatever) is present, the user can twiddle with
its scheduling class and priority.

Thanks.

-- 
tejun
