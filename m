From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: FAQ for realtime support in Linux Kernel
Date: Tue, 2 Oct 2007 07:11:21 +0530
Message-ID: <1985e0f60710011841y6a9d55eeld25e40e32a83a3fc@mail.gmail.com>
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
Cc: "Remy Bohmer" <linux@bohmer.net>, linux-rt-users@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:49339 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbXJBBlW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 21:41:22 -0400
Received: by fk-out-0910.google.com with SMTP id z23so4180825fkz
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Oct 2007 18:41:21 -0700 (PDT)
In-Reply-To: <20071002000237.GF28533@thunk.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thanks for your updates.

So here another question arise, how I know that -rt patch I applied is
working properly. check my "Cyclictest expected results".

If we have some magical numbers to test -rt patch, It will be great!!

Thank you,

Jaswinder Singh.


On 10/2/07, Theodore Tso <tytso@mit.edu> wrote:
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
>                                                - Ted
>
