Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67252C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 09:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F6D610CB
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 09:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhJ2JpH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Oct 2021 05:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJ2JpH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Oct 2021 05:45:07 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B24C061570;
        Fri, 29 Oct 2021 02:42:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e2so15872841ljg.13;
        Fri, 29 Oct 2021 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUZwq/1zRVot/m4BkJ4rPIhNZn7JplNtfTPmyiUeHgQ=;
        b=KVDohj5KYCE9Wg2bGbZ1h8TmmhsNRShxs2f2bC5lFyLFz6BnMzUIWoShB6Px+EncKo
         rwqw/eyvNbQba7I1pYOf5YWuBmzTspZ02sznpmscB2wSrfZm0miCj1aw28W1mjJnTC0r
         tXt5b7ikg7l0JmX7ZBL/hyRRF2H5dYu1kDkstoupFOA51OZMZYTfnz/sQWnBbBJLLsjP
         WQzwPD10LVXK2Nb8JLUjT+G0ZDrzP7/6rPv2mOWMy1vqAroh4dvWMFMe+wBhObpKTSf7
         yZTn6xb7l/7hP6EuxME1A6kKrXYL1Na4SNSdVO+Q8WiamtlhKAKQdXmTBR/K8MagmuJZ
         O4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUZwq/1zRVot/m4BkJ4rPIhNZn7JplNtfTPmyiUeHgQ=;
        b=hbPgLkXoG/RXe7TVGxvYfp+2y62lNZasixK2K2Wdx446fg4m1D5Y0LfsxycY7xWeGK
         JVQTiUJ08D8QZtpYlikAatH14eEdzlw0apJWh1h9QEgQr1sUJ8QkoXvrMzHSfvXZu+sS
         qUtKid4xTLF/3cF0/bYBAgtx4nHHcc2X+ZdJOdA9Gs07V1884O2G3TzXpt6l8e0XRe6v
         ob3rzZyUxFcI8GQFMLX0VcEYoBuEXDI+dHviTwbEtXkYYf98HNlNDGJtZtf9Rn7eZ4qd
         ZK+VowwneZwH+XdXfux61KJ/i3M0SiDVnbqNRJ5mdQvqkiGi6YO4Uf29dPbFm+8+CwCJ
         1Jmg==
X-Gm-Message-State: AOAM533AgUjgKiL8J1O3S1yJJqg7zyUuWns+6Z7TP677hb6s2o8MM9eb
        rxDyB6cQOu9Ydf+06u5EfG5vg29Z/gHHW7QAcOt9HPX4FFA=
X-Google-Smtp-Source: ABdhPJyubNsgbqv4XY/VjVoMkl1xWj6VlS1MdprrIxo6bss7YKc6XFLOOTv8kpzsRNOI4ePmIvKpB67BQ2jD2/TwUHk=
X-Received: by 2002:a2e:361a:: with SMTP id d26mr11017101lja.104.1635500556936;
 Fri, 29 Oct 2021 02:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAMJ=MEd9WuGA0MN+n0rGD6T+sgd=yciTmeEW9TjRjNXt+cF=qQ@mail.gmail.com>
 <20211027165800.md2gxbsku4avqjgt@linutronix.de> <CAMJ=MEfkQ9VaphaNS_qbWMOANo7P6h2Ln6iYg4JLWbWzxp85mA@mail.gmail.com>
 <20211028084654.bgtvnibvqnz2o5rh@linutronix.de>
In-Reply-To: <20211028084654.bgtvnibvqnz2o5rh@linutronix.de>
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Fri, 29 Oct 2021 11:42:25 +0200
Message-ID: <CAMJ=MEez-+0mj2N0rz79eE5gJG2k99Yh+x8vdEG3YK1apiOuzg@mail.gmail.com>
Subject: Re: Unbounded priority inversion while assigning tasks into cgroups.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Op do 28 okt. 2021 om 10:46 schreef Sebastian Andrzej Siewior
<bigeasy@linutronix.de>:
>
> On 2021-10-27 22:54:33 [+0200], Ronny Meeus wrote:
> > > From a looking at percpu_rw_semaphore implementation, no new readers are
> > > allowed as long as there is a writer pending. The writer has
> > > (unfortunately) to wait until all readers are out. But then I doubt that
> > > this takes up to two minutes for all existing readers to leave the
> > > critical section.
> > >
> >
> > The readers can be running at low priority while there can be other threads
> > with a medium priority will consume the complete cpu. So the low prio
> > readers are just waiting to be scheduled and by that also block the high
> > prio thread.
>
> Hmm. So you have say, 5 reads stuck in the RW semaphore while preempted
> be medium tasks and high-prio writer is then stuck on semaphore, waiting
> for the MED tasks to finish so the low-prio threads can leave the
> criticial section?

Correct. Note that 1 thread stuck in the read is already sufficient to
get into this.
Most of the heavy processing is done at medium priority and the
background tasks are running at the low priority.
Since the background tasks are implemented by scripts, a lot of
accesses to the read part are done at low prio.

> > Looking at v4.9.84, at least the RT implementation of rw_semaphore
> > > allows new readers if a writer is pending. So this could be culprit as
> > > you would have to wait until all reader are gone and the writer needs to
> > > grab the lock before another reader shows up. But then this shouldn't be
> > > the case for the generic implementation and new reader should wait until
> > > the writer got its chance.
> > >
> >
> > So what do you suggest for the v4.9 kernel as a solution? Move to the RT
> > version of the rw_semaphore and hope for the best?
>
> I don't think it will help. Based on what you wrote above it appears
> that the problem is that the readers are preempted and are not leaving
> the critical section soon enough.
>
> How many CPUs do you have? Maybe using a rtmutex here and allowing only
> one reader at a time isn't that bad in your case. With one CPU for
> instance, there isn't much space for multiple readers I guess.
>

The current system has 1 CPU with 2 cores but we have also devices
with 14 cores on which the impact will be bigger of course.
Note that with the rtmutex solution all accesses (read + write) will
be serialized.

I wonder why other people do not see this issue since it is present in
all kernel versions.
And, especially in systems with strict deadlines, I consider this a
serious issue.

Ronny

> Sebastian
