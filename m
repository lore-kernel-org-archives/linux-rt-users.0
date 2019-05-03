Return-Path: <SRS0=ow8w=TD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8A1C43219
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 06:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F3E205F4
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 06:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfECGxK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 May 2019 02:53:10 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:38043 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfECGxK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 May 2019 02:53:10 -0400
Received: by mail-qt1-f172.google.com with SMTP id d13so5585691qth.5
        for <linux-rt-users@vger.kernel.org>; Thu, 02 May 2019 23:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=K2EzUjMRAmjd4j2+uHzrll32G3H5mbvi+ylav93qiwQ=;
        b=asQDhMNo9bSUWSOViJ8c8Vid1wjssVPmPYB4JTEu9OtBDXwNgdTgWaAJBnoP9og+k/
         lLw+zCxPlxViu4jp/uMtFM1g6T47SRPxqa/fQyBGsoiNUvPmcfuTiij9MXRZGU+tQWpL
         hwgwYpXbQt8Yt6NWeufuY3HK/lWuzxVGgWsf/FsfgJt/6lTnClYxCU6ge0HxY/7aTyAp
         7v1rgWZNlTrqSkYfKpoREDGlBb5O+NV5Q32W3CFWgGDM6MBZSnOX1/lAE1lk/QgKtPAY
         4of+L5sA74yEXHl++JQls4PBIrN1MsxMMvywtSYDDb05nhocDuNAK/TGWEZoX8A829Ed
         7DbA==
X-Gm-Message-State: APjAAAU+suPZJ0o02h2uaikO0tJvFL5LNfd++pdiLT0KkUEL99vIRGkB
        z8qnyiFX/IxuZEN+jJ3OuD+FxmirS7o=
X-Google-Smtp-Source: APXvYqyOl961LbnLr1N0+iW/SvDWH1QfiVLGTP+wv10J3mHDQdS2SY0K9AJ9o4FmGbEGXCf2fFsS4A==
X-Received: by 2002:a0c:d20b:: with SMTP id m11mr6825833qvh.165.1556866389320;
        Thu, 02 May 2019 23:53:09 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id o63sm723291qkf.41.2019.05.02.23.53.08
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 23:53:08 -0700 (PDT)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Real-time micro-conference proposal for Linux Plumbers 2019
To:     linux-rt-users@vger.kernel.org
Message-ID: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
Date:   Fri, 3 May 2019 08:53:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all!

Last year we had a very fun and productive real-time micro-conference at the
Linux Plumbers Conference, so the idea is to repeat it this year!

Are you interested in participating? Do you have any suggestion of topic? Let us
know!

This is the current proposal of micro-conference, we can still edit it and add
your thoughts.

======================== PROPOSAL ==============================
Since 2004 a project has improved the Real-time and low-latency features for
Linux. This project has become know as PREEMPT_RT, formally the real-time patch.
Over the past decade, many parts of the PREEMPT RT became part of the official
Linux code base. Examples of what came from PREEMPT_RT include: Real-time
mutexes, high-resolution timers, lockdep, ftrace, RT scheduling, SCHED_DEADLINE,
RCU_PREEMPT, generic interrupts, priority inheritance futexes, threaded
interrupt handlers and more. The number of patches that needs integration has
been reduced on the last years, and the pieces left are now mature enough to
make its way into mainline Linux. This year could possibly be the year
PREEMPT_RT is merged (tm)!

In the final lap of this race, the last patches are on the way to be merged, but
there are still some pieces missing. When the merge occurs, the preempt-rt will
start to follow a new pace: the Linus one. So, it is possible to raise the
following discussions:

  1) The status of the merge, and how can we resolve the last issues that block
the merge;
  2) How can we improve the testing of the -rt, to follow the problems raised as
Linus tree advances;
  3) What's next?

Possible topics:
   - Status of the PREEMPT_RT Merge

   - Merge - what is missing and who can help?

   - How do we teach the rest of the kernel developers how not to break
     PREEMPT_RT?

   - Stable maintainers tools discussion & improvements.

   - Interrupt threads are RT and are not protected by the RT Throttling.
     How can we prevent interrupt thread starvation from a rogue RT task?

   - Improvements on full CPU isolation

   - Newer methods like proxy execution, hierarchical scheduler?

   - What tools can we add into tools/ that other kernel developers can use to
     test and learn about PREEMMPT_RT?

   - What tests can we add into tools/testing/selftests?

   - New tools for timing regression test, e.g. locking, overheads...

   - What kernel boot self-tests can be added?

   - Discuss various types of failures that can happen with PREEMPT_RT
     that normally would not happen in the vanilla kernel, e.g, with lockdep,
     preemption model.

I will suggest the continuation of the discussions of the topics I presented
last year, based in the results of the work I did this year (spoiler: I am doing
model verification in the kernel, and it is very efficient!).

Paul already told that he could talk about ongoing work to make RCU's forward
progress be more robust in overloaded cloud deployments. There will be some
connection to real-time response involving rcu_poll and the infamous RCU kthread
priority!

The continuation of the discussion of topics from last year's micro-conference,
including the development done during this (almost) year, are also welcome!

-- Daniel
