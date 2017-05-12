From: Christoph Lameter <cl@linux.com>
Subject: Re: [patch 2/2] MM: allow per-cpu vmstat_threshold and vmstat_worker
 configuration
Date: Fri, 12 May 2017 11:03:05 -0500 (CDT)
Message-ID: <alpine.DEB.2.20.1705121102140.22831@east.gentwo.org>
References: <20170425135717.375295031@redhat.com> <20170425135846.203663532@redhat.com> <20170502102836.4a4d34ba@redhat.com> <20170502165159.GA5457@amt.cnet> <20170502131527.7532fc2e@redhat.com> <alpine.DEB.2.20.1705111035560.2894@east.gentwo.org>
 <20170512122704.GA30528@amt.cnet> <alpine.DEB.2.20.1705121002310.22243@east.gentwo.org> <20170512154026.GA3556@amt.cnet>
Content-Type: text/plain; charset=US-ASCII
Cc: Luiz Capitulino <lcapitulino@redhat.com>, linux-kernel@vger.kernel.org,
    linux-mm@kvack.org, Rik van Riel <riel@redhat.com>,
    Linux RT Users <linux-rt-users@vger.kernel.org>, cmetcalf@mellanox.com
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170512154026.GA3556@amt.cnet>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 12 May 2017, Marcelo Tosatti wrote:

> OK, i'll check if the patches from Chris work for us and then add
> Tested-by on that.

You may not need those if the quiet_vmstat() function is enough for you.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
