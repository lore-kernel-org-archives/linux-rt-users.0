Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C98FC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Dec 2021 17:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhLORbo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:31:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46542 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbhLORbZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Dec 2021 12:31:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC4E0B81D3F;
        Wed, 15 Dec 2021 17:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DC2C36AE0;
        Wed, 15 Dec 2021 17:31:21 +0000 (UTC)
Date:   Wed, 15 Dec 2021 12:31:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/2] blktrace: switch trace spinlock to a raw
 spinlock
Message-ID: <20211215123116.622da7ef@gandalf.local.home>
In-Reply-To: <YbohEio+66fyFo6D@linutronix.de>
References: <20211213123737.9147-1-wander@redhat.com>
        <20211213123737.9147-3-wander@redhat.com>
        <YbohEio+66fyFo6D@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 15 Dec 2021 18:08:34 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2021-12-13 09:37:37 [-0300], Wander Lairson Costa wrote:
> …
> > To avoid this bug, we switch the trace lock to a raw spinlock.  
> 
> Steven, do you think this is a good idea?
> 

blktrace is actually maintained by Jens.

-- Steve
