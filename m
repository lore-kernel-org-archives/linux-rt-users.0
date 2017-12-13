From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] mm/slub: close possible memory-leak in
 kmem_cache_alloc_bulk()
Date: Wed, 13 Dec 2017 15:50:44 +0100
Message-ID: <20171213145044.falrw5jsskq2ocha@linutronix.de>
References: <20171213140555.s4hzg3igtjfgaueh@linutronix.de>
 <20171213154654.2971ef2a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vladimir Davydov <vdavydov@virtuozzo.com>, linux-mm@kvack.org,
        Rao Shoaib <rao.shoaib@oracle.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Jesper Dangaard Brouer <brouer@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35765 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbdLMOur (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Dec 2017 09:50:47 -0500
Content-Disposition: inline
In-Reply-To: <20171213154654.2971ef2a@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-13 15:46:54 [+0100], Jesper Dangaard Brouer wrote:
> > Jesper: There are no users of kmem_cache_alloc_bulk() and kfree_bulk().
> > Only kmem_cache_free_bulk() is used since it was introduced. Do you
> > think that it would make sense to remove those?
> 
> I would like to keep them.
> 
> Rao Shoaib (Cc'ed) is/was working on a patchset for RCU-bulk-free that
> used the kfree_bulk() API.
> 
> I plan to use kmem_cache_alloc_bulk() in the bpf-map "cpumap", for bulk
> allocating SKBs during dequeue of XDP frames.  (My original bulk alloc
> SKBs use-case during NAPI/softirq was never merged).

I see. So it may gain users in future you say.

> I've not seen free_delayed() before... and my cscope cannot find it...
It is PREEMPT RT only, mainline is not affected (that is why there is a
RT next to the PATCH in subject).

Sebastian
