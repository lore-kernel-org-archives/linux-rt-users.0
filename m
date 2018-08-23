Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.sssup.it ([193.205.80.99]:16715 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbeHWQaW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Aug 2018 12:30:22 -0400
Date: Thu, 23 Aug 2018 15:00:40 +0200
From: luca abeni <luca.abeni@santannapisa.it>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <20180823150040.7da1624f@luca64>
In-Reply-To: <20180823123739.GC31443@localhost.localdomain>
References: <pl0fsj$ohn$1@blaine.gmane.org>
        <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
        <20180817095106.GB27071@localhost.localdomain>
        <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
        <20180817102810.GC27071@localhost.localdomain>
        <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
        <20180820085420.GB8866@localhost.localdomain>
        <20180823115618.5584687b@luca64>
        <20180823102350.GB31443@localhost.localdomain>
        <20180823124340.765632d8@luca64>
        <20180823123739.GC31443@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Tim Blechmann <tim@klingt.org>, Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>

On Thu, 23 Aug 2018 14:37:39 +0200
Juri Lelli <juri.lelli@gmail.com> wrote:
[...]
> > > Maybe the existing system wide sched_rt_{period,
> > > runtime}_us are enough?  
> > 
> > I do not know... A cgroup-based interface looks more powerful (and
> > not so difficult to implement... :), and would allow the sysadmin
> > to decide which users can use SCHED_DEADLINE, how much
> > SCHED_DEADLINE bandwidth can each user/group use, etc...  
> 
> How about extending PAM limits instead? It looks like it's what (e.g.)
> audio users rely on already [1]. It is maybe possible to add
> dlruntime, dlperiod, dldeadline parameters in there?

Ok, I do not know much about these PAM limits... Where can I find more
information? What do we need to implement exactly, to add these
dlruntime, dlperiod, dldeadline parameters?


			Thanks,
				Luca
