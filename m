Return-Path: <SRS0=4wg/=VM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B92C7618F
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Jul 2019 11:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0832081C
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Jul 2019 11:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfGOLcB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:32:01 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46102 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfGOLb6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Jul 2019 07:31:58 -0400
Received: by mail-wr1-f49.google.com with SMTP id z1so16659466wru.13
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Jul 2019 04:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sVmx49FetzgtGZuIFy9uIhpnJLTpg0kxTl0UuJEJe7Q=;
        b=DF9AbKe8qEnvDZwhN+7q4TJhBVqB/zniNN3lb7fz9SZ6Kpr7L6bB2nmixK3A5ygFqi
         mleOgP36l8ApXoK/mf4BJxT1Ts51NBLma6gAoW2RmBR63fBmRi4zxK1yQxpJ1gK5K0UX
         Cg5keTLcnomYnzMQs691XEvsraZ8Teao+fMgiXrew/PSe0spIgxkX6o3JOZGd/cs2Ib4
         U198kz3ihHYL4fOsq/9iB3egfVEkmj+Bumszpca5qiu/kiTgUf5hfFWyMtUV9NLCpOLp
         N7OFwHLuYesaMceKZRJvTonoxverk5visaf/RDn7KZhvgj2bYER6+44zXiAeOINqtDC6
         ORVA==
X-Gm-Message-State: APjAAAV9i82cJHZdjGh+VgL2eEvWX7AVDW0iTw03O9/x7vfF0KEe0zr4
        DwIEW67ZAA5bkfjsn3kZ9Qi141GKTkE=
X-Google-Smtp-Source: APXvYqxaMCkFl0KuQs1ITVTLQOOHJiQynNDzXl3QWesjiDgflxX64RiUZDacf3NVNNYHdIVElDAnvQ==
X-Received: by 2002:a5d:568e:: with SMTP id f14mr27982166wrv.167.1563190316126;
        Mon, 15 Jul 2019 04:31:56 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id g8sm19621142wme.20.2019.07.15.04.31.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 04:31:55 -0700 (PDT)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [ANNOUNCE] LPC 2019: Submit a topic for the RT Micro-conference
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Message-ID: <c76e9cb4-2c61-797d-bce1-aa504ad51940@redhat.com>
Date:   Mon, 15 Jul 2019 13:31:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Since 2004 a project has improved the Real-time and low-latency features
for Linux. This project has become know as PREEMPT_RT, formally the
real-time patch. Over the past decade, many parts of the PREEMPT RT
became part of the official Linux code base. Examples of what came from
PREEMPT_RT include: Real-time mutexes, high-resolution timers, lockdep,
ftrace, RT scheduling, SCHED_DEADLINE, RCU_PREEMPT, generic interrupts,
priority inheritance futexes, threaded interrupt handlers and more. The
number of patches that need integration has been reduced from previous
years, and the pieces left are now mature enough to make their way into
mainline Linux. This year could possibly be the year PREEMPT_RT is
merged (tm)!

In the final lap of this race, the last patches are on the way to be
merged, but there are still some pieces missing. When the merge occurs,
PREEMPT_RT will start to follow a new pace: the Linus one. So, it is
possible to raise the following discussions:

The status of the merge, and how can we resolve the last issues that
block the merge; How can we improve the testing of the -rt, to follow
the problems raised as Linus's tree advances;

What's next?

Proposed topics:
 - Real-time Containers
 - Proxy execution discussion
 - Merge - what is missing and who can help?
 - Rework of softirq - what is need for the -rt merge
 - An in-kernel view of Latency
 - Ongoing work on RCU that impacts per-cpu threads
 - How BPF can influence the PREEMPT_RT kernel latency
 - Core-schedule and the RT schedulers
 - Stable maintainers tools discussion & improvements.
 - Improvements on full CPU isolation
 - What tools can we add into tools/ that other kernel developers can
   use to test and learn about PREEMPT_RT?
 - What tests can we add to tools/testing/selftests?
 - New tools for timing regression test, e.g. locking, overheads...
 - What kernel boot self-tests can be added?
 - Discuss various types of failures that can happen with PREEMPT_RT
   that normally would not happen in the vanilla kernel, e.g, with
   lockdep, preemption model.
 - The continuation of the discussion of topics from last year's
   micro-conference, including the development done during this (almost)
   year, are also welcome!

If you are interested in participating in this microconference and have
topics to propose, please use the CfP process here:

https://www.linuxplumbersconf.org/event/4/abstracts/

If you have any doubts, feel free to contact me!

Thanks!
-- Daniel


