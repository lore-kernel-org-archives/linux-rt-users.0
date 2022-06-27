Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A39C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jun 2022 23:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbiF0XXk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbiF0XXj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Jun 2022 19:23:39 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C352622B18
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jun 2022 16:23:36 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ef5380669cso100258117b3.9
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jun 2022 16:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=g5FpzbgzyTi7QS1EYBh4dLkzqBRUxAUBHkmhjlyD/TI=;
        b=DmB26aY/aEv8T76HvMt5mKRmSmWJj6Dsds39w/K10kmTu+BFeGtzOVj19hz1fCaxbY
         +0ClO5WYk7D1by6PXZh9cwFtq/5MU4/FRGTLZkRxS43w0GHNYog0iDaKod82wRMhXfof
         PKmGUWmXwGL454vCm/fwisqG2Y/sdofIb89tFsbI2RpX7OAbvp/43Q8TixS6RDsFWp4S
         tDKutSac5rp8IDjU1PyLFJkN7wB1apOlVjVQM1APgAZ49zAY5BY7h7JVZXjQFqJXEKDj
         jqPw1vkGSlfhe3o693xUii+ZpX1g/xNWn26N3rrGXVHumi4KR6NxfmqV9oJntVebx//i
         P8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=g5FpzbgzyTi7QS1EYBh4dLkzqBRUxAUBHkmhjlyD/TI=;
        b=raVBNdbStsfYrni3ZApOMIGgM+Rx/9qEz8qmOGhkGj/8desI4Qa45Ovedx9oPnXnw9
         P0An8krG7FgqjhezdiUHhSb/Kwcb4Qav+hKQt3Halckmrkw8wfx6yipaGLHAM4lprQKl
         VGVs5io5T+MC5LZ1+oo4a/e0R/j+P8LRWGqukXGymIquLth9svOxLQ9hC7vQ5Jb51EgO
         0RZZ1G0l9BoUE6fYJi/t/uk5v1EngOPTiGlfFbNb+bYi5FwW+jmfYKuv1Ehswk/eWV/r
         c3ngMfSTcJrbKNSe3j1trMwdAKCzlVaiauGOaSdIKXOxmbJvKRdRirDyofRmaRSZCXy9
         wUhA==
X-Gm-Message-State: AJIora8geFInluzEeyFK+mKt4YDgdKunwXq4AX6qlEW4f3B0guPLYIxj
        THBevFuOE338bCY+zOhsKA9e2lmGeQKyZoHyVvSbm3Ldd0goSw==
X-Google-Smtp-Source: AGRyM1tmV7S46YaqJWEaCstxT5ufk3BixUl+dGR7WX8YPBP6IuoS7qcqSFePp2U+GloNmkRog9qVvdIABI5GPGdBGfc=
X-Received: by 2002:a81:ad1:0:b0:318:3b63:6d00 with SMTP id
 200-20020a810ad1000000b003183b636d00mr18625902ywk.146.1656372215972; Mon, 27
 Jun 2022 16:23:35 -0700 (PDT)
MIME-Version: 1.0
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Mon, 27 Jun 2022 16:23:25 -0700
Message-ID: <CAFzL-7v-NSFKAsyhxReEES7bMomSTwYyrZscnjbkydEP3CTXmQ@mail.gmail.com>
Subject: late ktimer events due to C-state transitions
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Rami Jaber <rjaber@aurora.tech>, Glenn Elliott <glenn@aurora.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We observe late ktimer events due to C-state transitions from CPU Idle
mode.  The test results come from a 5.15-rt kernel with two
timers-related patches backported:

    "softirq: Use a dedicated thread for timer wakeups." from Sebastian via
     https://lore.kernel.org/linux-rt-users/20211201173316.rm6o67qapqsx2n47=
@linutronix.de/

and

     "tick: Fix timer storm since introduction of timersd" from Frederic vi=
a
     https://lore.kernel.org/linux-rt-users/20220405010752.1347437-2-freder=
ic@kernel.org/

The kernel is configured with NO_HZ_COMMON=3Dy and NO_HZ_IDLE=3Dy.

Expected sequence of events:
@ 0ms: userspace enqueues a timer event to fire in 10ms from now
@ 10ms: ktimer event fires and triggers the online_periodic callback
@ 10ms: userspace enqueues a timer event to fire in 10ms from now
@ 20ms: ktimer event fires and triggers the online_periodic callback
...

What we=E2=80=99re actually seeing via kprobes:
@ 0ms: userspace enqueues a timer event to fire in 10ms from now
@ 10ms: ktimer event fires and triggers the online_periodic callback
@ 10ms: userspace enqueues a timer event to fire in 10ms from now
@ 15ms: CPU enters a deep idle state and sleeps for a long time
(20-100+)ms, let's say 70ms for this example
@ 80ms: ktimer event fires and triggers the online_periodic callback
@ 80ms: userspace enqueues a timer event to fire in 10ms from now

The result is that the second timer callback runs after 75ms instead
of the expected 10ms.


When the timers work well, the hrtimer_interrupt causes
raise_hrtimer_softirq() to run, as expected and __do_softirq() runs:
<userspace>-13534   [007] 16947.039513: enqueue_hrtimer
          <idle>-0       [007] 16947.039555:
hrtimer_next_event_without: 16947.037643167
          <idle>-0       [007] 16947.039562: enqueue_hrtimer
          <idle>-0       [007] 16947.049453: hrtimer_interrupt
          <idle>-0       [007] 16947.049457: raise_hrtimer_softirq.
          <idle>-0       [007] 16947.049474: enqueue_hrtimer
       ktimers/7-80      [007] 16947.049483: __do_softirq
       ktimers/7-80      [007] 16947.049485: hrtimer_run_softirq.
 <userspace>-13534   [007] 16947.049523: enqueue_hrtimer
          <idle>-0       [007] 16947.049567:
hrtimer_next_event_without: 16947.047643167
          <idle>-0       [007] 16947.049573: enqueue_hrtimer
          <idle>-0       [007] 16947.049586: enqueue_hrtimer
          <idle>-0       [007] 16947.049594:
hrtimer_next_event_without: 16947.047643167
          <idle>-0       [007] 16947.049598: enqueue_hrtimer
          <idle>-0       [007] 16947.059418: hrtimer_interrupt
          <idle>-0       [007] 16947.059423: raise_hrtimer_softirq.
          <idle>-0       [007] 16947.059441: enqueue_hrtimer
       ktimers/7-80      [007] 16947.059449: __do_softirq
       ktimers/7-80      [007] 16947.059451: hrtimer_run_softirq.
 <userspace>-13534   [007] 16947.059490: enqueue_hrtimer
          <idle>-0       [007] 16947.059529:
hrtimer_next_event_without: 16947.057643167
          <idle>-0       [007] 16947.059531: enqueue_hrtimer
          <idle>-0       [007] 16947.069434: hrtimer_interrupt

When the timers are delayed, the trouble appears to begin when the
hrtimer_interrupt results in execution of hrtimer_run_queues() instead
of raise_hrtimer_softirq():
 <userspace>-13534   [007] 16947.069504: enqueue_hrtimer
          <idle>-0       [007] 16947.069547:
hrtimer_next_event_without: 16947.067643167
          <idle>-0       [007] 16947.069553: enqueue_hrtimer
          <idle>-0       [007] 16947.069567: enqueue_hrtimer
          <idle>-0       [007] 16947.069575:
hrtimer_next_event_without: 16947.067643167
          <idle>-0       [007] 16947.069579: enqueue_hrtimer
          <idle>-0       [007] 16947.078270: hrtimer_interrupt
          <idle>-0       [007] 16947.078278: hrtimer_run_queues.
          <idle>-0       [007] 16947.078300: enqueue_hrtimer
       ktimers/7-80      [007] 16947.078308: __do_softirq
     ksoftirqd/7-81      [007] 16947.078338: ksoftirqd_should_run 0
          <idle>-0       [007] 16947.078361:
hrtimer_next_event_without: 16947.067643167
          <idle>-0       [007] 16947.079323: hrtimer_interrupt
          <idle>-0       [007] 16947.079328: hrtimer_run_queues.
          <idle>-0       [007] 16947.079334: enqueue_hrtimer
     ksoftirqd/7-81      [007] 16947.079359: ksoftirqd_should_run 128
     ksoftirqd/7-81      [007] 16947.079360: __do_softirq
     ksoftirqd/7-81      [007] 16947.079361: hrtimer_interrupt
     ksoftirqd/7-81      [007] 16947.079361: raise_hrtimer_softirq.
     ksoftirqd/7-81      [007] 16947.079364: ksoftirqd_should_run 0
          <idle>-0       [007] 16947.079375:
hrtimer_next_event_without: 9223372036854775807
          <idle>-0       [007] 16947.079376:
tick_nohz_get_sleep_length: 86.838 ms
          <idle>-0       [007] 16947.079378: enqueue_hrtimer

Is the problem perhaps that ksoftirqd_should_run() needs to check
local_timer_softirq_pending() created by Frederic's patch as well as
local_softirq_pending()?

For the moment, we find that replacing NO_HZ_COMMON=3Dy and NO_HZ_IDLE=3Dy
with NO_HZ_PERIODIC prevents the undesirable sleep-state transition,
but clearly this solution is not ideal.

Thanks for any suggestions,
Alison Chaiken
achaiken@aurora.tech
Aurora Innovation
