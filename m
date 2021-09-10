Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1254C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 13:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A4B61167
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 13:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhIJNet (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 09:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233230AbhIJNes (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Sep 2021 09:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631280817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N7xXcGHMUs/Wg9j2dc3lT0r3M8QRHdv0xEqXqfTyuuw=;
        b=E0/Lm2Y6O8QchfNo+L+TO+99m9U3k4Hz78UhQerzBs8CApS1tXpM/DDNtmydNbdaOTUEAA
        o0s7C/Zhe4M7uYU6yv57Jmc+m1JM7ouNu+2DkIwqqR7kLF67k6xgmpFgOwqnXe9yFTgPyy
        ALyoA8G09MOxbZTH/u75Q17W3ZQPzaw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-5NVFBT8aMLKxIifMrQUbzQ-1; Fri, 10 Sep 2021 09:33:07 -0400
X-MC-Unique: 5NVFBT8aMLKxIifMrQUbzQ-1
Received: by mail-io1-f71.google.com with SMTP id g2-20020a6b7602000000b005be59530196so2740692iom.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Sep 2021 06:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N7xXcGHMUs/Wg9j2dc3lT0r3M8QRHdv0xEqXqfTyuuw=;
        b=V3oG0GHCeUl8oTNvhlnXIWo/PrvqIV3aGtZ2cKheS8AVzjhX2kLfcxzTpxgqgp+msy
         j0rwxHIdsP1jwrQBccryrnXrKk0CTC/2/KBr7QJZ05rsiqTac3ikytgdZTRMpI3PODqh
         SfS4+rN2Qs2QLm24wd03DceQlILdQiMNKgAH+9u9dYufMxtF40QJxu5o47eMlrEgOPnx
         bhr9vPKSnY5/DLM3ZgcMC1W4AOQb7e8yBoLlaVwLEsB1JIxEnAJXEv322N0XxVMhrZpR
         vyDdKjeZR+9T062nOR7XyQfsxSTNDFTRh7RYNMZQGC9/kcVyWs5dw23b0OhbAu9CFwEp
         MT5Q==
X-Gm-Message-State: AOAM530oTYYLncMXKseQQdz5Vv5v9XqxuCtxop9AJlT3b269RDbB1iVa
        iR862Ndd01w2o5ky8LR233oZ4llyUafgwCIeYewDlpzXq1eofcvmw6Hlkvyp/9OZMZtaR5PZHw/
        vsVPQVv+amAAFjPSVYwm+2KP39Wg=
X-Received: by 2002:a05:6638:419e:: with SMTP id az30mr4548911jab.90.1631280787235;
        Fri, 10 Sep 2021 06:33:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhNGhQWPKFaAbGzzt0JTb2OdDw4GQ74T8lw4HZJb7E7+uD7XlttVoci/4/ZRDlfdB3p/55xw==
X-Received: by 2002:a05:6638:419e:: with SMTP id az30mr4548897jab.90.1631280786984;
        Fri, 10 Sep 2021 06:33:06 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id r18sm2506680ioa.13.2021.09.10.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 06:33:06 -0700 (PDT)
Date:   Fri, 10 Sep 2021 09:33:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     nsaenzju@redhat.com
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 2/3] oslat: Add aarch64 support
Message-ID: <YTtekExun9GoaFvc@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
 <20210908100209.118609-2-nsaenzju@redhat.com>
 <YTj8Qgawnh1xPrDJ@t490s>
 <466f7d726df2dfec8ac83a9d3f603439e3cec1b1.camel@redhat.com>
 <YTpMe2+58YxJ0IFM@t490s>
 <6a2eba408dc4260a47c1acfe743474bb39aa93bd.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a2eba408dc4260a47c1acfe743474bb39aa93bd.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Sep 10, 2021 at 02:19:40PM +0200, nsaenzju@redhat.com wrote:
> > I also don't understand why you explicitly removed the compiler barrier.  IIUC
> > when without it the compiler could move these instructions to be before/after
> > other instructions generated in the c code.  That may not really happen in
> > practise, but just curious why the explicit removal.
> 
> I removed it too as I see no justification for it. There is nothing, except for
> the actual timestamp values (which are safe as they come from an mrs), that
> could suffer from the compiler prefetching the value, or reordering accesses.
> I'll add a comment on the commit message.

Again I have no solid example, but wondering whether when without compiler
barrier the compiler would be legal to compile this code clip:

  t1 = frc();
  a = 1;
  t2 = frc();

into something like:

  t1 = frc();
  t2 = frc();
  a = 1;

It's just that iiuc compiler barrier has 0 overhead to us.  No strong opinion
anyways.

-- 
Peter Xu

