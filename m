Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E8C4363A
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC65620790
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRpc0/MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgJ2RDp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgJ2RDp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:03:45 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5FBC0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:03:45 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id r7so2559923qkf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8+LZmTYsS2bcZOvepSCvqWhTFVlBLjE/YXQkbf9rweM=;
        b=cRpc0/MF7Rr4Zbn90G5iXsD0g4nx8NBIlbA81+cEaVgQoKKoPptiAPrBEbfM+xR33h
         K5nA3Kemt8MoajqTjWtZnvFIvrB17GjqYyWmpAhh6mVmDuMV5CpU9dhGibu4XbyeWuCc
         gZK0+UXHhI4RPbMPWozP6yIbNE5a0bglpyTVmXLh69MHMDyWY21u1rtb5/LbVOVz0hQl
         bW1bCYlJVF8LNkfFMrkJohjHxkqfysIjEyNX4qqC2hWYL+ufQFUmSOIxCBtvjviTq6bN
         FSN+7OJ92Y/4ojuqdMEzhTYC49hXAPZzH/zH6CyuJactFfkr2xbePpPbNIdL5khCrCm3
         MfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=8+LZmTYsS2bcZOvepSCvqWhTFVlBLjE/YXQkbf9rweM=;
        b=iT2EAGOSVrlzCw6jGp2sQ3M371WwA/FVYUDiK8nLH/bPRKQOS5RIRjtntFKxiuttgB
         nTQqkMk91nE8RsqqYHjHrwyZ/mBItvb24K5f03FjqQhuEQ2kmaTSWOcsdzKqa8B4+Qlv
         xuZTAoUIt+zrLasimWHhW1kCsrQUE2sqmeunum9DVUwQWZ8Ffoa9vlOrsT/f6sGNZs9E
         qEv0QN3NwkZcyvmYFaj/jNn0U5wE3EWmkHsZ3fiUKJ/VHKVHrJFmestN84W2PzN0Rgua
         36WPuqm/pM/R2iF6/m3WwpLbe9Hd2R+e3WcDvwQ3vRp5/hNG/XCMP4VCFhNmLRKRhW2I
         sQfw==
X-Gm-Message-State: AOAM530e6q+lSd3K3kFSn54jzXBt3zh7Jd1PLDB4iXPEEokKed4zGXvT
        cMgyIHJr4i8jk+wOSdePIsU=
X-Google-Smtp-Source: ABdhPJw9fjDp7xZM5EZYTN3Ivi3viVT37eNqH5q4n7EjsajBXcIgiSd9ygHMnvC373e91tk/zyckhg==
X-Received: by 2002:a37:4e8e:: with SMTP id c136mr4422537qkb.462.1603991024508;
        Thu, 29 Oct 2020 10:03:44 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id 22sm1395082qkg.15.2020.10.29.10.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:03:44 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Thu, 29 Oct 2020 13:03:43 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     dieter@bieler.li, linux-rt-users@vger.kernel.org
Subject: Re: Error-Report rt-tests
In-Reply-To: <20201029155735.xsiqv6ocqemz6yiu@linutronix.de>
Message-ID: <bed1ae81-a6e9-c255-60bc-c3f1f49a5ef8@redhat.com>
References: <006101d6ab85$88d32f70$9a798e50$@bieler.li> <007501d6ab85$f3369910$d9a3cb30$@bieler.li> <20201028164059.m7ygqaikxqox6res@linutronix.de> <3cb8be1a-3e69-dbcc-363-30c1a15e3afd@redhat.com> <20201029155735.xsiqv6ocqemz6yiu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 29 Oct 2020, Sebastian Andrzej Siewior wrote:

> On 2020-10-29 11:33:57 [-0400], John Kacur wrote:
> > 
> > It's a bit odd because the libraries are static.
> > Isn't that quite an old version of glibc as well?
> 
> It looks like Ubuntu 20.04 / Focal Fossa. The glibc version above is
> when the symbol was first introduced.
> 
> It builds on i386/Debian Sid, just tested. Noticed this however:
> |~/rt-tests$ make
> |Traceback (most recent call last):
> |  File "<string>", line 1, in <module>
> |ModuleNotFoundError: No module named 'distutils.sysconfig'
> |make: Nothing to be done for 'all'.
> |~/rt-tests$ python3 -V
> |Python 3.8.6
> 
> wouldn't it work to just keep "PYLIB  ?=" and the caller passes what he
> needs?
> 
> > John
> 
> Sebastian
> 

Right, ?= in the makefile means if it's not already set, then set it to 
what comes next. You could just do make PYLIB=""
in order to skip the python stuff.

On my fedora box if you were to set it by hand it would be
make PYLIB="/usr/lib/python3.9/site-packages"

John
