Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from ms01.santannapisa.it ([193.205.80.99]:24979 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeHULO2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Aug 2018 07:14:28 -0400
Subject: Re: SCHED_DEADLINE as user
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
 <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
 <4c58c94c-d99d-9f08-a5a3-710defc612c8@bristot.me>
 <dfe1cea0-089d-fed9-a349-23de2660889e@klingt.org>
 <e207a65d-b1af-3fb1-8802-d1c05c0a9118@bristot.me>
 <05fbd5a4-f354-e084-cf40-8488548d7cb1@klingt.org>
From: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Message-ID: <cc32702c-b0e0-86e0-0382-3b266d382771@santannapisa.it>
Date: Tue, 21 Aug 2018 08:55:18 +0200
MIME-Version: 1.0
In-Reply-To: <05fbd5a4-f354-e084-cf40-8488548d7cb1@klingt.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tim Blechmann <tim@klingt.org>, Daniel Bristot de Oliveira <daniel@bristot.me>, Juri Lelli <juri.lelli@gmail.com>
Cc: linux-rt-users@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>, Alessio Balsini <alessio.balsini@santannapisa.it>

Hi all,

+cc-ing Alessio, who has been working on this just recently on Android (will tell more answering on a different msg).

On 20/08/2018 18:45, Tim Blechmann wrote:
> the mach API also has this notion of "period == 0", but apart from that it's quite similar. 

in terms of API, XNU time constrained threads look like DEADLINE, however in terms of kernel behavior/implementation 
behind that, it's something completely different: last time I had a glance at this, it was .... ehm .... probably just 
during that old Linux Audio Conference (LAC) back in 2011, where the take away was: 1) in the kernel there's nothing 
like the CBS or deadline-based scheduling, but just a heuristic boosting a bit more those tasks, accompanied by usual 
heuristics to de-boost in case the task becomes CPU-intensive (similar to CFS heuristics for interactive-vs-batch); 2) 
the only user of that API seemed to be some sound daemon on OS-X, that had an almost random value set as "runtime", 
accompanied by a comment "this just works" ;-P

But, it was long ago, if anyone has a pointer to what XNU does with time constrained threads in these days....

> apart from that, i'm only missing two features:
>
> * using SCHED_DEADLINE from user applications is kind of a showstopper
> for me

unprivileged tasks using DEADLINE remained a request for quite a long time -- that old single-processor implementation 
(AQuoSA) we used long ago with JACK had such a feature, that was implementing this model:

   http://retis.sssup.it/~tommaso/papers/rtas08.php

the criticality for DEADLINE is that those tasks preempt RT99 ones, so even with controlled runtime/deadline boundaries....
> * a nicer glibc wrapper, that allows me to use pthreads rather than
> using `syscall`: it's all pretty easy to obtain the `tid` for a calling
> thread (gettid), but it seems to be impossible to obtain the `tid` from
>   `pthread_t` without some hacks which are way too dirty to share in
> public ...

well-known "pain" as well, thanks.

     T.

-- 
Tommaso Cucinotta, Computer Engineering PhD
Associate Professor at the Real-Time Systems Laboratory (ReTiS)
Scuola Superiore Sant'Anna, Pisa, Italy
http://retis.sssup.it/people/tommaso
