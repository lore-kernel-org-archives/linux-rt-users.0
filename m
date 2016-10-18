From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [RFC] reduce latency in __purge_vmap_area_lazy
Date: Tue, 18 Oct 2016 19:21:49 +0800
Message-ID: <20161018192149.3de86109@xhacker>
References: <1476773771-11470-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <akpm@linux-foundation.org>, <joelaf@google.com>,
        <chris@chris-wilson.co.uk>, <joaodias@google.com>,
        <linux-mm@kvack.org>, <linux-rt-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
To: Christoph Hellwig <hch@lst.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37716 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753095AbcJRL1W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Oct 2016 07:27:22 -0400
In-Reply-To: <1476773771-11470-1-git-send-email-hch@lst.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 18 Oct 2016 08:56:05 +0200 Christoph Hellwig wrote:

> Hi all,
> 
> this is my spin at sorting out the long lock hold times in
> __purge_vmap_area_lazy.  It is based on the patch from Joel sent this
> week.  I don't have any good numbers for it, but it survived an
> xfstests run on XFS which is a significant vmalloc user.  The
> changelogs could still be improved as well, but I'd rather get it
> out quickly for feedback and testing.

I just tested this series, the preempt off ftrace log doesn't complain
__purge_vmap_area_lazy any more in my test case, this latency is removed!

So feel free to add

Tested-by: Jisheng Zhang <jszhang@marvell.com>
