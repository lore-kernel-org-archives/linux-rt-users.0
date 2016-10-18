From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC] reduce latency in __purge_vmap_area_lazy
Date: Tue, 18 Oct 2016 21:40:11 +1100
Message-ID: <20161018214011.02b0deab@roar.ozlabs.ibm.com>
References: <1476773771-11470-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: akpm@linux-foundation.org, joelaf@google.com, jszhang@marvell.com,
        chris@chris-wilson.co.uk, joaodias@google.com, linux-mm@kvack.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34135 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753425AbcJRKkW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Oct 2016 06:40:22 -0400
In-Reply-To: <1476773771-11470-1-git-send-email-hch@lst.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 18 Oct 2016 08:56:05 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> this is my spin at sorting out the long lock hold times in
> __purge_vmap_area_lazy.  It is based on the patch from Joel sent this
> week.  I don't have any good numbers for it, but it survived an
> xfstests run on XFS which is a significant vmalloc user.  The
> changelogs could still be improved as well, but I'd rather get it
> out quickly for feedback and testing.

All seems pretty good to me.

Thanks,
Nick
