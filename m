Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439D9C63777
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 15:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A32120747
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK+M60qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgJ2PfZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgJ2PeJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 11:34:09 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78752C0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 08:34:08 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id v18so3488316ilg.1
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=AzutPoQ0px8X21Z+Eg60d/SORzFzJi/gHbrphVcMVj0=;
        b=WK+M60qvhj1slz3T/kz5B/28jOkLkoijJGsn1ZhAyeolLwcUFd1Ff/du4NdYCZodIj
         NKDUnMMiaxwMCJSJ1rjgcYk5IpCMzIGy4gHd6xiUrt+6Rk6vGZWpjjrzJdUfpwprLSRF
         MnC7rVHgTWu+YyuoapkhmzG3kNxEUHdCUfukpwv99emVmVYl0WfdF9rFa4JTC5uItl2T
         rB0PhiwrHID70NPABQADatgNt/ya+7865waYP2fQFJK3QLoXmMACZy8Wb47P2FMDFb8l
         G7J6FAB4Hnnde0w/D0KGe+HkF2oidqs3DfSFGRdbelT12T+bYTPpUSWbogCfsRli7CZ4
         hg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=AzutPoQ0px8X21Z+Eg60d/SORzFzJi/gHbrphVcMVj0=;
        b=rde5nCzuolSkOey2Bv3Qy06AU5komwVUJHmBK9FY4+/DiitnxSiFILcpqufx04+ZO/
         JKxPoJ1X4d3u3IyCaiUl0BRjLoPjW9Ju2PhFWyAKTCWIit9lrxFpjIqSVDta0d36ZetW
         qzFAomPH9cQBT5eERb06nZ+4pHOdNDBgl9VJfOF//YHku4lynz1lxCIIsfNx1wnWiqOS
         MrFSXieWa6T2oVeoFR6zZmS2F95RRfpvne5UF7nBwsM5RGMYX+pptnW2CSmigDVZp8ui
         tP/QTgiNtMWD95mGv8G7UvPHzJa5ROb0nvPJt4oCRhsRUpSHDFYGWN8sk34R9O9FNn/K
         WNnQ==
X-Gm-Message-State: AOAM530FLyea1Bc9uquvVl47Z/uBPZiU2xR3Py95ciBdN3TIJJKaHeSy
        19BarsUIxxUcIHw8mokFUBioq2uCPicd/g==
X-Google-Smtp-Source: ABdhPJyDfO5IEpSpiP4sRREp3c5Sm6c0+zkDgtDsjA5ARkcGltG+pAnoGOtSX3zG91e3T0GGqpCM3A==
X-Received: by 2002:a92:8406:: with SMTP id l6mr3254029ild.12.1603985647565;
        Thu, 29 Oct 2020 08:34:07 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id p15sm2230158ioh.27.2020.10.29.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:34:06 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Thu, 29 Oct 2020 11:33:57 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     dieter@bieler.li, linux-rt-users@vger.kernel.org
Subject: Re: Error-Report rt-tests
In-Reply-To: <20201028164059.m7ygqaikxqox6res@linutronix.de>
Message-ID: <3cb8be1a-3e69-dbcc-363-30c1a15e3afd@redhat.com>
References: <006101d6ab85$88d32f70$9a798e50$@bieler.li> <007501d6ab85$f3369910$d9a3cb30$@bieler.li> <20201028164059.m7ygqaikxqox6res@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 28 Oct 2020, Sebastian Andrzej Siewior wrote:

> On 2020-10-26 11:51:24 [+0100], dieter@bieler.li wrote:
> > 
> > Hello,
> Hi,
> 
> > I tried to compile the rt-tests-1.9 on my system:
> > Kernel - 5.4.70-rt40
> > Gcc : gcc cc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0
> 
> is this by any chance 32bit? Say i386/i686 or so?
> 
> > Error message:
> > 
> > 'bld/cyclictest.o: `stderr@@GLIBC_2.2.5' can not be used when making a
> > shared object;
> > recompile with -fPIC
> > 
> > Any idea ?
> 
> If so, please try
> 	make clean
> 	make CFLAGS=-fPIC
> 
> > Thanks
> > Dieter Bieler
> 
> Sebastian
> 

It's a bit odd because the libraries are static.
Isn't that quite an old version of glibc as well?

John
