Return-Path: <SRS0=Z5tp=YA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38524ECE58C
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 17:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B1220684
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 17:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfJGRgt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:36:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfJGRgs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Oct 2019 13:36:48 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iHWw8-0001MQ-J4; Mon, 07 Oct 2019 19:36:44 +0200
Date:   Mon, 7 Oct 2019 19:36:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191007173644.hiiukrl2xryziro3@linutronix.de>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191007083037.zu3n5gindvo7damg@beryllium.lan>
 <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
 <20191007162330.GA26503@pc636>
 <20191007163443.6owts5jp2frum7cy@beryllium.lan>
 <20191007165611.GA26964@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007165611.GA26964@pc636>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-10-07 18:56:11 [+0200], Uladzislau Rezki wrote:
> Actually there is a high lock contention on vmap_area_lock, because it
> is still global. You can have a look at last slide:
> 
> https://linuxplumbersconf.org/event/4/contributions/547/attachments/287/479/Reworking_of_KVA_allocator_in_Linux_kernel.pdf
> 
> so this change will make it a bit higher. From the other hand i agree
> that for rt it should be fixed, probably it could be done like:
> 
> ifdef PREEMPT_RT
>     migrate_disable()
> #else
>     preempt_disable()
> ...
> 
> but i am not sure it is good either.

What is to be expected on average? Is the lock acquired and then
released again because the slot is empty and memory needs to be
allocated or can it be assumed that this hardly happens? 

Sebastian
