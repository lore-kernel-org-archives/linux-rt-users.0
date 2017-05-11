From: Christoph Lameter <cl@linux.com>
Subject: Re: [patch 2/2] MM: allow per-cpu vmstat_threshold and vmstat_worker
 configuration
Date: Thu, 11 May 2017 10:37:07 -0500 (CDT)
Message-ID: <alpine.DEB.2.20.1705111035560.2894@east.gentwo.org>
References: <20170425135717.375295031@redhat.com> <20170425135846.203663532@redhat.com> <20170502102836.4a4d34ba@redhat.com> <20170502165159.GA5457@amt.cnet> <20170502131527.7532fc2e@redhat.com>
Content-Type: text/plain; charset=US-ASCII
Cc: Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
    linux-mm@kvack.org, Rik van Riel <riel@redhat.com>,
    Linux RT Users <linux-rt-users@vger.kernel.org>, cmetcalf@mellanox.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170502131527.7532fc2e@redhat.com>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2 May 2017, Luiz Capitulino wrote:

> Ah, OK. Got this now. I'll give this patch a try. But I think we want
> to hear from Christoph (who worked on reducing the vmstat interruptions
> in the past).

A bit confused by this one. The vmstat worker is already disabled if there
are no updates. Also the patches by Chris Metcalf on data plane mode add a
prctl to quiet the vmstat workers.

Why do we need more than this?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
