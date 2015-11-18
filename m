From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/4] wait.[ch]: Introduce the simple waitqueue (swait)
 implementation
Date: Wed, 18 Nov 2015 16:07:06 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511181604350.3761@nanos>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de> <1445326090-1698-2-git-send-email-daniel.wagner@bmw-carit.de> <alpine.DEB.2.11.1511041124530.4032@nanos> <20151118103304.GD3816@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151118103304.GD3816@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 18 Nov 2015, Peter Zijlstra wrote:
> I suppose we can do the rename as you propose to avoid single letter
> typoes, but it does bug me to have two nearly identical bits of infra
> with such dissimilar names.

I can see your point, but OTOH the existing interface is ugly and
copying it does not make it any better.

But I'm really not religious about that. Up to you :)

Thanks,

	tglx
