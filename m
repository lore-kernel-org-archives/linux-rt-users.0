Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:36516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbeH2UQp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Aug 2018 16:16:45 -0400
Date: Wed, 29 Aug 2018 12:19:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: stable-rt: broken vmbus_drv.c
Message-ID: <20180829121903.56022b73@gandalf.local.home>
In-Reply-To: <20180829161216.r2qwxva2kcdxny3p@linutronix.de>
References: <60422715-88ee-2206-a038-f140780fdff6@oth-regensburg.de>
        <20180829161216.r2qwxva2kcdxny3p@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, linux-rt-users <linux-rt-users@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, 29 Aug 2018 18:12:17 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-08-29 16:28:14 [+0200], Ralf Ramsauer wrote:
> > Hi,  
> Hi Ralf,
> 
> > latest stable 4.14.63-rt40 fails with CONFIG_HYPERV:  
> 
> seems to be taken care:
>   https://lkml.kernel.org/r/20180827224121.2dc55b30@vmware.local.home
> 
> Sebastian

I was just in the process of replying too. Anyway, I'll be adding this
later this week or early next week.

-- Steve
