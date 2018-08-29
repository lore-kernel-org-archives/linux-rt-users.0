Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:47114 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbeH2UJ5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Aug 2018 16:09:57 -0400
Date: Wed, 29 Aug 2018 18:12:17 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: stable-rt: broken vmbus_drv.c
Message-ID: <20180829161216.r2qwxva2kcdxny3p@linutronix.de>
References: <60422715-88ee-2206-a038-f140780fdff6@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60422715-88ee-2206-a038-f140780fdff6@oth-regensburg.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>

On 2018-08-29 16:28:14 [+0200], Ralf Ramsauer wrote:
> Hi,
Hi Ralf,

> latest stable 4.14.63-rt40 fails with CONFIG_HYPERV:

seems to be taken care:
  https://lkml.kernel.org/r/20180827224121.2dc55b30@vmware.local.home

Sebastian
