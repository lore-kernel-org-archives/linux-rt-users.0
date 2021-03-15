Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A24C4332B
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Mar 2021 14:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458D464F2A
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Mar 2021 14:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhCOOnI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Mar 2021 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbhCOOmO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Mar 2021 10:42:14 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC0AC0613D9
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Mar 2021 07:41:59 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id l4so31854375qkl.0
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Mar 2021 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=I63ZnYGpScb9rIFxpsIbArlJHdIryc8D7u8mxQzR5xE=;
        b=SGfRhOq9GByFCWjzF2fPU+s7koATa05qa+vQcwOfw4Gd5T7QqimnJGMCsKQl9cgpmq
         zWTAoWsZN0IWuTUixRpArbUPWrBcMnaJGCu+DF6MzV0BSzUd8fzTder4hDY/zIdoDDTh
         uH/FolTU+mq/KFWAnv2ivB/rBLTMEho6tcvgtCEZ4oSNz/mnF/M9jDUUseCct5QoaIzo
         MBTLkdi8H2CUC9hW+6WwHKgW7q5bj1YpFJHxqhXzCdIQBsfHuntQF4wl26a9m5KIpL8q
         sxA3XRNO1yuoK8L2zmfO3ao0dGyy8RQtxF2rkKbXm5dffE3kKpYwvoWqnYdifBnrp9xy
         0YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=I63ZnYGpScb9rIFxpsIbArlJHdIryc8D7u8mxQzR5xE=;
        b=pGMBH6jDDX1FchaAPJ9SHd98BklHv//WCF8FjiGrd+X4Ko3/NCQTYalHr2C9ePfOtU
         cwm2U/d7EJJjvMnv/UuLo5R/reGLv0/0jUc+a0brvRR/iugF/O/UggZemSG7HTIR5m1V
         twEynPaktBGjP5rRPNxm7qWPWwXTcYqQqK3XuaxucNYvw8vXLdAyVJDnUnH7n3GjDWVo
         hM+RXxb0gu29j/Fp00ec0I54uOSfLX9WxgxI8ARIrWIyX40aeVxYllsCKWfdRkNmgBdP
         FtG+qgdIMmhG1bJQiNazD257a/52q+rG1RoLYwTLrxzV0QFMU0DryJGpJYlMFQpmfbnx
         3/kA==
X-Gm-Message-State: AOAM530Z05i5uhLwKFiTKwBJx/i/Ou66185hzuAkTKVXh0y9N3x2Tzic
        niHu1hX13kxjADyLuIxZv9/8eD0XZK0=
X-Google-Smtp-Source: ABdhPJxmxmKv6A3Z75zJ4Zayq2Hm3ogMbe6kgTUL+dIahruikkK64QEr/G4FR82mc8oslKmGRXz7Ow==
X-Received: by 2002:a37:d2c1:: with SMTP id f184mr25164659qkj.107.1615819318440;
        Mon, 15 Mar 2021 07:41:58 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id l186sm12585278qke.92.2021.03.15.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 07:41:58 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Mon, 15 Mar 2021 10:41:57 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH rt-tests v2 04/14] rt-util: Copy command line before
 getopt_long() is called
In-Reply-To: <20210315085647.6extplrdianzsb4b@beryllium.lan>
Message-ID: <ad71e566-b0b7-1c89-5c7e-c226a8f3b72a@redhat.com>
References: <20210305073500.17926-1-dwagner@suse.de> <20210305073500.17926-5-dwagner@suse.de> <da896064-9c42-9e26-c8e6-2758c28c64cf@redhat.com> <20210315085647.6extplrdianzsb4b@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 15 Mar 2021, Daniel Wagner wrote:

> On Mon, Mar 15, 2021 at 01:47:22AM -0400, John Kacur wrote:
> > 
> > 
> > On Fri, 5 Mar 2021, Daniel Wagner wrote:
> > 
> > > By default, getopt_long() permutes the contents of argv as it scans,
> > > so that eventually all the nonoptions are at the end. This is
> > > confusing in the JSON output, thus copy the command line before we
> > > call getopt_long().
> > > 
> > > Introduce a rt_init() which copies the command line. This makes also
> > > rt_write_json() function arguments a bit cleaner.
> > > 
> > > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > > ---
> > >  src/cyclictest/cyclictest.c           |  3 +-
> > >  src/include/rt-utils.h                |  7 +++--
> > >  src/lib/rt-utils.c                    | 45 ++++++++++++---------------
> > >  src/oslat/oslat.c                     |  5 +--
> > >  src/pmqtest/pmqtest.c                 |  3 +-
> > >  src/ptsematest/ptsematest.c           |  3 +-
> > >  src/rt-migrate-test/rt-migrate-test.c |  3 +-
> > >  src/sched_deadline/cyclicdeadline.c   |  4 ++-
> > >  src/signaltest/signaltest.c           |  3 +-
> > >  src/sigwaittest/sigwaittest.c         |  3 +-
> > >  src/svsematest/svsematest.c           |  3 +-
> > >  11 files changed, 44 insertions(+), 38 deletions(-)
> > > 
> > > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > > index c43dd7cbbd64..3f3b91bab53b 100644
> > > --- a/src/cyclictest/cyclictest.c
> > > +++ b/src/cyclictest/cyclictest.c
> > > @@ -1778,6 +1778,7 @@ int main(int argc, char **argv)
> > >  	int i, ret = -1;
> > >  	int status;
> > >  
> > > +	rt_init(argc, argv);
> > 
> > Why should we call this if we're not using formatted output?
> 
> Yes unfortunately. We only know after we used getopt_long() that we should
> have stored argv, kind of chicken-egg situation.
> 

One more thing, could you please break your patches up into smaller more
manageable sizes?
I would put for example changes to rt-utils in one patch

It might be a pain to then create a separate patch for each test to 
interact with it, but imagine that we get the situation where the changes
don't work well with a particular test, I'd rather just revert the one 
test that revert everything.

Thanks

John
