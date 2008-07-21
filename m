From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
Date: Mon, 21 Jul 2008 15:53:39 +0530
Message-ID: <20080721102339.GR20277@linux.vnet.ibm.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
	<1216085521.7740.37.camel@pasglop>
	<20080717125645.GN20277@linux.vnet.ibm.com>
	<1216325671.7740.359.camel@pasglop>
	<20080718101133.GO20277@linux.vnet.ibm.com>
	<1216418730.7740.451.camel@pasglop>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
	linux.kernel@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <1216418730.7740.451.camel@pasglop>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
List-Id: linux-rt-users.vger.kernel.org

Hi Benjamin

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2008-07-19 08:05:30]:

> 
> > With the original patch, the pending batch does get flushed 
> > in a non-preemptable region. 
> > I am resending the original with just adding the necesary comments.
> 
> Your comment isn't what I meant. What I meant is that if the process
> is context switched while walking the page tables, the low level powerpc
> context switch code should also perform a ???__flush_tlb_pending.
Sorry, I misunderstood.
The powerpc context switch code does perform a __flush_tlb_pending.
Here is the patch 
http://marc.info/?l=linux-kernel&m=119752629222720&w=2
> BTW. Is the pte_lock also not a real spinlock anymore ? That may break
> other assumptions the powerpc mm code is doing.
pte_lock is a not a real spinlock anymore.

> This -rt stuff is just too scary, it changes some fundamental semantics
> of the spinlocks. yuck.
> 
> Ben.
> 
> 
