Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD243C433E6
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 19:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDA464ED4
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 19:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhBJTN5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbhBJTNr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 14:13:47 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8F0C061574
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 11:13:05 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id n28so2335904qtv.12
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=w0YAPNDXk4WbCuUiTvNTJzU+nQ6P8NmbUdw1Vol8om8=;
        b=Mz8fxLWo06KZZ8Tr4o383mPhp4QCjE38u3oXbNUwhCl7b1BL6Af7tzm4aKRvxBh4u7
         JipEZSvkjAKkRdQt+NvGiuivIwVpO4t+A9IeKZYqNH9Y6HwIEkYyWEwITlNYiv5Wm1cP
         jSFzZVWBjuy5gIfbW7UEJdnhEeA+nkVJ/suO47Qz623J355/KQwmSvNbMw6oTfkpzBgI
         ODwJxzWbakgfr3yWHBdTlVJWEXVTfI15GH8fxsvAEzvKtswc7qZV0oDpI5YaWUOWkpJ6
         smkSe+aKQtdJOxDqpUjUOfoAMdwTTRswkyl1D9e9+E/b7DcXrhPatBftIuB9wtIE/0H1
         RL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=w0YAPNDXk4WbCuUiTvNTJzU+nQ6P8NmbUdw1Vol8om8=;
        b=nICvS8+Z5iHr3ji1oystEJHB/9yWyTTQioU1Pe99rDyeK1xvrsJDdoVyE2ux+WUQrA
         12g4XuXuBTSvOySK9j3bsC2k+5u/+sWrkLAONa8bdo391uC235VCt4TA30uluUW8EeeS
         2Jqga2SFqJYUkKSZspCvOa1plGjNRNZtaJAE9ZnIb3doZLsb/iGxWAmeFqFZ5zgChf0q
         KRRZ3XMl4Cj8Q70bxHxRog8+hEo+9W89O3B/L+D0DvQ3HCYr9tf0or6wtacioags5+Uh
         jzoV20rgpJXKGWu7sDILIq3po2RnAgLyUCZGSLEGC4yo+D2q2PsAgEES+BhAc/vFkCui
         4vXg==
X-Gm-Message-State: AOAM533F0aVw9xWjwjSW3FGKM3TcEbV4bADO0sWtdfkwAQW0iRwrhevj
        fpnx5NbO9zUU9NhrpQ1NZ+c=
X-Google-Smtp-Source: ABdhPJyiJjVoWvRJmfNQkEHGTILPgjpPbgJ+iIfsDuly3eKzJq7mXu3sIa0Tsw88iRMLBjuT8K3HrA==
X-Received: by 2002:ac8:8b1:: with SMTP id v46mr4128637qth.252.1612984384877;
        Wed, 10 Feb 2021 11:13:04 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id o10sm1894251qtg.37.2021.02.10.11.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:13:04 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 10 Feb 2021 14:12:52 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH rt-tests 1/2] oslat: Print version string
In-Reply-To: <20210210182114.xbxw62gj6n6ox6pt@beryllium.lan>
Message-ID: <eaf911f6-1e4b-ce13-7b26-45b01854f7e7@redhat.com>
References: <20210210165407.9770-1-dwagner@suse.de> <20210210165407.9770-2-dwagner@suse.de> <9c2916d8-14ab-3465-97fa-2a9b52c83b1e@redhat.com> <20210210173353.pqeu2sm33qs7hjna@beryllium.lan> <7a61c0fd-90fe-69a4-5d26-4b688e2147b5@redhat.com>
 <20210210182114.xbxw62gj6n6ox6pt@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, Daniel Wagner wrote:

> On Wed, Feb 10, 2021 at 12:59:29PM -0500, John Kacur wrote:
> > Are you really telling me you won't fix a problem you introduced unless
> > I first take all the other code you would like to get in rt-tests?
> 
> I've already done the long option support in the JSON series. It would
> make my life way simpler if those bits would be in the tree.
> 
> I think, the simplest fix for now is to temporarily a local fix for
> oslat.
> 

Just add a fix onto for the oslat problem on the end of your series
I'll be done the review soon.

If we need to do any backporting then we'll do that.

Cheers, Thanks

John
