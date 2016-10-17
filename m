From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch ]mm/zs_malloc: Fix bit spinlock replacement
Date: Mon, 17 Oct 2016 17:15:26 +0200
Message-ID: <20161017151526.c4snf4vlt6bytqrx@linutronix.de>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
 <1476587883.1538.12.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:37500 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933594AbcJQPP3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Oct 2016 11:15:29 -0400
Content-Disposition: inline
In-Reply-To: <1476587883.1538.12.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-16 05:18:03 [+0200], Mike Galbraith wrote:
> 
> Do not alter HANDLE_SIZE, memory corruption ensues.  The handle is
> a pointer, allocate space for the struct it points to and align it
> ZS_ALIGN.  Also, when accessing the struct, mask HANDLE_PIN_BIT.

So this is to merged / folded into "mm/zsmalloc: Use get/put_cpu_light
in zs_map_object()/zs_unmap_object()" which I re-did for v4.8?
How was this tested?
I have:
   CONFIG_FRONTSWAP=y
   # CONFIG_CMA is not set
   CONFIG_ZSWAP=y
   CONFIG_ZPOOL=y
   CONFIG_ZBUD=m
   CONFIG_Z3FOLD=m
   CONFIG_ZSMALLOC=m
   # CONFIG_PGTABLE_MAPPING is not set
   CONFIG_ZSMALLOC_STAT=y

and

   # cat /sys/module/zswap/parameters/enabled
   Y
   cat /sys/module/zswap/parameters/zpool
   zbud
   # cat /sys/module/zswap/parameters/compressor 
   lzo
   # cat /sys/module/zswap/parameters/max_pool_percent 
   20

and I do have 1GiB of swap on /dev/vdc. While I get swap to be used, I
see no firework. Is there something wrong with my setup? I would assume
so due to the lack of the fireworks on my side…

> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>

Sebastian
