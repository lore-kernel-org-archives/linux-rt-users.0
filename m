Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C7C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Sep 2021 09:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9256115C
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Sep 2021 09:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhI0Jch (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233650AbhI0Jcf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Sep 2021 05:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632735057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7NSp/vWgh0IQXSwoMraW7CkaYyKMLgroGH9C/clVag=;
        b=HQFctji/TTHQw/uQsBEHFwTDI1vgu2r3sVn4lxOQVYCjhCP+hBmL2pYXW6NtkpYYvXc3Ew
        TtaH6HoichbJZBCuYPRiMiz3amkeD64wWVXOZuT1fHifdgCRIHPjlOGaXESw43xuwMFaaQ
        ZKqvpOJBwVJeo1kqKE5dqnJoU6bGsXs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-9laSATOGNTiZYEIMhsdqWw-1; Mon, 27 Sep 2021 05:30:56 -0400
X-MC-Unique: 9laSATOGNTiZYEIMhsdqWw-1
Received: by mail-wr1-f72.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so13800745wrv.6
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Sep 2021 02:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K7NSp/vWgh0IQXSwoMraW7CkaYyKMLgroGH9C/clVag=;
        b=EscWi8O381coBBIjsgu1EjDbAh9+aE3dl6nKuRLn8Ghp6r/uWlF1TDdGUJvQMg+nV9
         ssPMOZm4/bAhM9Dpk57M0xWsHrlatcpnm9doESI4q/HWyihs6DJACNHnCNnCuhQi3rMC
         WQYk8Ij9rOXBsHWAHZ/RjT+Qvelu6ohBLcW0JFvH4xdkVu655sw4F/ZhijnpUHW/hsCx
         NF3fjy+oe4kQPU8i6UANToCVzWZpz/6DYRT9WOF0vrSSh1LfVXT3dMqJ06FpcxuhCww0
         GnSoiFTqoZ3TtQcN5E/BhSrB+dJGaI1XeEujiphCrLZ93+z6oG7bkLarvuwXc4Ii1peg
         M8Jw==
X-Gm-Message-State: AOAM532omjrFNr2ddF2Dlef/NpJKqZ+KJN6MvDYjBGfEJiZAU8W+2/w5
        DQYC3xYN9ajnkL+dJhfhYhXkC43fHfIKO5NiVpDP+dke7qba79qcBK8s0rP89cFFzExJ58xYD8W
        A2fsAxE+JIFAgeQvD/Syr9ozK+hw=
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr26326681wrd.24.1632735054900;
        Mon, 27 Sep 2021 02:30:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6b8PsqrofWNdXOOdYGB7TMIOeoLXw6T/j3GuUxYOkzE46cemEL5lj+Ydtl2K8rifSKmavPg==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr26326655wrd.24.1632735054634;
        Mon, 27 Sep 2021 02:30:54 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123? ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id n186sm19979340wme.31.2021.09.27.02.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 02:30:54 -0700 (PDT)
Message-ID: <8ee79b78c7f7f8fa18ec237494f09492ef60081f.camel@redhat.com>
Subject: Re: [PATCH 0/6] mm: Remote LRU per-cpu pagevec cache/per-cpu page
 list drain support
From:   nsaenzju@redhat.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@linux.com,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org
Date:   Mon, 27 Sep 2021 11:30:53 +0200
In-Reply-To: <87v92sgt3n.ffs@tglx>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
         <f608b4bf-aa36-b0c4-e748-4f39010f3d06@suse.cz>
         <20210922112817.GO4323@worktop.programming.kicks-ass.net>
         <87v92sgt3n.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Thomas,
thanks for the in-depth review.

On Thu, 2021-09-23 at 00:09 +0200, Thomas Gleixner wrote:
> On Wed, Sep 22 2021 at 13:28, Peter Zijlstra wrote:
> > On Tue, Sep 21, 2021 at 07:59:51PM +0200, Vlastimil Babka wrote:
> > 
> > > These days the pcplist protection is done by local_lock, which solved
> > > the RT concerns. Probably a stupid/infeasible idea, but maybe what you
> > > want to achieve could be more generally solved at the local_lock level?
> > > That on NOHZ_FULL CPUs, local_locks could have this mode where they
> > > could synchronize with remote cpus?
> > 
> > local_lock and spinlock have different rules, local_lock for example can
> > never cause an irq inversion, unlike a spinlock.
> 
> TBH, I really regret an attempt I made at some point in the RT
> development to abuse local locks for this kind of cross CPU protections
> because that led to yet another semantically ill defined construct.
> 
> local locks are as the name says strictly local. IOW, they do not exist
> for remote access. Just look at the !RT mapping:
> 
>   local_lock() 		-> preempt_disable()
>   local_lock_irq()	-> local_irq_disable()
>   ...
> 
> The only thing local_lock is addressing is the opaque nature of
> preempt_disable(), local*_disable/save() protected critical sections,
> which have per CPU BKL, i.e. undefined protection scope, semantics.
> 
> If you really want cross CPU protection then using a regular spinlock in
> a per CPU data structure is the right way to go.
> 
> That makes it a bit akward vs. the code at hand which already introduced
> local locks to replace the opaque preempt/local_irq disabled critical
> sections with scoped local locks which in turn allows RT to substitute
> them with strict CPU local spinlocks.
> 
> But for clarity sake we really have to look at two different cases now:
> 
>    1) Strict per CPU local protection
> 
>       That's what the code does today via local lock and this includes
>       RT where the locality is preserved via the local lock semantics
> 
>       I.e. for the !RT case the spinlock overhead is avoided 
> 
>    2) Global scoped per CPU protection
> 
>       That's what Nicolas is trying to achieve to be able to update
>       data structures cross CPU for the sake of avoiding smp function
>       calls or queuing work on remote CPUs for the NOHZ_FULL isolation
>       use case.
> 
> That said, I completely understand Andrew's concerns versus these
> distinctions and their test coverage.
> 
> In consequence the real interesting question here is whether any of
> these use cases are sensible to the extra overhead of #2.
> 
> IOW, does it really matter whether the !RT and !NOHZ_FULL case take an
> uncontended per CPU spinlock unconditionally instead of just disabling
> preemption / interrupts?
> 
> The same question arises vs. the remote work queuing. Does it really
> matter? I think that a proper investigation is due to figure out whether
> delegated work is really superiour vs. doing the same work locked from a
> remote CPU occasionally.
> 
> If you really think about it then the task which is initiating the work
> is already in a slow path. So what's the tradeoff to make this path a
> little bit slower due to remote access vs. scheduling work and thereby
> disturbing the remote CPU which has a performance impact as well and in
> the NOHZ_FULL case even a correctness impact? That's especially
> questionable for situations where the initiator has to wait for
> completion of the remote work.
> 
> The changelogs and the cover letter have a distinct void vs. that which
> means this is just another example of 'scratch my itch' changes w/o
> proper justification.

Point taken, I'll get to it.

-- 
Nicolás Sáenz

