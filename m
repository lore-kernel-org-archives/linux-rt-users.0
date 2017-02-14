From: Julia Cartwright <julia@ni.com>
Subject: Re: mmap paging problems
Date: Tue, 14 Feb 2017 15:31:17 -0600
Message-ID: <20170214213117.GM5599@jcartwri.amer.corp.natinst.com>
References: <CAEYdEeTq+exUaXK7vifQbPCOoJ-mpnQcW89Mxow31BX3St=AgA@mail.gmail.com>
 <20170213160329.GK5599@jcartwri.amer.corp.natinst.com>
 <CAEYdEeTyuYQjxA+Wn5ABB=asdxeZZeUKMdwZyU0geiOn3_ecrQ@mail.gmail.com>
 <20170213213254.GL5599@jcartwri.amer.corp.natinst.com>
 <CAEYdEeREvOMdCVJcAOsuJgt8w14ELNkabEmV8qiqHrQP5F14Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Brian Wrenn <dcbrianw@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:36054 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751357AbdBNVbr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Feb 2017 16:31:47 -0500
Content-Disposition: inline
In-Reply-To: <CAEYdEeREvOMdCVJcAOsuJgt8w14ELNkabEmV8qiqHrQP5F14Qw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 13, 2017 at 10:42:31PM -0500, Brian Wrenn wrote:
> On Monday, February 13, 2017, Julia Cartwright <julia@ni.com> wrote:
> > On Mon, Feb 13, 2017 at 03:52:19PM -0500, Brian Wrenn wrote:
> > > On Monday, February 13, 2017, Julia Cartwright <julia@ni.com
> > > > On Fri, Feb 10, 2017 at 07:48:26PM -0500, Brian Wrenn wrote:
[..]
> > > > >
> > > > > I'm using mmap in a fairly straightforward way.  Basically, upon an
> > > > > IOC command from the user space application to the kernel module, the
> > > > > kernel module attempts to copy data into the memory mapped area.
> >
> > What you are referring to when you say "the memory mapped area" here is
> > ambiguous, as there are two separate address spaces being spoken about.
> >
> > Assuming you've allocated a page with get_zeroed_page(GFP_KERNEL) and
> > established it as the backing page in your vm_operations_struct fault
> > callback (like the linked below example), then the two mappings are:
> >
> >   1. A mapping in the kernels' address space.
> >   2. A mapping in the calling process's address space (and, possibly in
> >        forked processes address spaces as well, depending on the VM area
> >        flags!)
> >
> > Mappings into the kernel space may be accessed by kernel code in the
> > "normal" ways, through pointer dereference, memset()/memcpy() and
> > friends, etc, however, kernel code must handle accesses into usermode
> > very carefully.
> >
> > The calling user code doesn't know anything about, nor should it know
> > anything about the existence of the kernel mapping.  It operates purely
> > on the process mapping (number 2 above), a pointer to which is returned
> > from the mmap*() system call.
>
> When I say the memory mapped area, I mean the page size allocated from
> within the caller's code.  The kernel module sits idly, waiting for some
> calling code to open a file descriptor to the memmap device file.  I've
> tried a number of different values for the page size passed from the
> calling code.  I've tried the example's 4096 bytes, 1Kbyte, 9Kbytes,
> 9Kbytes plus padding to align to the system page sice (4096 bytes), and
> mulitples thereof.  So by the memory mapped area I mean the address
> provided from get_zeroed_page() to the page size.

Yeah, unfortunately, this doesn't clear anything up at all :(.

Who is the 'caller' in this context?  Is it different from the 'calling
code'?  Is this a user thread calling your user library?  Is 'caller' in
this sense a user thread invoking mmap() on a fd in which you've
registered a mmap() handler?  It's an important distinction to know what
context the thread is executing in.

> > > > > I've checked, double checked, and triple checked that I'm not
> > > > > writing to a bad address or an address outside of the mmap'ed
> > > > > area.
> > > >
> > > > How are you performing your checks?  How are you performing the
> > > > copy?
> > >
> > > I use memcpy() to perform the copy.  To perorm my checks, I simply use the
> > > write-to address provided by the call to get_zeroed_page(GFP_KERNEL) on the
> > > kernel side.

You use memcpy() in the kernel?  Or, in user context?  And to what
mapped region?

In what way do you use the "write-to address" to ensure you're writing
to the "right" place?

Unfortunately, as in most kernel topics, precision in description and
words (and most importantly, code) is of utmost importance.

   Julia
