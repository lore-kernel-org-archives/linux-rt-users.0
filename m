From: Julia Cartwright <julia@ni.com>
Subject: Re: mmap paging problems
Date: Mon, 13 Feb 2017 15:32:54 -0600
Message-ID: <20170213213254.GL5599@jcartwri.amer.corp.natinst.com>
References: <CAEYdEeTq+exUaXK7vifQbPCOoJ-mpnQcW89Mxow31BX3St=AgA@mail.gmail.com>
 <20170213160329.GK5599@jcartwri.amer.corp.natinst.com>
 <CAEYdEeTyuYQjxA+Wn5ABB=asdxeZZeUKMdwZyU0geiOn3_ecrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Brian Wrenn <dcbrianw@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:49671 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752730AbdBMVc4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Feb 2017 16:32:56 -0500
Content-Disposition: inline
In-Reply-To: <CAEYdEeTyuYQjxA+Wn5ABB=asdxeZZeUKMdwZyU0geiOn3_ecrQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 13, 2017 at 03:52:19PM -0500, Brian Wrenn wrote:
[..]
> On Monday, February 13, 2017, Julia Cartwright <julia@ni.com> wrote:
> > On Fri, Feb 10, 2017 at 07:48:26PM -0500, Brian Wrenn wrote:
[..]
> > > Unable to handle kernel paging request at virtual address <some address>
> > >
> > > I'm using mmap in a fairly straightforward way.  Basically, upon an
> > > IOC command from the user space application to the kernel module, the
> > > kernel module attempts to copy data into the memory mapped area.

What you are referring to when you say "the memory mapped area" here is
ambiguous, as there are two separate address spaces being spoken about.

Assuming you've allocated a page with get_zeroed_page(GFP_KERNEL) and
established it as the backing page in your vm_operations_struct fault
callback (like the linked below example), then the two mappings are:

  1. A mapping in the kernels' address space.
  2. A mapping in the calling process's address space (and, possibly in
       forked processes address spaces as well, depending on the VM area
       flags!)

Mappings into the kernel space may be accessed by kernel code in the
"normal" ways, through pointer dereference, memset()/memcpy() and
friends, etc, however, kernel code must handle accesses into usermode
very carefully.

The calling user code doesn't know anything about, nor should it know
anything about the existence of the kernel mapping.  It operates purely
on the process mapping (number 2 above), a pointer to which is returned
from the mmap*() system call.

> > > I've checked, double checked, and triple checked that I'm not
> > > writing to a bad address or an address outside of the mmap'ed
> > > area.
> >
> > How are you performing your checks?  How are you performing the
> > copy?
>
> I use memcpy() to perform the copy.  To perorm my checks, I simply use the
> write-to address provided by the call to get_zeroed_page(GFP_KERNEL) on the
> kernel side.

Okay, so from this it sounds like you're, in your kernel code, only
passing the pointer returned from get_zeroed_page(GFP_KERNEL) as the
destination pointer to memcpy().  This should work fine, as long as you
aren't exceeding the PAGE_SIZE'd buffer.  Is this the case?

> I've based the mmap aspects of my driver on this example.  I've
> attempted memcpy() on sizes of 64 bytes, 1Kbyte and 9Kbytes.  64 bytes
> hasn't caused a problem thus far.  1Kbyte consistently leads to the
> OOPs.

Just a thought: does your target architecture have aligned access
requirements that aren't being met?

[..]
> > > Are there some special (special in the sense of in addition to or
> > > instead of the way done for a non-PREEMPT-RT kernel) things one must
> > > do to safely write mmap'ed data within a PREEMPT RT kernel?
> >
> > You didn't explicitly mention it, so I thought I'd check: the same
> > operation, performed on a non-RT kernel doesn't reproduce the above
> > OOPs?
>
> I have not tried this on a non-RT kernel.  I can attempt to run my setup
> with a non-RT kernel on Thursday.  I'm out of the office without access to
> my setup until then.  But I will see if that works just to get a basis of
> comparsion.

An administrative note: I think you're beyond linux-rt-users in scope
here, unless you can show that it is somehow an RT-specific problem.  A
better venue for this kind of question would probably be the
kernelnewbies list.

Good luck,

   Julia
