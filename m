Return-Path: <SRS0=Byy1=TB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D3C43219
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 17:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECA02075E
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 17:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEAR0U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 May 2019 13:26:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41125 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfEAR0U (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 May 2019 13:26:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D74803084248;
        Wed,  1 May 2019 17:26:19 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 587D776114;
        Wed,  1 May 2019 17:26:09 +0000 (UTC)
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
 with fsfreeze (4.19.25-rt16)
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, jack@suse.com,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ce854251-139e-15f1-2ac5-b66a27f8284c@redhat.com>
Date:   Wed, 1 May 2019 13:26:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501170953.GB2650@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 01 May 2019 17:26:20 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 5/1/19 1:09 PM, Peter Zijlstra wrote:
> On Tue, Apr 30, 2019 at 03:28:11PM +0200, Peter Zijlstra wrote:
>
>> Yeah, but AFAIK fs freezing code has a history of doing exactly that..
>> This is just the latest incarnation here.
>>
>> So the immediate problem here is that the task doing thaw isn't the same
>> that did freeze, right? The thing is, I'm not seeing how that isn't a
>> problem with upstream either.
>>
>> The freeze code seems to do: percpu_down_write() for the various states,
>> and then frobs lockdep state.
>>
>> Thaw then does the reverse, frobs lockdep and then does: percpu_up_write().
>>
>> percpu_down_write() directly relies on down_write(), and
>> percpu_up_write() on up_write(). And note how __up_write() has:
>>
>> 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
>>
>> So why isn't this same code coming unstuck in mainline?

That code is in just in the tip tree. It is not in the mainline yet. I
do realize that it can be a problem and so I have it modified to the
following in my part2 patchset.

static inline void __up_write(struct rw_semaphore *sem)
{
        long tmp;

        /*
         * sem->owner may differ from current if the ownership is
transferred
         * to an anonymous writer by setting the RWSEM_NONSPINNABLE bits.
         */
        DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
                            !((long)sem->owner & RWSEM_NONSPINNABLE), sem);

Maybe I should break this part out and have it merged into tip as well.

Cheers,
Longman

