Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.sssup.it ([193.205.80.99]:21474 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbeHWOZh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Aug 2018 10:25:37 -0400
Date: Thu, 23 Aug 2018 11:56:18 +0200
From: luca abeni <luca.abeni@santannapisa.it>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <20180823115618.5584687b@luca64>
In-Reply-To: <20180820085420.GB8866@localhost.localdomain>
References: <pl0fsj$ohn$1@blaine.gmane.org>
        <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
        <20180817095106.GB27071@localhost.localdomain>
        <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
        <20180817102810.GC27071@localhost.localdomain>
        <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
        <20180820085420.GB8866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Tim Blechmann <tim@klingt.org>, Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>

Hi Juri,

sorry for the late reply (I am just back from vacations), and thanks
for cc-ing me.

I see you opened a bug on github about this, so I am going to add more
details there, but basically I think that in order to use
SCHED_DEADLINE as non-root we need to:
1) Disable the boosting mechanism (not the inheritance, just the "soft
   enforcement behaviour" of tasks holding mutexes)
2) Implement some mechanism to limit the amount of dl bandwidth a user
   can allocate to itself (I think the cgroup-based approach we
   discussed some time ago should be OK... If I remember well, you even
   had a patch implementing it :)



				Luca

On Mon, 20 Aug 2018 10:54:20 +0200
Juri Lelli <juri.lelli@gmail.com> wrote:

> On 18/08/18 15:26, Tim Blechmann wrote:
> > >> audio applications typically use SCHED_FIFO. however they are
> > >> rate-monotonic by design, so i wanted to evaluate how
> > >> SCHED_DEADLINE behaves here.  
> > > 
> > > Right. Exactly what I started to think about lately as well.
> > >   
> > >>  
> > >>> Asking because we might want to have a look at how to relax the
> > >>> current privileges requirement.  
> > >>
> > >> please :)  
> > > 
> > > Anything to try attracting new users. :-P
> > > 
> > > More seriously, could you please describe in a bit more details
> > > your specific use case? Based on JACK I guess? Is it the
> > > application you are interested into public available somewhere?  
> > 
> > it could be based on JACK or natively on ALSA. furthermore the fun
> > part starts when trying to distribute work to multiple threads:
> > during the time slice of one audio callback (could be as low as
> > 1.3ms), we need to wake helper threads and (busy?)wait to collect
> > all the results. (while one of the applications is open source,
> > it's not entirely straight-forward to use)
> > 
> > for me it's more an investigation if SCHED_DEADLINE is actually
> > feasible in real-world audio application these days. tommaso used
> > to have a research prototype [1], built directly into JACK. however
> > currently i'd be more interested in using it in ALSA. but yeah,
> > it's more an investigation as SCHED_FIFO does a decent job for my
> > use case ...  
> 
> I (almost) see. Thanks for the details.
> 
> > [1] http://retis.sssup.it/~tommaso/publications/LAC-2011.pdf  
> 
> So, this was IIRC using AQuoSA hierarchical RT on EDF scheduler
> implementation; which it was handy to easy the task of assigning CBS
> server parameters to JACK clients (graph).
> 
> In your case - assuming you could already use DEADLINE for !root - do
> you think you would need to use the same interface for the multiple
> threads you are distributing work among? Or would you be fine with
> assigning runtime/deadline for each one of those?
> 
> BTW, cc-ing Tommaso and Luca. Discussion started from
> https://www.spinics.net/lists/linux-rt-users/msg19296.html
