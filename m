Return-Path: <SRS0=wVJd=DM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF1FC4363A
	for <linux-rt-users@archiver.kernel.org>; Mon,  5 Oct 2020 23:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48C1206F7
	for <linux-rt-users@archiver.kernel.org>; Mon,  5 Oct 2020 23:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yaskawa-com.20150623.gappssmtp.com header.i=@yaskawa-com.20150623.gappssmtp.com header.b="GXrqRGb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgJEXS3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJEXS3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Oct 2020 19:18:29 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEF7C0613CE
        for <linux-rt-users@vger.kernel.org>; Mon,  5 Oct 2020 16:18:29 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d28so4168364ote.1
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2020 16:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yaskawa-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=8ii51iufIk+GaOFcM4iSPDiT9XIARsPUcv33YKburaY=;
        b=GXrqRGb0obpwEw3b0Vh7y/x8vaD7tXv7+9WVenEPdUKPxDz/Do3zk/Dz9WRRMrYGEN
         YhZZUBUCi5qzldZx9FusvynbVYPl9QXgLL3EEeM661PnJJV+FjOLK7oL2tY5LvkS8p4I
         8cncNqmPUwUvwlV7cucTcx2ZHY+bvvPFRZTojq+sQI7Q5W17X3bFTa+3KngV+afuK3S1
         yjCLYboAg3qiKJOm8mWFtn5aiT6DiOzR82O2j2VTN6bJir3VrqM1C245PlnPXzN1/ifo
         G64zUdVsauho1hBkajs5mcjbTkTWmcAS8/V6ey1TtMs2ebBLgual3MFCmj7o8koEsOEf
         JyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8ii51iufIk+GaOFcM4iSPDiT9XIARsPUcv33YKburaY=;
        b=go8xhXPXXjihQXcDCtWSWS3JL9aI97LvCJGlie7VcGVfmhvPoN825eGrYNkGhP5Lev
         PTYoj7hErLpF4YnE1AABVLnwIPNvvNajEiwH7/eHZKakwCCTtZZml/gXiCZjd/v+lxas
         ytP9/B7h3Ms7o8T6qxHn0spiDiRXwUcwUhiLSblQ0mMrY7pZnwNZz95aJEDzcR9Rez8v
         rh8C9E/sySEzPRksPNUX0WCpWXS1c1hxaePJUOAKMUObNizOqgQupZQyznd4XjLXqLqR
         CggbLDMlY+jBmjLsRAMZc2HQqOicOpftN7H/duoDyR6DJjMi352Fz1nhnMxtc7T0Webt
         rtcA==
X-Gm-Message-State: AOAM530w2T243fAa3wy31MN7xjfpPr0HZylp9H0aT0GNFJWWr46dWahT
        XlazWvOF0z/bhc8aXvoO701ztkSZ1KaqnTvee8vBlk/xG68VDVmqfGStqaXVJFUkD5KACeidI8K
        jJYXbZNpTg8uosFMlC0JNeukKdYl3E4YzoGxKhpk29BY=
X-Google-Smtp-Source: ABdhPJyatvSHs326vrIrVcEMbAB706XYqzwifQhTG0qeOpfdhNOPtSQwJCKbOWRwwaBoldSxVSMdBmJuzAfiWWvazb4=
X-Received: by 2002:a9d:5910:: with SMTP id t16mr1197847oth.155.1601939907910;
 Mon, 05 Oct 2020 16:18:27 -0700 (PDT)
MIME-Version: 1.0
From:   Seth Opgenorth <seth_opgenorth@yaskawa.com>
Date:   Mon, 5 Oct 2020 16:18:17 -0700
Message-ID: <CAP7GL9MV7AxW9sv2G1D5AYjEJfhwv7=nM6kbj2Qk78ss7wtp4A@mail.gmail.com>
Subject: Linux-rt scheduling - task lock equivalents?
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

I'm currently working on a project that is working on porting an
application from VxWorks to user space on Linux, with the preempt_rt
patch.

One big item VxWorks specific feature that we used a lot is an
"intLock()" as a form of a critical section, to lock out all other
scheduling and interrupts from interfering with data coherency.

On Linux, we now no longer require a full-blown interrupt lock, but
instead are looking for a way to lock out all other threads within our
process from running to avoid data coherency issues. Fortunately, we
are only targeting single-core execution (by use of starting our
process with a taskset command to set CPU affinity).

Of course, it would probably be best to look at all of the specific
hazards and use cases of this in our codebase, and replace them with
more specific synchronization items (eg, mutexes, etc.). But, this is
naturally a large codebase that makes such that difficult to achieve.


So, given the following:
1. We only run on a single CPU core (via taskset)
2. Nothing on the system (or at least our process) is given an RT priority of 99
3. SCHED_DEADLINE is not used
4. PI does not occur (ie, this "critical section" code must never use a mutex)
5. RT throttling does not occur
6. Interrupts or preemption from the kernel is allowed, just not from
threads in our process


a) Would there be any real synchronization hazards with temporarily
boosting a thread's priority to 99? (Does changing a thread's priority
on the fly guarantee immediate usage of the new priority for
scheduling?)

b) Or, can one always safely expect that the SCHED_FIFO thread with 99
priority will not be preempted (if not, what situations might present
a hazard?)?

c) Are there any obvious alternatives to just boosting priority?

Thanks!
Seth Opgenorth

-- 
IMPORTANT: The information contained in this transmission may be 
privileged, 
proprietary and confidential and protected from disclosure. It 
is intended only for 
the intended recipient. If you are not the intended 
recipient or a person responsible 
for delivering this transmission to the 
intended recipient, you may not disclose, copy 
or distribute this 
transmission or take any action in reliance on it. If you received this 
transmission in error, please notify us immediately by replying to this 
message and 
please dispose of and delete this transmission.

Thank you.

Yaskawa America, Inc.
