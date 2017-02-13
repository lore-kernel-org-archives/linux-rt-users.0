From: Julia Cartwright <julia@ni.com>
Subject: Re: mmap paging problems
Date: Mon, 13 Feb 2017 10:03:29 -0600
Message-ID: <20170213160329.GK5599@jcartwri.amer.corp.natinst.com>
References: <CAEYdEeTq+exUaXK7vifQbPCOoJ-mpnQcW89Mxow31BX3St=AgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>
To: Brian Wrenn <dcbrianw@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:40642 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751023AbdBMQDg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Feb 2017 11:03:36 -0500
Content-Disposition: inline
In-Reply-To: <CAEYdEeTq+exUaXK7vifQbPCOoJ-mpnQcW89Mxow31BX3St=AgA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Feb 10, 2017 at 07:48:26PM -0500, Brian Wrenn wrote:
> Hi,

Hey Brian-

> I have a kernel module running within Linaro 4.4.9 with PREEMPT RT 17.
> Within that module I attempt to transfer data from the kernel module
> to user space.  The user space application does not run real-time,
> just in plain Linux user space.  With each attempted run I get a
> kernel dump that begins with the following:
> 
> Unable to handle kernel paging request at virtual address <some address>
> 
> I'm using mmap in a fairly straightforward way.  Basically, upon an
> IOC command from the user space application to the kernel module, the
> kernel module attempts to copy data into the memory mapped area.  I've
> checked, double checked, and triple checked that I'm not writing to a
> bad address or an address outside of the mmap'ed area.

How are you performing your checks?  How are you performing the copy?

> Are there some special (special in the sense of in addition to or
> instead of the way done for a non-PREEMPT-RT kernel) things one must
> do to safely write mmap'ed data within a PREEMPT RT kernel?

You didn't explicitly mention it, so I thought I'd check: the same
operation, performed on a non-RT kernel doesn't reproduce the above
OOPs?

   Julia
