Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E278C433E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA3722228
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbhAZRU6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405806AbhAZQdP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 11:33:15 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073BCC061574
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jan 2021 08:32:35 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t17so12649123qtq.2
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jan 2021 08:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=yfFLjgpaYDj3c2HOa+sGe87T2NwjolHVVHgsQFW4qBM=;
        b=T2ClyDq6SmS5KF6Rw8d5+ww5P8r06eQieNpWJOZ6Kzrh96XzjX7/NoLXMF01xcrxsK
         PQM8s1eMg8gAQ47sTwckHc3mxoXhRL+FKAAFct3x/qAhVcOygOV9sf/2mdRMgBKjNzfb
         Tin99SCs+Qj0PN5pCByVl7ZgnlxteOyImkaoJU43XY4G1KJy3rk1DnedMOyFnSYqYlni
         A445FmpbRjffEPBoK/FGRc48YwaizdZLh+Lhw8D4KTqHTbeDXO1pjUz8G/PuU7fUJpiq
         D2FZN1kxURWpyDYZo2B3zMv1U0J83z7/cFQVXzPK0vjoJiiyCtcL6Y58geWRetS8Z9b3
         AASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=yfFLjgpaYDj3c2HOa+sGe87T2NwjolHVVHgsQFW4qBM=;
        b=SHvxT0RPU5diPzbmxf46vAMKdFCfQEq2QNh0snoELylz5sKgnVrQJpkuy7halI1AdI
         Ooizjoy0uaYdBXU+Efb3mxGbjwQJjS0a/YxH8t/U+owQ15rETOVWfqqfZ/dtZrVuKNYc
         1R7cSpCZzZE9qVGQb8yJ/YBiFS0YolB4AghdSkRT+EMEAw2BHg4zI85AjG8/nvySMPtl
         /mCZmwhyDCwXOfuOp65W/d9CUzqBkly/iGFhbOGcfJ4L7XrjH52Ov5yy7zaXMosReW9p
         OCZiLcRuIAMyBvfp/h4zKr1AnV8KHZ8TahSJWWpOJrhMvJ1fjdv2o1sDxm51UEVB6qBv
         SLdA==
X-Gm-Message-State: AOAM53117gvKfgDvUsGFSb+64tSTTun8Nkys+NveHaTeZgfvDkT/uhNK
        ySNJWlgvCfpFiiZiG4CsazdKPdrtPpycow==
X-Google-Smtp-Source: ABdhPJyoWr8qCSnqq7fI+CmSdGYAKVR/vJfPCMVW2+qKPmUEIAxjmt/z0kHnrFXjK8IneA6Dzi6NjQ==
X-Received: by 2002:aed:232d:: with SMTP id h42mr5824034qtc.143.1611678754131;
        Tue, 26 Jan 2021 08:32:34 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id e1sm14726625qkd.135.2021.01.26.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:32:33 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 11:32:25 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 4/6] cyclictest: Mimik --smp behavior with
 --affinity
In-Reply-To: <20210126083722.tpyy4jsv25sqzsnk@beryllium.lan>
Message-ID: <c834b380-8b7b-9bac-4221-e95d69a0dfd0@redhat.com>
References: <20201218141935.24151-1-dwagner@suse.de> <20201218141935.24151-5-dwagner@suse.de> <f273ca2-e80-7713-7caa-6dff464d388@redhat.com> <20210126083722.tpyy4jsv25sqzsnk@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 26 Jan 2021, Daniel Wagner wrote:

> On Tue, Jan 26, 2021 at 12:55:33AM -0500, John Kacur wrote:
> > Well, --smp historically combined -a -t and threads at the same priority
> > You could argue that it is reasonable for -a to automatically imply -t
> > but I have had debates with people about this and we settled on -a just 
> > specifies the affinity, and the default number of threads is one unless
> > you use -t.
> 
> My thinking is if you set an affinity mask, you want also to assign a
> thread to the CPUs. If not what's the point to set an affinity mask
> without a thread on it. Though the user is able to overwrite this
> by providing the -t options along side the -a option.

Not necessarily, but you want to limit where the threads, no matter
how few or how many run. As I said, it's not an unreasonable default,
but it is not the current default of 1 unless you specify -t
I suggest we stick with the current default in this clean-up effort.
We can discuss if there are some better defaults after this effort is 
complete.

> 
> > I'm not sure what you mean by this makes cyclictest behave the way the 
> > rest of rt-tests does, the rest of rt-tests should match what cyclitest 
> > does.
> 
> As I wrote, make cyclictest behave the same way as the to other tools
> when -a/-t is used.
> 
> > That said, I did some quick runs of signaltest and -a seems broken,
> > sigh.
> 
> Is it broken without my patches or with my patches? What is broken?
> 
> 
I haven't done a git bisect or something of that sort to determine if your 
patches broke it, but here's what I see. (running on non-rt laptop now, so 
ignore numbers), but it looks like at least the -t option requiring an 
argument existed before your changes, but your changes to affinity 
probably could use some more testing.

The following is okay

./signaltest  -a1-4
2.00 1.52 1.14 2/1079 6541          

T: 0 ( 6537) P: 0 C:  14896 Min:      3 Act:    4 Avg:   26 Max:     366


The following is broken, the default without an argument should be 2
./signaltest  -t
./signaltest: option requires an argument -- 't'

In the following note that threads other than thread 0 didn't appear
on the screen until after the ctrl-c

./signaltest -t9 -a1-4
1.11 1.14 1.14 2/1075 6864          

T: 0 ( 6856) P: 0 C:   1649 Min:     38 Act:  511 Avg:  457 Max:    4911
^CT: 0 ( 6856) P: 0 C:   1660 Min:     38 Act:  554 Avg:  457 Max:    4911
T: 1 ( 6857) P: 0 C:   1660 Min:     38 Act:  490 Avg: 1090 Max:   15024
T: 2 ( 6858) P: 0 C:   1660 Min:     38 Act:  449 Avg: 1091 Max:   15053
T: 3 ( 6859) P: 0 C:   1660 Min:     38 Act:  412 Avg: 1091 Max:   15075
T: 4 ( 6860) P: 0 C:   1660 Min:     38 Act:  378 Avg: 1090 Max:   15081
T: 5 ( 6861) P: 0 C:   1659 Min:     38 Act:  517 Avg: 1091 Max:   15072
T: 6 ( 6862) P: 0 C:   1659 Min:     38 Act:  485 Avg: 1091 Max:   15067
T: 7 ( 6863) P: 0 C:   1659 Min:     38 Act:  522 Avg: 1091 Max:   12832
T: 8 ( 6864) P: 0 C:   1659 Min:     38 Act:  549 Avg: 1091 Max:   12839


etc, it's broken in many ways.
