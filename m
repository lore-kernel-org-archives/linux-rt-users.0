From: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC][PATCH] slub: Check for page NULL before doing the node_match
 check
Date: Thu, 17 Jan 2013 21:22:18 +0000
Message-ID: <0000013c4a64146b-68cd6f7d-f7e2-460b-9ee5-d931714ce062-000000@email.amazonses.com>
References: <1358446258.23211.32.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Pekka Enberg <penberg@kernel.org>, Matt Mackall <mpm@selenic.com>,
    Thomas Gleixner <tglx@linutronix.de>, RT <linux-rt-users@vger.kernel.org>,
    Clark Williams <clark@redhat.com>, John Kacur <jkacur@gmail.com>,
    "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1358446258.23211.32.camel@gandalf.local.home>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 17 Jan 2013, Steven Rostedt wrote:

> Anyway, looking at where this crashed, it seems that the page variable
> can be NULL when passed to the node_match() function (which does not
> check if it is NULL). When this happens we get the above panic.
>
> As page is only used in slab_alloc() to check if the node matches, if
> it's NULL I'm assuming that we can say it doesn't and call the
> __slab_alloc() code. Is this a correct assumption?

c->page should only be NULL when c->freelist == NULL but obviously there
are race conditions where c->freelist may not have been zapped but c->page
was.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
