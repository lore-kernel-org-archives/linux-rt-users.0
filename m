Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from smtp-sp200-214.kinghost.net ([177.185.200.214]:46981 "EHLO
        smtp-sp200-214.kinghost.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbeHTPyP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Aug 2018 11:54:15 -0400
Received: from smtp200-farm64.kinghost.net (smtp200-farm64 [127.0.0.1])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-sp200-214.kinghost.net (Postfix) with ESMTPS id DFB7E13FEEAE3
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Aug 2018 09:38:29 -0300 (BRT)
Received: from smtpi-sp-232.kinghost.net (smtpi-sp-232.kinghost.net [177.185.201.232])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp200-farm64.kinghost.net (Postfix) with ESMTPS id D353FB6C07A54
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Aug 2018 09:38:29 -0300 (BRT)
Subject: Re: SCHED_DEADLINE as user
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
 <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
From: Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <4c58c94c-d99d-9f08-a5a3-710defc612c8@bristot.me>
Date: Mon, 20 Aug 2018 14:38:09 +0200
MIME-Version: 1.0
In-Reply-To: <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tim Blechmann <tim@klingt.org>, Juri Lelli <juri.lelli@gmail.com>
Cc: linux-rt-users@vger.kernel.org, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Luca Abeni <luca.abeni@santannapisa.it>



On 08/20/2018 01:54 PM, Tim Blechmann wrote:
>> In your case - assuming you could already use DEADLINE for !root - do
>> you think you would need to use the same interface for the multiple
>> threads you are distributing work among? Or would you be fine with
>> assigning runtime/deadline for each one of those?
> 
> that's a tricky question and depends on the use-case: for me it's "good
> enough" to use something like:
> 
> main audio thread:
> while running:
>   snd_pcm_read  // blocks until data is delivered from ALSA
>   wake helper(s)
>   do work()
>   sync_with_helper(s)
>   snd_pcm_write // blocks until data is delivered to ALSA
> 
> alsa is basically driven by the hardware, which delivers/requests data
> every ~1.3ms.

Hi Tim!

> 
> distributing the work is a little tricky: to avoid excessive scheduling
> overhead, the worker threads are typically woken up (after snd_pcm_read)
> and the result is collected where sync_with_helper() typically boils
> down to busy waiting. in this case, the workers as rate-monotonic in a
> similar manner as the main audio thread.

When you say "rate-monitonic", do you mean that the worker threads with
smaller period (high rate, so) have a higher fixed-priority? If so, what
are the other periods?

as sync_with_helper() does a busy-wait, the "main audio thread" has a
relative lower priority than the worker threads, right?

> one could also use lock-free queues with semaphores to wake only as many
> threads as needed for the graph topology (which can depend on user
> input). in this case SCHED_FIFO sounds more suitable.
> --
> 
> from a practical point of view: i'm not targeting a safety critical
> system. one advantage i'm seeing of DEADLINE over FIFO/RR is that it's
> easier to prevent lockups (e.g. when a user overloads the system). in
> the linux audio world this is typically done by a watchdog thread. the
> other part of the unix world (mach) is using time-constraint threads by
> default for audio use cases. so i'd assume that DEADLINE would free me
> from the need to spawn the watchdog thread ...

So, your main wish here is to avoid having a watchdog thread to
"throttle" misbehaving workload/setup?

For curiosity, what are the "time-constraints" setup used on mach?

-- Daniel
