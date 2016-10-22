From: Christoph Hellwig <hch@lst.de>
Subject: reduce latency in __purge_vmap_area_lazy
Date: Sat, 22 Oct 2016 17:17:13 +0200
Message-ID: <1477149440-12478-1-git-send-email-hch@lst.de>
Cc: joelaf@google.com,
	jszhang@marvell.com,
	chris@chris-wilson.co.uk,
	joaodias@google.com,
	linux-mm@kvack.org,
	linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: akpm@linux-foundation.org
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

this is my spin at sorting out the long lock hold times in
__purge_vmap_area_lazy.  It is based on the patch from Joel sent this
week.  I don't have any good numbers for it, but it survived an
xfstests run on XFS which is a significant vmalloc user.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
