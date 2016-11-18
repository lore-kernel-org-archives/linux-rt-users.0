From: Christoph Hellwig <hch@lst.de>
Subject: reduce latency in __purge_vmap_area_lazy V2
Date: Fri, 18 Nov 2016 14:03:46 +0100
Message-ID: <1479474236-4139-1-git-send-email-hch@lst.de>
Cc: aryabinin@virtuozzo.com,
	joelaf@google.com,
	jszhang@marvell.com,
	chris@chris-wilson.co.uk,
	joaodias@google.com,
	linux-mm@kvack.org,
	linux-rt-users@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
To: akpm@linux-foundation.org
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

this is my spin at sorting out the long lock hold times in
__purge_vmap_area_lazy.  It is based on a patch from Joel.

Changes since V1:
 - add vfree_atomic, thanks to Andrey Ryabinin.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
