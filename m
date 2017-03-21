From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Tue, 21 Mar 2017 20:38:36 +0100
Message-ID: <20170321193836.df7hxagg6wqzh6qm@linutronix.de>
References: <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
 <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
 <20170306190707.GL29100@jcartwri.amer.corp.natinst.com>
 <e1193ceb-af77-b561-5b84-c08915e7859e@lebib.org>
 <fb9e1287-7042-9b46-1730-1e622eac99cc@lebib.org>
 <20170317181219.5vr4obmtiod7euuk@linutronix.de>
 <06ee1435-7fb6-3cf5-c305-96a020665c01@lebib.org>
 <20170320211815.qjvrty7mtmof343w@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Julia Cartwright <julia@ni.com>,
        Daniel Vidal <danielvidalchornet@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Wargreen <wargreen@lebib.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46880 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758031AbdCUUmA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Mar 2017 16:42:00 -0400
Content-Disposition: inline
In-Reply-To: <20170320211815.qjvrty7mtmof343w@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-03-20 22:18:16 [+0100], To Wargreen wrote:
> 1993 wants exclusive_lock and blocks on it.
> 2230 has exclusive_lock and blocks on mclk_lock.
> 2448 has mclk_lock nad reservation_ww_class_mutex. I *think* that one
> waits for an IRQ from the GPU which is not coming. My guess is, that it
> sits somewhere in ttm_bo_vm_fault_idle() and waits for wakeup.
> If this triggers so easy, could you please check if the interrupt
> counter for radeon in /proc/interrupts increases after the accident?

The other theory is that the code can't continue because we can't have
multiple reader of exclusive_lock. I will try to verify that but this
will take some time…

Sebastian
