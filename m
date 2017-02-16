From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Re: mmap paging problems
Date: Thu, 16 Feb 2017 15:49:52 -0500
Message-ID: <CAEYdEeQtyxsg+ndUYkdJwgOy9bL2OHxrHxxotMgZ6FicPKZBkQ@mail.gmail.com>
References: <CAEYdEeTq+exUaXK7vifQbPCOoJ-mpnQcW89Mxow31BX3St=AgA@mail.gmail.com>
 <20170213160329.GK5599@jcartwri.amer.corp.natinst.com> <CAEYdEeTyuYQjxA+Wn5ABB=asdxeZZeUKMdwZyU0geiOn3_ecrQ@mail.gmail.com>
 <20170213213254.GL5599@jcartwri.amer.corp.natinst.com> <CAEYdEeREvOMdCVJcAOsuJgt8w14ELNkabEmV8qiqHrQP5F14Qw@mail.gmail.com>
 <20170214213117.GM5599@jcartwri.amer.corp.natinst.com> <CAEYdEeQ4hTU-3woObpNn0-r_jiEVDvfz5vJ+RijmXWwgWFv02w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:35076 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933086AbdBPUtx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Feb 2017 15:49:53 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so115165644ith.0
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Feb 2017 12:49:53 -0800 (PST)
In-Reply-To: <CAEYdEeQ4hTU-3woObpNn0-r_jiEVDvfz5vJ+RijmXWwgWFv02w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Julia,

I ripped out the real-time dependent items and ran my use case of mmap
within the non-RT kernel.  I replicated some of the behavior, so I'm
doing something wrong with mmap, and I don't think it has much to do
with any real-time aspects of the kernel.  Nonetheless, thanks for
humoring me the last few days.


On Wed, Feb 15, 2017 at 11:15 AM, Brian Wrenn <dcbrianw@gmail.com> wrote:
> Hi Julia,
>
> I've wrtten some replies in-line below.  I was thinking maybe my general
> approach was wrong enough that the exchange wouldn't get into source level
> specifics.  Silly me.  I'm back in the lab on tomorrow morning, so I can
> include some more specific source code references then.  I'll also attempt
> to replicate this in an non-RT kernel, the outcome of which may lead me to
> redirect my questions to another venue.  (Understanable if you would rather
> wait on the outcome of that before you reply.)
>
> Best Regards,
> Brian
>
> On Tuesday, February 14, 2017, Julia Cartwright <julia@ni.com> wrote:
>>
>> On Mon, Feb 13, 2017 at 10:42:31PM -0500, Brian Wrenn wrote:
>> > On Monday, February 13, 2017, Julia Cartwright <julia@ni.com> wrote:
>> > > On Mon, Feb 13, 2017 at 03:52:19PM -0500, Brian Wrenn wrote:
>> > > > On Monday, February 13, 2017, Julia Cartwright <julia@ni.com
>> > > > > On Fri, Feb 10, 2017 at 07:48:26PM -0500, Brian Wrenn wrote:
>> [..]
>> > > > > >
>> > > > > > I'm using mmap in a fairly straightforward way.  Basically, upon
>> > > > > > an
>> > > > > > IOC command from the user space application to the kernel
>> > > > > > module, the
>> > > > > > kernel module attempts to copy data into the memory mapped area.
>> > >
>> > > What you are referring to when you say "the memory mapped area" here
>> > > is
>> > > ambiguous, as there are two separate address spaces being spoken
>> > > about.
>> > >
>> > > Assuming you've allocated a page with get_zeroed_page(GFP_KERNEL) and
>> > > established it as the backing page in your vm_operations_struct fault
>> > > callback (like the linked below example), then the two mappings are:
>> > >
>> > >   1. A mapping in the kernels' address space.
>> > >   2. A mapping in the calling process's address space (and, possibly
>> > > in
>> > >        forked processes address spaces as well, depending on the VM
>> > > area
>> > >        flags!)
>> > >
>> > > Mappings into the kernel space may be accessed by kernel code in the
>> > > "normal" ways, through pointer dereference, memset()/memcpy() and
>> > > friends, etc, however, kernel code must handle accesses into usermode
>> > > very carefully.
>> > >
>> > > The calling user code doesn't know anything about, nor should it know
>> > > anything about the existence of the kernel mapping.  It operates
>> > > purely
>> > > on the process mapping (number 2 above), a pointer to which is
>> > > returned
>> > > from the mmap*() system call.
>> >
>> > When I say the memory mapped area, I mean the page size allocated from
>> > within the caller's code.  The kernel module sits idly, waiting for some
>> > calling code to open a file descriptor to the memmap device file.  I've
>> > tried a number of different values for the page size passed from the
>> > calling code.  I've tried the example's 4096 bytes, 1Kbyte, 9Kbytes,
>> > 9Kbytes plus padding to align to the system page sice (4096 bytes), and
>> > mulitples thereof.  So by the memory mapped area I mean the address
>> > provided from get_zeroed_page() to the page size.
>>
>> Yeah, unfortunately, this doesn't clear anything up at all :(.
>>
>> Who is the 'caller' in this context?  Is it different from the 'calling
>> code'?  Is this a user thread calling your user library?  Is 'caller' in
>> this sense a user thread invoking mmap() on a fd in which you've
>> registered a mmap() handler?
>
>
> Yes, the caller is a user space application (non-RT) that opens a file
> descriptor to the device file the kernel module (RT) has created when the
> kernel module initialized.  The user space application calls mmap by passing
> the file descriptor it created and opened.  When the user space application
> opens that file descriptor, that triggers a file operations routine within
> the kernel module that makes the call to get_zeroed_page().  The kernel
> module uses the return value of get_zeroed_page() as the memory address to
> which to write, i.e. the destiation parameter of memcpy() calls made within
> the kernel module.
>
> When I have used the term "mmap'ed region", I'm talking about the address
> space that starts with the address returned by get_zeroed_page(), from the
> kernel module's perspective.  From the user space application's perspective,
> I mean the address space that begins with the address returned by mmap.
> Side note: the user space applicaiton at this time doesn't do anything after
> the mmap call except for loop endlessly to keep the mmap'ed file descriptor
> alive and then catch a SIGINT to properly close the mmap and file descriptor
> prior to exiting.
>
> The high level goals is this: on a repetitive bases, the kernel module has
> data to share with a user space application.  It copies that data to a
> shared memory space the user application can access.  The user application
> consumes that data in the shared memory region to do its task.  I'm trying
> to use mmap to create that shared memory region.  (Side note: I'm not
> insistent that I do this with mmap.  What I have read gives me the
> impression that mmap can share memory in the most fast, straightforward, and
> reliable fashion.  I've tried using it for those reasons.)
>
>>
>> It's an important distinction to know what
>> context the thread is executing in.
>>
>> > > > > > I've checked, double checked, and triple checked that I'm not
>> > > > > > writing to a bad address or an address outside of the mmap'ed
>> > > > > > area.
>> > > > >
>> > > > > How are you performing your checks?  How are you performing the
>> > > > > copy?
>> > > >
>> > > > I use memcpy() to perform the copy.  To perorm my checks, I simply
>> > > > use the
>> > > > write-to address provided by the call to get_zeroed_page(GFP_KERNEL)
>> > > > on the
>> > > > kernel side.
>>
>> You use memcpy() in the kernel?  Or, in user context?  And to what
>> mapped region?
>
>
> The kernel calls memcpy().  The user space application at this time doesn't.
> (I eventually will want the user space application to do so as well, but
> only a read
>
>>
>>
>> In what way do you use the "write-to address" to ensure you're writing
>> to the "right" place?
>
>
> The kernel module calls memcpy().  I pass the destination address as the one
> provided by the call to get_zeroed_page().  I pass the source address as
> some memory local to the kernel module.  I've tried a number of different
> sizes.
>
> // Some simple testing code within the kernel module
> uint8_t my_data[1024];
> memset(my_data, 0xAA, 1024);
> mmap_addr = get_zeroed_page(GFP_KERNEL);
> memcpy(mmap_addr, my_data, 1024);
>
>>
>>
>> Unfortunately, as in most kernel topics, precision in description and
>> words (and most importantly, code) is of utmost importance.
>
>
> Please forgive me for using unclear terms.  I'll be more careful about that
> from now onward.
>
> FWIW, I used this example on which to base my implementation.  My basic
> premise is that if this code can work as-is in an RT kernel, then so should
> my implementation.
>
> https://github.com/paraka/mmap-kernel-transfer-data
>
>
> Thanks again for all your time.
> More to come later...
>
>>
>>
>>    Julia
