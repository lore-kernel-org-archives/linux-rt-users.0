From: Pei Lin <telent997@gmail.com>
Subject: Re: Regarding GDT
Date: Thu, 30 Sep 2010 16:15:02 +0800
Message-ID: <AANLkTikKh3X7882RAxiJA1A2MfTGBOD80hgKsLiK7YkB@mail.gmail.com>
References: <AANLkTikBzDcnDgkiv1NxBP-kXyUr00XOa0XThzDJATdK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kernel-newbies <kernelnewbies@nl.linux.org>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58531 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0I3IPD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Sep 2010 04:15:03 -0400
Received: by ywh1 with SMTP id 1so598429ywh.19
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2010 01:15:03 -0700 (PDT)
In-Reply-To: <AANLkTikBzDcnDgkiv1NxBP-kXyUr00XOa0XThzDJATdK@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/9/30 Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>:
> Hi All,
>
> =A0 =A0 =A0I have a doubt regarding implementation of segmentation in=
 OS.
>
> =A0 =A0 =A0Since GDT is used to implement the segmentation, in that t=
able
> you add all segments descriptors dividing the linear address space.
> =A0 =A0 =A0In a flat model you assign for every descriptor the base a=
s 0x0
> and limit as 4GB. This way every DS,CS sees the complete 4GB memory.
> =A0 =A0 =A0But how is the segment protection implemented. I mean if
> segments are not divided with different base address and limit
> preventing
> =A0 =A0 =A0overlapping, there is a possibility of stepping in to othe=
r
> segment. So, why is the flat model is implemented. Also, If I strictl=
y
> implement

If base on x86 architecture, suggest to read intel or AMD 's cpu manual=
=2E
Intel=AE 64 and IA-32 Architectures
Software Developer=92s Manual
Volume 3A:
System Programming Guide, Part 1

3.1 MEMORY MANAGEMENT OVERVIEW
"If paging is not used, the linear address space of the processor is
mapped directly into the physical address space of processor. The
physical address space is defined as the range of addresses that the
processor can generate on its address bus.
Because multitasking computing systems commonly define a linear
address space much larger than it is economically feasible to contain
all at once in physical memory, some method of =93virtualizing=94 the
linear address space is needed. This virtualization of the linear
address space is handled through the processor=92s paging mechanism.
Paging supports a =93virtual memory=94 environment where a large linear
address space is simulated with a small amount of physical memory (RAM
and ROM) and some diskstorage. When using paging, each segment is
divided into pages (typically 4 KBytes each in size), which are stored
either in physical memory or on the disk. The operating system or
executive maintains a page directory and a set of page tables to keep
track of the pages. When a program (or task) attempts to access an
address location in the linear address space, the processor uses the
page directory and page tables to translate the linear address into a
physical address and then performs the requested operation (read or
write) on the memory location."

Some embedded system is not using paging mechanism, because they need
real-time response time and reduce task "jitter". So need programmers
implement the task smaller than the limitation.

Got some information for variable-length segments in internet as below.
"Some systems, such as Burroughs B5500,do not use paging to implement
virtual memory. Instead, they use segmentation, that divide virtual
address spaces into variable-length segments. A virtual address
consists of a segment number and an offset within the segment."

> =A0 =A0 =A0segmentation without paging, then I can have only 8192 seg=
ments
> of size 64kb for whole 4GB address space. Then I have all the segment
> =A0 =A0 =A0descriptors in the GDT. Now if some task uses all its comp=
lete
> segment size, and needs some more space, then is it possible to assig=
n
> =A0 =A0 =A0another DS segment. If so, how is that accomplished, since=
 we
> need to load in DS new index of segment descriptor and keep track of
> all
> =A0 =A0 =A0indexes in to GDT.
>
> =A0 =A0 =A0Can anyone explain how above mentioned things can be achie=
ved.
> --
> Regards,
> Sri.
>
> --
> To unsubscribe from this list: send an email with
> "unsubscribe kernelnewbies" to ecartis@nl.linux.org
> Please read the FAQ at http://kernelnewbies.org/FAQ
>
>



--=20
Best Regards
Lin
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
