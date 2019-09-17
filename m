Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6187AC4CECD
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 15:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420A021881
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 15:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfIQPYE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfIQPYE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 11:24:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B550E8A1CA6;
        Tue, 17 Sep 2019 15:24:01 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69AC726E66;
        Tue, 17 Sep 2019 15:23:59 +0000 (UTC)
Message-ID: <1bcdec32b7a8165935cffbb2547c3d977c93f26d.camel@redhat.com>
Subject: Re: [PATCH RT 2/8] sched: __set_cpus_allowed_ptr: Check cpus_mask,
 not cpus_ptr
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Tue, 17 Sep 2019 10:23:58 -0500
In-Reply-To: <20190917145729.pul3dmbrdnshne6m@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
         <20190727055638.20443-3-swood@redhat.com>
         <20190917145729.pul3dmbrdnshne6m@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Tue, 17 Sep 2019 15:24:04 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-09-17 at 16:57 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-07-27 00:56:32 [-0500], Scott Wood wrote:
> > This function is concerned with the long-term cpu mask, not the
> > transitory mask the task might have while migrate disabled.  Before
> > this patch, if a task was migrate disabled at the time
> > __set_cpus_allowed_ptr() was called, and the new mask happened to be
> > equal to the cpu that the task was running on, then the mask update
> > would be lost.
> 
> lost as in "would not be carried out" I assume.

Right.  The old mask would be restored upon migrate_enable() even though
that's no longer the policy that was requested.

-Scott


