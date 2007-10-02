From: Theodore Tso <tytso@mit.edu>
Subject: Re: FAQ for realtime support in Linux Kernel
Date: Mon, 1 Oct 2007 20:02:37 -0400
Message-ID: <20071002000237.GF28533@thunk.org>
References: <1985e0f60709282200q46af6416v1df50da135d5d01c@mail.gmail.com> <1985e0f60709282344m45b31dd0i2f3016d81f42265a@mail.gmail.com> <1985e0f60709290551j7b79421fs9c8dcca5806a518c@mail.gmail.com> <20070929131338.GF813@unix.sh> <1985e0f60709290816k7f8c9bc2m6fb6c1fc4859243c@mail.gmail.com> <20070929165630.GA30241@thunk.org> <1985e0f60709291018ib01150evc80d89e362c6be7d@mail.gmail.com> <1985e0f60709292256o1e91d39al147bcffbb9f27450@mail.gmail.com> <1985e0f60710010404j7e6c1aaybd1a7cf4b3efe4a7@mail.gmail.com> <3efb10970710011318v939601fvc7420e80b83b1d37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jaswinder Singh <jaswinderlinuxrt@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:36995 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbXJBACn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 20:02:43 -0400
Content-Disposition: inline
In-Reply-To: <3efb10970710011318v939601fvc7420e80b83b1d37@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Oct 01, 2007 at 10:18:15PM +0200, Remy Bohmer wrote:
> I doubt anyone can fill in this paragraph properly. It is too vague,
> and the figures you ask are different for every architecture and
> processor type/speed that is supported.

I've already replaced that question with one asking about what kind of
performance one could expect, and answered it with the standard "it
depends" answer.  I moved it to the general "Getting Started" section.

At some point it would be good to add some commentary about the
resulting throughput degradation (which is why I kept the question
open-ended about "performance", instead of "latency").

						- Ted
