Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742CFC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADCE64DF0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBSQqi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBSQqg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:46:36 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D3FC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:45:56 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id q8so2859569qvx.11
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=hCpspThGgqafR+EVuwpyt3Ir7bNexIDIXw9533hs7pQ=;
        b=JBgV/flvASN8iWO3J8T4+CHULBsbuuj2Oh6xBK3/2UjiMg4vXd2eArt+6r6nSRKVIi
         0D1WLbhui6iCyVhDt40z+KJEJmIB2dLqjMnRU+Ku2erwohA5I0dQzePirbpik4IiODdV
         2Uc5dO8ra+dY7d9KI0Z7g8ugnDiN30JOPgiU3RmoXZtfs0yQbxw0lB7XJS7HeVsQDfWv
         XkT2qeDZT51gHw8oNPMuQsg//3lgM1GQ4il9ISa6zlf5iHQl/pvPqkMzrPyKUj2uyvQr
         DEIjSb9BgMsLe66N1UguV19148DDn+EHM3nkQCeKzR++rQkGUvFhg1GQBL5NlDB/2Xp2
         EOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=hCpspThGgqafR+EVuwpyt3Ir7bNexIDIXw9533hs7pQ=;
        b=MggoDI956KAF9Io6nQ4fvI7swzg+NN0bDtVypAgUMna9T/4Ou13a4kUbi/XuX/35Q4
         SckeJuBuftH2V7kk65UoqJRIsR7oPffHqFh3c8W5KI60pRUUNd57d/tsdAhR/hSSzCAh
         YFIne59MRcHRbZYk2QPR9y1jDhotuRfGcMXkbSyhxGM5tILotNyk6Yr7lLzN4uWDao0q
         bfXu921bqUXdfKujQarR00Ud9E4qcHpNBts5wH1xcRfJw4AHWidykVJUvwzcDUQcnqN3
         ZvGX7smhbqA5ti4JDBDQsIBKyFKd+tdIEzNJLvXV7v6hJJWYcy/Bxq7CevjJueDe6tl8
         rv9Q==
X-Gm-Message-State: AOAM533bjKBzoGgO9zJfz52/xdx/68bpfQY7HPX0fC4zE2CxuU2zGc7c
        6o9h+mxQV0y3cOpVBF3P130=
X-Google-Smtp-Source: ABdhPJzWXfDrURMQNeTJJFl8z6cXSKF/Y/zgKf1uw//MnIeAETljo+7MM3tzPN/c8AJOlfCfFjvXTw==
X-Received: by 2002:a0c:e38c:: with SMTP id a12mr2302728qvl.38.1613753155571;
        Fri, 19 Feb 2021 08:45:55 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id d128sm6518447qkb.44.2021.02.19.08.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:45:55 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 19 Feb 2021 11:45:54 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Christian Eggers <ceggers@arri.de>
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
In-Reply-To: <878s7k41ff.fsf@kurt>
Message-ID: <5a8b3f0-4d15-4ca5-ccd6-252f5e185c9d@redhat.com>
References: <20201218161843.1764-1-dwagner@suse.de> <20201218161843.1764-2-dwagner@suse.de> <878s7k41ff.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 19 Feb 2021, Kurt Kanzenbach wrote:

> Hi,
> 
> On Fri Dec 18 2020, Daniel Wagner wrote:
> > libnuma is hard dependency for cyclictest. Thus we can always call
> > numa_initialize(). This allows us to remove the global 'numa' variable
> > to track if libnuma has been initialized or not.

Just a small note, the global 'numa' variable was NOT used to track 
whether libnuma had been intialized or not.

The user used to specify smp or numa, then we decided that we would remove 
the numa option.

What happened was that if numa was available and smp was not specified
the program would automatically use numa else it would use smp.

If smp was specified then smp was used. The numa variable would track 
that.

the smp option used to just collect a common set of options
-a -t and priorities all the same.

It made sense way back when, but it's less useful now-a-days

> >
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> It seems like with this particular commit, it's not possible to run
> cyclictest on arm32 systems anymore. I guess due to missing NUMA
> support?
> 
> Just tested on a dual core Cyclone V:
> 
> root@tsn:~/rt-tests# ./cyclictest -S -m -p 99 --secaligned
> FATAL: Couldn't initialize libnuma
> root@tsn:~/rt-tests# 
> 
> I've used the current unstable/devel/latest branch. Any suggestions?
> 
> Thanks,
> Kurt
> 
