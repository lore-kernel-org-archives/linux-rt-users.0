Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D0C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 22:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E6B64E31
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 22:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhBVWLh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 17:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhBVWLU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 17:11:20 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6DCC061574
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 14:10:40 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id b24so10494851qtp.13
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 14:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=YPoUWFNS69CaekEtDXqtipCR4CYRjq3b0Q8boydNnJ0=;
        b=gTX6wi9vxwzwxV6XRBFIho1AvJSFehI+I3MVLVKyr0NtYEBQxLsoWT4Qpo9gSrk40z
         DrCkxBL0ARLu7iZgfeYmbuRxExqyLgCycXX54uBDRClkFOusiamQr62Tao//crZW+tnX
         4soLpArLTeU2evAnWJZNiwSJMkdCL/LoQA1DmRCWlrX1pMzD/cLkgAh3ZFyNl0ufEMff
         HXAiTxEiBVCyW2zeUXEK/eDwqEnBItG3d9v/D8i1JLQXzD5DkmBea+RwqpeeS1+ryb30
         DqOU6Jqna5NcIParGS7kNOekBXu4wV5o51nVdnCd8D7uX1vSEtCEMsFt/ZoAdPTCGl1w
         tR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=YPoUWFNS69CaekEtDXqtipCR4CYRjq3b0Q8boydNnJ0=;
        b=MuK4d+n0JuX6qD9IATK0FrcV2HfD5RZqDyWMp1oXydfe3UQJdSaBVibVgeeIQGSCqj
         ycKQjZJbkaZTGUoNDv8IzbevV9aYWJ4FWhdvWEAE8qsuTj9sZiBTlWkEUv8UMZYD3yNH
         v8g1OCI+YoR4Iwi0uqc3uH66iShWPMZCYkObKeZ76Eo7XxbZ3FK8k8fAADngiHD1vpVy
         aWlOi1QcJhsJASjqDFngc8Kh/AmgzkMl7AzvBB8sw36HNWCmRhg5hPYZKDnGwRnjcdcF
         uVkF3FrmA/ps9c82mZkCsRgZw3mzqTq3FmlBCOAa4aTZXa5i0yjM3dywL+nYl6ljsx7Y
         i5Yg==
X-Gm-Message-State: AOAM530HDqDRfA7ZG4lN2PWi0JwDSFcN7AzdFv/oWmBrmK8ODYxIi8iS
        A79BsYBYmXsmwZYf5bG0cGk=
X-Google-Smtp-Source: ABdhPJyvMO5yHo254LWCZfHhkhU6Y31WDQfoZt2L+HpbXVSbOjDJ6316lwQBXVb7M84rc1r3j6Ipog==
X-Received: by 2002:ac8:d0f:: with SMTP id q15mr22536387qti.3.1614031839632;
        Mon, 22 Feb 2021 14:10:39 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id x6sm13203045qkj.118.2021.02.22.14.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 14:10:39 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Mon, 22 Feb 2021 17:10:38 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <wagi@monom.org>
cc:     Christian Eggers <ceggers@arri.de>,
        RT <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 0/3] Revert always use libnuma patches
In-Reply-To: <20210222082503.b2u3s2ftv3os474f@beryllium.lan>
Message-ID: <2d2a7ea-ecb7-555e-ae80-83e791de7cad@redhat.com>
References: <20210219184801.13905-1-jkacur@redhat.com> <2188166.ElGaqSPkdT@n95hx1g2> <59d08654-a23c-a880-b78a-43c64b1fd16d@redhat.com> <20210222082503.b2u3s2ftv3os474f@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 22 Feb 2021, Daniel Wagner wrote:

> On Fri, Feb 19, 2021 at 04:30:39PM -0500, John Kacur wrote:
> > I think I see the problem, the patch
> > rt-numa: Move thread placement code to rt-numa library
> > 
> > added the fatal if numa_failed.
> 
> Sorry about the mess, I thought we can relay on libnuma. The concept to
> depend on compile time on a library and not during runtime escaped my
> attention.

No problem, I should have caught this myself in code review.
I had honestly forgotten that when we made numa a compile time requirement
that we made it so that it was not a runtime requirement, even though I
wrote most of the code to achieve that.

> 
> > Thanks for testing. I'll send a patch to put it back the old way.
> 
> Thanks John!
> 
