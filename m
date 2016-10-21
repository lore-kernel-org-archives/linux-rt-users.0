From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC] reduce latency in __purge_vmap_area_lazy
Date: Thu, 20 Oct 2016 18:08:46 -0700
Message-ID: <CAJWu+opqM8Skgkn0BYR7=kAY8YrHcY+9Ag49nZNEHnmdij8BZw@mail.gmail.com>
References: <1476773771-11470-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Morton <akpm@linux-foundation.org>, Jisheng Zhang <jszhang@marvell.com>,
	Chris Wilson <chris@chris-wilson.co.uk>, John Dias <joaodias@google.com>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1476773771-11470-1-git-send-email-hch@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Oct 17, 2016 at 11:56 PM, Christoph Hellwig <hch@lst.de> wrote:
> Hi all,
>
> this is my spin at sorting out the long lock hold times in
> __purge_vmap_area_lazy.  It is based on the patch from Joel sent this
> week.  I don't have any good numbers for it, but it survived an
> xfstests run on XFS which is a significant vmalloc user.  The
> changelogs could still be improved as well, but I'd rather get it
> out quickly for feedback and testing.

All patches look great to me, and thanks a lot.

Regards,
Joel

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
