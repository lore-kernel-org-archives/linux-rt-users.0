From: Pekka Enberg <penberg@kernel.org>
Subject: Re: FIX [1/2] slub: Do not dereference NULL pointer in node_match
Date: Fri, 1 Feb 2013 12:23:05 +0200
Message-ID: <CAOJsxLH6BO_m+6Ys0AG8gHQzmoDovdA8kaAecUhcP5foXoEXUA@mail.gmail.com>
References: <20130123214514.370647954@linux.com>
	<0000013c695fbd30-9023bc55-f780-4d44-965f-ab4507e483d5-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@gmail.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Joonsoo Kim <js1304@gmail.com>,
	Glauber Costa <glommer@parallels.com>, linux-mm@kvack.org,
	David Rientjes <rientjes@google.com>, elezegarcia@gmail.com
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:37976 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681Ab3BAKXI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Feb 2013 05:23:08 -0500
Received: by mail-we0-f180.google.com with SMTP id k14so2745617wer.39
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Feb 2013 02:23:06 -0800 (PST)
In-Reply-To: <0000013c695fbd30-9023bc55-f780-4d44-965f-ab4507e483d5-000000@email.amazonses.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 23, 2013 at 11:45 PM, Christoph Lameter <cl@linux.com> wrote:
> The variables accessed in slab_alloc are volatile and therefore
> the page pointer passed to node_match can be NULL. The processing
> of data in slab_alloc is tentative until either the cmpxhchg
> succeeds or the __slab_alloc slowpath is invoked. Both are
> able to perform the same allocation from the freelist.
>
> Check for the NULL pointer in node_match.
>
> A false positive will lead to a retry of the loop in __slab_alloc.
>
> Signed-off-by: Christoph Lameter <cl@linux.com>

Steven, how did you trigger the problem - i.e. is this -rt only
problem? Does the patch work for you?

> Index: linux/mm/slub.c
> ===================================================================
> --- linux.orig/mm/slub.c        2013-01-18 08:47:29.198954250 -0600
> +++ linux/mm/slub.c     2013-01-18 08:47:40.579126371 -0600
> @@ -2041,7 +2041,7 @@ static void flush_all(struct kmem_cache
>  static inline int node_match(struct page *page, int node)
>  {
>  #ifdef CONFIG_NUMA
> -       if (node != NUMA_NO_NODE && page_to_nid(page) != node)
> +       if (!page || (node != NUMA_NO_NODE && page_to_nid(page) != node))
>                 return 0;
>  #endif
>         return 1;
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
