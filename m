Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2796C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 12:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DE92339F
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 12:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgLPMHE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Dec 2020 07:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLPMHD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Dec 2020 07:07:03 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D144C06179C
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Dec 2020 04:06:23 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c14so16982089qtn.0
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Dec 2020 04:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lnNS5vCyvhoJP3cm92SBm1aDGzANpXNP5uiF8x47WE4=;
        b=mXF4hA+9eELLl9koXO+7h2T2Bb/8+FP6BeYLiDUrT1JwDXABmJT+BJY1/DCEhqt/k6
         rFldjUxXJPSn6Ned3nTUgTEoS1iqOUifBToHvym1LZEeY6k9ROrJ1FJv4RAx2KpEqyRF
         P2fsQx93yLl/+pk0t+eIiqcIfK6fCpSgnwAwUV5qWTv2BzSSQUZMsj2yNBJBQppKLPUe
         NkE3m3EjHzc7pUg5CvEHO1uwUvacH59I5mbCOBB1NPtPbbtYt495+n/AM8koS3LEWrUD
         ZbN4gczrEOzn7zg9V75PEXCW5wxvihB/tq9M6i5ZHPvuXIQXKGkKOgkSP+BhtxGISm3c
         rDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=lnNS5vCyvhoJP3cm92SBm1aDGzANpXNP5uiF8x47WE4=;
        b=NivE9oY8BpwltKHcRXhifSFe0ZTTdvBp7NMnIXyWtcEpduNEU2NlAVLaY6bED1btwY
         nYE+3Tu+6jhkkYsTMhh1GySXXBJWbRg2UvVs3+GA7hAG0noyZhOSQcHy6UJf7zFQ1FNt
         ms1y+cMn2vx5TjGLgQKjz2U+maWTuk+TjEKs7lSV6n91CXlYcukD6Oe++EuTdGFTud8r
         V3Qi9txaFBB1hr7wn9TX9QGHv5CTip2T0E01436534dTel9zJwM/CInEUdlFTTn8gAhO
         6REAyqapOsS2lUZsG4mkKZ55IagWTQ5q8Ynm5OtICOlkrs5unxO5x0u6WhfX6yt2KzDe
         GAqQ==
X-Gm-Message-State: AOAM531Hp8nD58wxDwW1o84/bwkwHGHCtzTHcut7MJJuVpy1mO2fN3f4
        /9K8/krhYDSESMvUKWab/NE=
X-Google-Smtp-Source: ABdhPJyyWQ+IBuycYetoRtuPvuYYC/zozCwaQ1zbgVt2gslt/Lb8gIzzq+41tvosGjILqYRuvYzC4Q==
X-Received: by 2002:a05:622a:107:: with SMTP id u7mr19506639qtw.204.1608120382550;
        Wed, 16 Dec 2020 04:06:22 -0800 (PST)
Received: from lclaudio.dyndns.org ([191.177.185.4])
        by smtp.gmail.com with ESMTPSA id t30sm963852qkj.29.2020.12.16.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 04:06:21 -0800 (PST)
Sender: "Luis Claudio R. Goncalves" <lclaudio00@gmail.com>
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id AF8B23C004D; Wed, 16 Dec 2020 09:06:18 -0300 (-03)
Date:   Wed, 16 Dec 2020 09:06:18 -0300
To:     Stephane ANCELOT <sancelot@numalliance.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: enabling rt preempt
Message-ID: <20201216120618.GD960718@uudg.org>
References: <2aa26de8-1345-7e46-3628-a97a54e677b5@numalliance.com>
 <CAKXUXMwihDVrw03JehiVSQADtqwXWDNV_CJT+tzudRPHxLBdyQ@mail.gmail.com>
 <a5414150-efa6-3502-bd51-fe83ea7750fc@numalliance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5414150-efa6-3502-bd51-fe83ea7750fc@numalliance.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Dec 16, 2020 at 09:39:31AM +0100, Stephane ANCELOT wrote:
> 
> Le 16/12/2020 à 09:36, Lukas Bulwahn a écrit :
> > On Wed, Dec 16, 2020 at 9:31 AM Stephane ANCELOT
> > <sancelot@numalliance.com> wrote:
> > > Hi,
> > > 
> > > I have downloaded latest LTS kernel 5.4 .
> > > 
> > > For unknown reasons, I dont understand why I can't enable full rt preempt,
> > > 
> > Well, PREEMPT_RT is not available on v5.4 without the PREEMPT_RT patch set.
> Sorry, I thought it was now part of the mainstream kernel. I have not
> understand :-\

The merge into upstream is an ongoing effort and is not complete yet.

Here is the announce for the latest available PREEMPT_RT patch for v5.4
(v5.4.82-rt45):

    https://www.spinics.net/lists/linux-rt-users/msg23022.html

In the message you will find instructions to get the code.

Best regards,
Luis

> > You can check that there is no architecture support for PREEMPT_RT on
> > the stable kernel. Just look at the Kconfig files defining those
> > config symbols.
> > 
> > Lukas
---end quoted text---
