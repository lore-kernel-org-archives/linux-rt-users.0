Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB7C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 12:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A861029
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 12:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhIMMx7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235840AbhIMMx6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 08:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631537562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TKv8cQRtKN4mwt0xUYW/hj3BpVC9rg7iCXdjeQ6IjWg=;
        b=iqf9UNjsI0EBUi2nT+aRnraT+QmcSfuyQK2bDff+oIi4eFM+MUNHbY4+A4Exp+mWx3eNcb
        c9B6S2kUQOHQCJJ/fh89v0g3wZTmJ00ACMv12W3nEVNL6kN/k1/ZNtqRlgPsTxiop4iMFY
        16Mt05DPK7rFSxC8D1Mr3LTliyAlxXU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-ignbrPYkM_uDwsCJ7rU2ag-1; Mon, 13 Sep 2021 08:52:41 -0400
X-MC-Unique: ignbrPYkM_uDwsCJ7rU2ag-1
Received: by mail-io1-f69.google.com with SMTP id z26-20020a05660200da00b005b86e36a1f4so13780562ioe.15
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 05:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=TKv8cQRtKN4mwt0xUYW/hj3BpVC9rg7iCXdjeQ6IjWg=;
        b=UvBnuYvSnJXmf38uybQcwPDsyqiXkbzxzpoPEDeZnFRt5vvPLanHJimBcRWNSGjHgy
         WPBrlYEZTN3JFnSdJXLI6x8UaaGGfsPeTzZLnZgUeUqs6KyUY+3n6km2km1jUqlfmf8N
         9krKSglDuWAL52aRLfptyfAfmGx3glM6cGhSZuqkoczXkHQjTeWv9qy2OW/6zCdXqURi
         rWavDwkodPSSpnwEfoAK5mxLKqqhmqkO7PoHO/kJVszbr8CiGebnjbJoEYYd9PT+lJle
         bLMxiS0EZiUha/q6vK3ofgXdijLvMdQHEXw9q6nqcL1oYo4iXNWzOiOrpl9TKQItxG0U
         iqTg==
X-Gm-Message-State: AOAM532HnGEYbeggcC2ife+pjlotbZvG4VMuoSAKr6WCwYu7r0r187TV
        8u9CwNf8V0Ub6heIKJ6pW9GefePo3exUhAZxjYTPo5yjlEd9CrzwHQOKXbcNHcUOFzJ3tqgS/N0
        OItvpyhqSX4MS8GTZvCGTT2sHuBI=
X-Received: by 2002:a05:6638:16d4:: with SMTP id g20mr3648500jat.22.1631537561013;
        Mon, 13 Sep 2021 05:52:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwnJUL6+bG2Dxem/SGvAxen0jW8FkWeNeekHorpXP1YdnSdaxqV2oWUt6FtTlb4Bgu7BGsWw==
X-Received: by 2002:a05:6638:16d4:: with SMTP id g20mr3648488jat.22.1631537560803;
        Mon, 13 Sep 2021 05:52:40 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id s6sm4388374iow.1.2021.09.13.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 05:52:40 -0700 (PDT)
Date:   Mon, 13 Sep 2021 08:52:39 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/5] rteval: hackbench.py: Enable running on a system
 with low memory
In-Reply-To: <8735q99c5e.fsf@stealth>
Message-ID: <6d2f87e-f4c-3371-d990-ce1ca67bcbf@redhat.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com> <20210901080816.721731-5-punitagrawal@gmail.com> <4273ee11-b665-53e1-57b6-1e8f443168a5@redhat.com> <8735q99c5e.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 13 Sep 2021, Punit Agrawal wrote:

> Hi John,
> 
> John Kacur <jkacur@redhat.com> writes:
> 
> > On Wed, 1 Sep 2021, Punit Agrawal wrote:
> >
> >> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >> 
> >> The hackbench workload refues to run on RockPro64, a hexacore 64bit
> >> Arm board with 4GB memory, complaining about insufficient memory
> >> per-core.
> >> 
> >> On further investigation, it turns out that workload is using an
> >> arbitrary limit of 0.75 GB/core but will quite happily run on much
> >> lower lower memory systems.
> >> 
> >> Instead of preventing execution, convert the info message to a warning
> >> when the memory is lower than expected but continue execution. This
> >> should enable the workload to be used on a wider range of systems.
> >> 
> >> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >> ---
> >>  rteval/modules/loads/hackbench.py | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >> 
> >> diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
> >> index 3b692070e9d9..ab028c495d8b 100644
> >> --- a/rteval/modules/loads/hackbench.py
> >> +++ b/rteval/modules/loads/hackbench.py
> >> @@ -55,9 +55,8 @@ class Hackbench(CommandLineLoad):
> >>          if ratio >= 0.75:
> >>              mult = float(self._cfg.setdefault('jobspercore', 2))
> >>          else:
> >> -            self._log(Log.INFO, "Low memory system (%f GB/core)! Not running" % ratio)
> >> +            self._log(Log.WARN, "Low memory system (%f GB/core)!" % ratio)
> >>              mult = 0
> >> -            self._donotrun = True
> >>  
> >>          sysTop = SysTopology()
> >>          # get the number of nodes
> >> -- 
> >> 2.32.0
> >> 
> >> 
> >
> > I'm not sure that I can accept this. The number isn't entirely arbitrary, 
> > it's based on verifying machines as realtime capable for customers, in 
> > which case I'd rather it fails early.
> 
> I think there's a misunderstanding. The above check only prevents the
> hackbench workload from running - which takes ~2-3MB in the default
> configuration on the board I tested. rteval (along with cyclictest,
> kcompile and other workloads) executes without any issues.
> 
> In terms of memory requirements for real time systems, I am not sure
> there is a single number that is valid across all applications or
> systems. Any such requirement only manages to alienate certain class of
> rteval users. I thought a warning was a good compromise.
> 
> I am hoping you will reconsider the need to introduce a user option for
> this case.
> 
> > Maybe there is some other way to indicate that the user is okay with
> > lower memory system, such as passing an --embedded flag or something
> > of that nature?
> 
> If the above doesn't convince you, I will look to adding an option. How
> about calling the option "--low-memory-system" to clearly state what it
> enables. "Embedded" is not well-defined and hard to guess what it
> relates to.
> 

You're right, the original code only prevents hackbench from running, it 
doesn't cause rteval to fail early.

Hmmn, it almost seems like the original code was a development hack that 
wasn't removed. Not sure, give me a short time to think about it.

John

