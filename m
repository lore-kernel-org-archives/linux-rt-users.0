From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: FAQ for realtime support in Linux Kernel
Date: Tue, 2 Oct 2007 17:35:41 +0200
Message-ID: <3efb10970710020835j53a0a99eyb173f7f262ccb839@mail.gmail.com>
References: <1985e0f60709282200q46af6416v1df50da135d5d01c@mail.gmail.com>
	 <1985e0f60709290551j7b79421fs9c8dcca5806a518c@mail.gmail.com>
	 <20070929131338.GF813@unix.sh>
	 <1985e0f60709290816k7f8c9bc2m6fb6c1fc4859243c@mail.gmail.com>
	 <20070929165630.GA30241@thunk.org>
	 <1985e0f60709291018ib01150evc80d89e362c6be7d@mail.gmail.com>
	 <1985e0f60709292256o1e91d39al147bcffbb9f27450@mail.gmail.com>
	 <1985e0f60710010404j7e6c1aaybd1a7cf4b3efe4a7@mail.gmail.com>
	 <3efb10970710011318v939601fvc7420e80b83b1d37@mail.gmail.com>
	 <20071002000237.GF28533@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>,
	linux-rt-users@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:30776 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbXJBPfn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Oct 2007 11:35:43 -0400
Received: by py-out-1112.google.com with SMTP id u77so7840973pyb
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Oct 2007 08:35:41 -0700 (PDT)
In-Reply-To: <20071002000237.GF28533@thunk.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Theodore,

> At some point it would be good to add some commentary about the
> resulting throughput degradation (which is why I kept the question
> open-ended about "performance", instead of "latency").

Is there still a throughput degradation noticeable on some platforms?
I know for sure it was there in the past, but I thought these were all
fixed by now.
AFAIK: The latest kernels have fixed the netwerk performance
degradation bug, and on Dual-Core we even notice a performance
improvement compared to non-RT.

Kind Regards,

Remy Bohmer

2007/10/2, Theodore Tso <tytso@mit.edu>:
> On Mon, Oct 01, 2007 at 10:18:15PM +0200, Remy Bohmer wrote:
> > I doubt anyone can fill in this paragraph properly. It is too vague,
> > and the figures you ask are different for every architecture and
> > processor type/speed that is supported.
>
> I've already replaced that question with one asking about what kind of
> performance one could expect, and answered it with the standard "it
> depends" answer.  I moved it to the general "Getting Started" section.
>
> At some point it would be good to add some commentary about the
> resulting throughput degradation (which is why I kept the question
> open-ended about "performance", instead of "latency").
>
>                                                 - Ted
>
