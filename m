Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44907 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTMJK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Aug 2018 08:09:10 -0400
Received: by mail-wr1-f51.google.com with SMTP id r16-v6so12276205wrt.11
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Aug 2018 01:54:24 -0700 (PDT)
Date: Mon, 20 Aug 2018 10:54:20 +0200
From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <20180820085420.GB8866@localhost.localdomain>
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tim Blechmann <tim@klingt.org>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Luca Abeni <luca.abeni@santannapisa.it>

On 18/08/18 15:26, Tim Blechmann wrote:
> >> audio applications typically use SCHED_FIFO. however they are
> >> rate-monotonic by design, so i wanted to evaluate how SCHED_DEADLINE
> >> behaves here.
> > 
> > Right. Exactly what I started to think about lately as well.
> > 
> >>
> >>> Asking because we might want to have a look at how to relax the current
> >>> privileges requirement.
> >>
> >> please :)
> > 
> > Anything to try attracting new users. :-P
> > 
> > More seriously, could you please describe in a bit more details your
> > specific use case? Based on JACK I guess? Is it the application you are
> > interested into public available somewhere?
> 
> it could be based on JACK or natively on ALSA. furthermore the fun part
> starts when trying to distribute work to multiple threads: during the
> time slice of one audio callback (could be as low as 1.3ms), we need to
> wake helper threads and (busy?)wait to collect all the results. (while
> one of the applications is open source, it's not entirely
> straight-forward to use)
> 
> for me it's more an investigation if SCHED_DEADLINE is actually feasible
> in real-world audio application these days. tommaso used to have a
> research prototype [1], built directly into JACK. however currently i'd
> be more interested in using it in ALSA. but yeah, it's more an
> investigation as SCHED_FIFO does a decent job for my use case ...

I (almost) see. Thanks for the details.

> [1] http://retis.sssup.it/~tommaso/publications/LAC-2011.pdf

So, this was IIRC using AQuoSA hierarchical RT on EDF scheduler
implementation; which it was handy to easy the task of assigning CBS
server parameters to JACK clients (graph).

In your case - assuming you could already use DEADLINE for !root - do
you think you would need to use the same interface for the multiple
threads you are distributing work among? Or would you be fine with
assigning runtime/deadline for each one of those?

BTW, cc-ing Tommaso and Luca. Discussion started from
https://www.spinics.net/lists/linux-rt-users/msg19296.html
