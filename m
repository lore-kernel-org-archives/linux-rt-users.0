Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C29EB64D7
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jun 2023 15:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjFZPIY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFZPIV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2023 11:08:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D687130
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Jun 2023 08:08:19 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:08:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687792097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hK4yC8RN+DUk4iitIMpk3vCapda2uzR5WmQHT8uRQk=;
        b=4q8YJJs9whyY04V4tKgQz/IWYaeWn1wn4MDo4TEHANyLyJIDEKTGZuSnPIRgTtB8m4YrpC
        b0NbmGCacnKnFeKV1Aqr4RMO25XbB7njzjMPS3P3ARz/S4TJ1qSJAc5cFvq3mIqQd2ETV0
        YevUj7YAloxfq64UpXfcpw6hK865mRW1X85vCJOZsZ5GgsRwm0Pun5wrSzcWm3Rd2lprSy
        sI3s/X9wErIgkJ0e15fURVdAR82NekedFjhY7ru5/UxGosI40EfmY0qbWNLGr19jN+nqIN
        moW4oF/6KQJ8HFOrzeyUuxnrE42NTUs9cPrv8lu63R1P+yEwBwv5XGG4HZ0ARA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687792097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hK4yC8RN+DUk4iitIMpk3vCapda2uzR5WmQHT8uRQk=;
        b=b05InQcL5E1jSf5sYoGqjBvmgG1KbnE8xqsZVu3VH9LeAxIhQW/JRbZKK5MvhUqhLBPgMw
        +KnRdRZtzcPPBrCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Martin Hicks <martin@sr-research.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: POSIX timer wakeups not preempting RT threads
Message-ID: <20230626150816.RW-ysAqX@linutronix.de>
References: <CAMkvodZZKriPgWVwQ7R6ZS9eSbmmE3FC3f35QLg6u40NsnGJpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMkvodZZKriPgWVwQ7R6ZS9eSbmmE3FC3f35QLg6u40NsnGJpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-06-23 13:15:11 [-0400], Martin Hicks wrote:
> Hi,
Hi,

> 
> I'm looking at using a POSIX timer to cause an action to be run every
> 500us, but I'm seeing that when the hrtimer fires while the CPU is
> busy running another SCHED_RR/SCHED_FIFO process that the hrtimer is
> deferred until the process releases the CPU.  I'm using SIGEV_SIGNAL
> to deliver the timer expiry to a thread that's running at a higher RT
> Priority than the other tasks, but no preemption seems to occur.
> 
> If the "other" tasks are running with SCHED_OTHER then the signal is
> delivered immediately.
> 
> I've tried using 'cset shield -c 1' and without (just pinning use
> taskset -c 1), and modified priorities and scheduler with chrt.
> The test is running on x86_64 with 6.3.9-rt15. PREEMPT_RT is enabled.
> 
> A simple test that illustrates the idea is attached.
> Is this supposed to work?

Well, "work". If you have a SCHED_RR/FIFO task and setup a timer
(clock_nanosleep()) then the wakeup is precise/ direct (hw timer ->
wakeup of the task).
POSIX timer are a bit special due to how they have to be processed. As a
consequence, the wake up path is (hw timer -> ktimers/$CPU thread ->
wakeup of the task via a signal).
That ktimers/$CPU thread runs at SCHED_FIFO 1 priority. If there a task
with higher priority then timer handling get deferred. This sounds like
what you observe.
That ktimers/$CPU is also in charge of waking all non-RT threads.

> mh

Sebastian
