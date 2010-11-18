From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Slub support with PREEMPT_RT ?
Date: Thu, 18 Nov 2010 12:04:38 +0100
Message-ID: <1290078278.2109.1327.camel@laptop>
References: <AANLkTimUb7rfRKCwhnf3s=Qw+J79_PqL_1Zk=fz5B99q@mail.gmail.com>
	 <4CE4802D.6070903@linux.intel.com> <1290069601.2109.1295.camel@laptop>
	 <AANLkTikV5Jykyv4+SBcJQqMvzMSUsXOUdXTQU5rOhcs_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Darren Hart <dvhart@linux.intel.com>,
	linux-rt-users@vger.kernel.org
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from canuck.infradead.org ([134.117.69.58]:52766 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab0KRLEY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Nov 2010 06:04:24 -0500
In-Reply-To: <AANLkTikV5Jykyv4+SBcJQqMvzMSUsXOUdXTQU5rOhcs_@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2010-11-18 at 09:59 +0100, Jean-Michel Hautbois wrote:
> 
> My real question is the impact of SLUB compared to SLAB on the
> determinism of kmalloc usage and all caches.
> I did some tests using SLUB instead of SLAB on a small (MPC5200 /
> 400Mhz / 16k i-cache and 16k d-cache), and slub seems to be better.
> But I don't know if there is a possibility to tune SLAB in order to
> get good results. 

That's a pretty pointless idea, non of them are deterministic allocators
-- nor can they be, page allocation involves the whole vm reclaim path.

If you want determinism don't allocate memory.
