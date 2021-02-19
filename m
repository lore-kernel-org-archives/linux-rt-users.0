Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ACFC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0228A6024A
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBSQ4H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSQ4H (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:56:07 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D28C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:55:26 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id a1so2864729qvd.13
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=BeJJWBUjKlXdkA0cSxnNgwthGFTbtMHF9+GZ3MYjw2s=;
        b=XrRqTogCZjz0PiqYs6nBlcPZ4amKI3py6NlpzJGLga7XlNgLDJwyRYNjA26PNHObCx
         OCF7hwEFlzYjZrn01alA3cMLEgibYQShjQhlWbfHB+A1bm4Oi1My0Y7YfsRgS0feAKWU
         bOR81oQLJ3u0gxTaCOkIfUGJB5/iadGkmM8DcENZbP421oHndP7gjv/m33qoQ1SAw6UZ
         xB8VU7I8H/Ph0RAtGiaqGaRuRf/p3pV3OSuF9QoGdpoBNHPx2XdM4HY6MPZrZIaDMsgF
         996u2gKO2VaBkEc1uwCu5LPoMVaSOimHf4BqnGNKDrErlE6FM+Y2OnmdcFtKiaw3Vcsc
         y+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=BeJJWBUjKlXdkA0cSxnNgwthGFTbtMHF9+GZ3MYjw2s=;
        b=SoFlyn/HENeaPLMrBHr32c7ehlUmgb8NFsBT/FJhrm+qdmKz1/64dvE19eUIKs2AHt
         7726fTxB5GPai9Zn26VLB5nmr0rlLCr9ZFjlUjOV+i5DUIhmGnUJPxGZoJf6h3M6lY0b
         xzlcH52bVchRPxpbZHJA0udwc0gGsCgj+5S7DtnJxZk3lDe9p7kH/d6cijMJxcSLUZxQ
         tYBJMKBc0Imi7DkhH0TmP4GKoXkSdcedCtnnsQrB0HWxVNMOYHn/7jqavhIWqEPhzvO9
         DWbcWTP3Dr9Hezz5YTAP6Ao9IrCCp6isgNfgpCKTjDKPaTKwooZ+GRyJUA0/O7Fw9Lna
         K2kw==
X-Gm-Message-State: AOAM532h+BWd0/QuY03a9ZyeID60ydu2xYF5rRHuyM4FTJ5ZX5fUMPDX
        DPS8fdTSnf6rUMLHAmnjSv4=
X-Google-Smtp-Source: ABdhPJzid6OI5+cuP8KYJX9ZZSPY+qxZ4490jjYQ96j+XVxlRdhMIomrtV8pTDt38v73Eu4VskxB1w==
X-Received: by 2002:a05:6214:292:: with SMTP id l18mr10215744qvv.5.1613753725909;
        Fri, 19 Feb 2021 08:55:25 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id r10sm5663658qtn.21.2021.02.19.08.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:55:25 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 19 Feb 2021 11:55:24 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Peter Xu <peterx@redhat.com>
cc:     Daniel Wagner <dwagner@suse.de>, linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all
 possible cores
In-Reply-To: <20210219163930.GG6669@xz-x1>
Message-ID: <29eb6a77-fd8b-1c95-bf46-ac16bcc072db@redhat.com>
References: <20210218192729.116427-1-peterx@redhat.com> <20210219081611.xsugonlz7dl4zhvx@beryllium.lan> <20210219152417.GE6669@xz-x1> <20210219162019.giw2yy25vjuzc56f@beryllium.lan> <20210219163930.GG6669@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 19 Feb 2021, Peter Xu wrote:

> Daniel,
> 
> On Fri, Feb 19, 2021 at 05:20:19PM +0100, Daniel Wagner wrote:
> > On Fri, Feb 19, 2021 at 10:24:17AM -0500, Peter Xu wrote:
> > > Yes I explicitly avoided touching parse_cpumask because I don't want to change
> > > behavior of other tools if I'm not confident with that.  Would above two
> > > patches fix oslat too (which I didn't check)?  If so, I'll be fine to have this
> > > patch dropped.  Otherwise I tend to prefer fixing oslat first.  We can further
> > > rework the common code, but if existing tools are fine, then I don't think it's
> > > a bugfix, so no need to rush.  While I'll count this patch as a real bugfix, so
> > > I'd hope we could consider merging it earlier.
> > 
> > As I said, I would really appreciated if all tools behave the same
> > way. Having oslat be special is going to be pain in the long run. Just
> > update parse_cpumask, it's not that difficult :)
> 
> Oslat is broken now after the numa rework.  Frankly I'm surprised it's broken
> so quickly with just a few commits and actually with no new feature at all but
> pure cleanups.  Again I still appreciate all your work on this but I don't
> really appreciate a lot for having it broken..
> 
> Now I tried to fix it but it seems you don't really like my fix.
> 
> Would you propose yours instead?  I would be more than glad if your version is
> better then I'm happy to drop mine.  Otherwise I'll still prefer to have this
> patch merged to unbreak it first.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
> 

Hey, I accepted your patch, we're just discussing how to make things work
in the best way for the whole suite in the future.

Thanks for your patches!

John
