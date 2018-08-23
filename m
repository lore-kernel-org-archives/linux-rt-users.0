Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.santannapisa.it ([193.205.80.99]:51229 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbeHWQ2E (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Aug 2018 12:28:04 -0400
Date: Thu, 23 Aug 2018 14:58:17 +0200
From: luca abeni <luca.abeni@santannapisa.it>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <20180823145817.53361e32@luca64>
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

> On 23/08/18 12:43, luca abeni wrote:
> > On Thu, 23 Aug 2018 12:23:50 +0200
> > Juri Lelli <juri.lelli@gmail.com> wrote:  
> 
> [...]
> 
> > > But then what is a sane inheritance mechanism?  
> > 
> > In my understanding (please correct me if I am wrong), this is an
> > orthogonal issue: if I understand well, the issue preventing
> > non-root usage of SCHED_DEADLINE is that a task inheriting a dl
> > entity is not throttled (when the current runtime rrives to 0, the
> > deadline is postponed, but the task stays schedulable). So, I think
> > that removing this behaviour should allow to use SCHED_DEADLINE
> > without starving other tasks...  
> 
> Right, potential starvation would be gone...
> 
> > Then, there is the issue about the deadline and runtime to inherit.
> > And I agree that this is important (and the solution is not easy),
> > but you have this issue even if you use the current "dl_boosted"
> > behaviour... No?  
> 
> ... but, while it's true that current inheritance has problems w/ o
> w/o boosting behaviour, I wonder if the problem might be more painful
> for a normal user that it's still under runtime enforcement.

I think that the only way to have an answer to this doubt is to try :)


> Disabling
> enforcement seems to hide a bit the fact that we need proper
> inheritance. :-(

My impression is that it hides the problem in some situations, but
the Murphy law ensures that the issue will appear when the quality of
the audio is more important :)


			Luca
