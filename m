From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 2/6] mm: mark all calls into the vmalloc subsystem as
 potentially sleeping
Date: Tue, 18 Oct 2016 11:33:59 +0100
Message-ID: <20161018103359.GM29072@nuc-i3427.alporthouse.com>
References: <1476773771-11470-1-git-send-email-hch@lst.de>
 <1476773771-11470-3-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@linux-foundation.org, joelaf@google.com, jszhang@marvell.com,
        joaodias@google.com, linux-mm@kvack.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476773771-11470-3-git-send-email-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 18, 2016 at 08:56:07AM +0200, Christoph Hellwig wrote:
> This is how everyone seems to already use them, but let's make that
> explicit.

mm/page_alloc.c: alloc_large_system_hash() is perhaps the exception to
the rule.
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
