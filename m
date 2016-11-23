From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/10] mm: warn about vfree from atomic context
Date: Wed, 23 Nov 2016 09:39:49 +0100
Message-ID: <20161123083949.GD16966@lst.de>
References: <1479474236-4139-1-git-send-email-hch@lst.de> <1479474236-4139-8-git-send-email-hch@lst.de> <996e56cb-137f-cd3e-eb69-e9ef03ad75c4@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
	joelaf@google.com, jszhang@marvell.com, chris@chris-wilson.co.uk,
	joaodias@google.com, linux-mm@kvack.org,
	linux-rt-users@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <996e56cb-137f-cd3e-eb69-e9ef03ad75c4@virtuozzo.com>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Nov 22, 2016 at 07:35:34PM +0300, Andrey Ryabinin wrote:
> This one is wrong. We still can call vfree() from interrupt context.
> So WARN_ON_ONCE(in_atomic() && !in_interrupt()) would be correct,
> but also redundant. DEBUG_ATOMIC_SLEEP=y should catch illegal vfree() calls.
> Let's just drop this patch, ok?

Ok, fine.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
