Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.santannapisa.it ([193.205.80.99]:64873 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeHUKg1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Aug 2018 06:36:27 -0400
Subject: Re: SCHED_DEADLINE as user
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
 <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
From: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Message-ID: <0a8f899a-589d-a84b-dadb-50def9c0b4c3@santannapisa.it>
Date: Tue, 21 Aug 2018 09:17:27 +0200
MIME-Version: 1.0
In-Reply-To: <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tim Blechmann <tim@klingt.org>, Juri Lelli <juri.lelli@gmail.com>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>, Alessio Balsini <alessio.balsini@santannapisa.it>

[copying Alessio]

Hi,

On 20/08/2018 13:54, Tim Blechmann wrote:
> that's a tricky question and depends on the use-case: for me it's "good
> enough" to use something like:
>
> main audio thread:
> while running:
>    snd_pcm_read  // blocks until data is delivered from ALSA
>    wake helper(s)
>    do work()
>    sync_with_helper(s)
>    snd_pcm_write // blocks until data is delivered to ALSA
>
> alsa is basically driven by the hardware, which delivers/requests data
> every ~1.3ms.

this is exactly the use-case we considered in that old paper back in LAC 2011, and let me just add that there is more 
experimentation and details and results in Giacomo's MSc thesis:

   https://retis.sssup.it/?q=node/77

FYI, we restarted activities on this use-case just recently, considering a couple of further dimensions:

1) support for heterogeneous platforms with the aim of achieving a sound support for Arm big.LITTLE on Android, and 
apply it to the Android video & audio processing pipelines;

2) proper consideration of power switching capabilities of the platform (assuming the user would block the CPU frequency 
to its maximum is not really multimedia-friendly);

3) support for multi-threaded processing workflows on multi-cores, as typically needed by (high-performance) audio 
applications, either with a single multi-threaded audio processing client, or, e.g., with JACK, with a DAG of 
computations that can take advantage of underlying multi-core processing.

In this context, we've been playing also with the hierarchical extension to SCHED_DEADLINE we sent last year on LKML

   https://lkml.org/lkml/2017/3/31/658

I hope we can share some good write-up & experimental results pretty soon about some of the above...
> distributing the work is a little tricky: to avoid excessive scheduling
> overhead, the worker threads are typically woken up (after snd_pcm_read)
> and the result is collected where sync_with_helper() typically boils
> down to busy waiting. in this case, the workers as rate-monotonic in a
> similar manner as the main audio thread.
>
> one could also use lock-free queues with semaphores to wake only as many
> threads as needed for the graph topology (which can depend on user
> input). in this case SCHED_FIFO sounds more suitable.

proper handling of task dependencies & synchronization, and associated priority inversion issues, is also an aspect 
we've been and we're still working on, as when you mix DEADLINE tasks in the picture, it's a big mess.
> from a practical point of view: i'm not targeting a safety critical
> system. one advantage i'm seeing of DEADLINE over FIFO/RR is that it's
> easier to prevent lockups (e.g. when a user overloads the system). in
> the linux audio world this is typically done by a watchdog thread. the
> other part of the unix world (mach) is using time-constraint threads by
> default for audio use cases. so i'd assume that DEADLINE would free me
> from the need to spawn the watchdog thread ...

I'm not sure I'm getting this: AFAIU, from this viewpoint, what you could get
with DEADLINE, is very similar to what you can get already with RT throttling
on RT (RR/FIFO), setting up properly CPU cgroups & limits. Why do you think
DEADLINE would allow you to avoid a watchdog thread, that you need with
RT instead ?

Thanks,

     T.

-- 
Tommaso Cucinotta, Computer Engineering PhD
Associate Professor at the Real-Time Systems Laboratory (ReTiS)
Scuola Superiore Sant'Anna, Pisa, Italy
http://retis.sssup.it/people/tommaso
