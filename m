From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] mm: mark all calls into the vmalloc subsystem as
	potentially sleeping
Date: Wed, 19 Oct 2016 15:05:52 +0200
Message-ID: <20161019130552.GB5876@lst.de>
References: <1476773771-11470-1-git-send-email-hch@lst.de> <1476773771-11470-3-git-send-email-hch@lst.de> <20161019111541.GQ29358@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
	joelaf@google.com, jszhang@marvell.com, joaodias@google.com,
	linux-mm@kvack.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
To: Chris Wilson <chris@chris-wilson.co.uk>
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20161019111541.GQ29358@nuc-i3427.alporthouse.com>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 19, 2016 at 12:15:41PM +0100, Chris Wilson wrote:
> On Tue, Oct 18, 2016 at 08:56:07AM +0200, Christoph Hellwig wrote:
> > This is how everyone seems to already use them, but let's make that
> > explicit.
> 
> Ah, found an exception, vmapped stacks:

Oh, fun.  So if we can't require vfree to be called from process context
we also can't use a mutex to wait for the vmap flushing.  Given that we
free stacks from the scheduler context switch I also fear there is no
good way to get a sleepable context there.

The only other idea I had was to use vmap_area_lock for the protection
that purge_lock currently provides, but that would require some serious
refactoring to avoid recursive locking first.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
