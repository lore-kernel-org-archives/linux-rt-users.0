Return-Path: <SRS0=nOM3=2G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26A1C43603
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Dec 2019 17:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B410220409
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Dec 2019 17:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLPRJp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:09:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53297 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfLPRJp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Dec 2019 12:09:45 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1igtsK-0005DS-TW; Mon, 16 Dec 2019 18:09:41 +0100
Date:   Mon, 16 Dec 2019 18:09:40 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT] lib: Check for migrate_disable only on SMP systems
Message-ID: <20191216170940.bw6xbij5ihs3kojn@linutronix.de>
References: <20191206142103.29647-1-dwagner@suse.de>
 <4513f4a584586a4c17ef14f7365f6275042c3071.camel@redhat.com>
 <20191206193954.yi5hac366agt7k3o@beryllium.lan>
 <3ce4699f987e784e84b2030aa3a1c529b274b498.camel@redhat.com>
 <20191209100447.codml4nop4ibbjkz@beryllium.lan>
 <1db9c7c960570e975ac0d684d6313ca35a3b1450.camel@redhat.com>
 <20191216152140.bjaohifj43gn22sz@linutronix.de>
 <4a8207893353c2802f05ebb467749d54a68d2c15.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a8207893353c2802f05ebb467749d54a68d2c15.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-16 11:06:58 [-0600], Scott Wood wrote:
> On Mon, 2019-12-16 at 16:21 +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-12-09 18:40:37 [-0600], Scott Wood wrote:
> > > Actually it looks like we're saved from the false positives by the
> > > following check for nr_cpus_allowed == 1, which should always be true on
> > > UP.
> > 
> > we currently don't.
> 
> Currently don't what?

Update the migrate_disable counter for UP without CONFIG_SCHED_DEBUG.

> -Scott

Sebastian
