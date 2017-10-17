From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rt-v4.11] sched/clock: fix early boot splat on clock
 transition to unstable
Date: Tue, 17 Oct 2017 17:36:20 +0200
Message-ID: <20171017153620.knmavtulzpm6urmo@linutronix.de>
References: <1507003039-16583-1-git-send-email-paul.gortmaker@windriver.com>
 <20171006100929.3dgt6rb7rdq64cq5@linutronix.de>
 <20171006123147.ejkezfjvhcycoyyo@linutronix.de>
 <20171011133014.GG3723@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58761 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932642AbdJQPgX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Oct 2017 11:36:23 -0400
Content-Disposition: inline
In-Reply-To: <20171011133014.GG3723@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-10-11 09:30:14 [-0400], Paul Gortmaker wrote:
> The tree patched up from scratch without any need to refresh the two newly
> exported commits and the old trash box with the broken tsc doesn't have the
> boot splat. Note:  I've not [yet] tested on something with a working tsc, but I
> doubt that is a concern...

I forgot to respond but I released a v4.11-RT with this included.

> Paul.

Sebastian
