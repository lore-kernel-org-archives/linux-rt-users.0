From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: segmentation question
Date: Sat, 2 Oct 2010 13:06:55 +0300
Message-ID: <AANLkTikV_opDwuP=N6CzE1qQr9GXPznaJUY2R3GR7K--@mail.gmail.com>
References: <AANLkTinfuURBV9-4=OhgojKWpRZh8QdPSVkeay71wm=D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kernel-newbies <kernelnewbies@nl.linux.org>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>,
	Bond <jamesbond.2k.g@gmail.com>
To: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54412 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab0JBKG5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 2 Oct 2010 06:06:57 -0400
Received: by qyk9 with SMTP id 9so2131643qyk.19
        for <linux-rt-users@vger.kernel.org>; Sat, 02 Oct 2010 03:06:56 -0700 (PDT)
In-Reply-To: <AANLkTinfuURBV9-4=OhgojKWpRZh8QdPSVkeay71wm=D@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Sat, Oct 2, 2010 at 12:38 AM, Sri Ram Vemulpali
<sri.ram.gmu06@gmail.com> wrote:
> Hi All,
>
> =A0 =A0 =A0I am developing segmentation for my kernel. In that proces=
s I
> choose to divide whole memory in to fixed size segments. So a 4GB
> memory can be divided in to 8192 segments. So I initialize segment
> descriptors in to the GTD withs segments base address and limit. Here
> base address are 0,0x10000,0x20000,..... and limit is 64kb always for
> every segment. For a task if I choose a segment to assign, I will
> place the index of that segment descriptor in to CS, DS. Now when
> process generates address to put on address bus, then it will do
> computation from logical address to linear address.
> After processor picks logical address, it chooses segment descriptor
> and adds this 32-bit logical address to segment base address to
> generate linear address. Now my question is, if my segment size is
> 64kb, how is that 32-bit offset is added to segment base address,
> which is not right. It should only consider 16-bit offset to add to
> base to generate linear address. How can I tell to my processor to
> choose only 16-bit offset. Does processor drives offset bit width
> automatically based on limit defined in segment descriptor.

You don't have to "tell" your processor to choose only 16-bit offset.
If the offset is greater than segment limit an exception will occur.


>
> Any insight in to this will help me. please clarify my doubt. Waiting
> for you reply.

> To unsubscribe from this list: send an email with
> "unsubscribe kernelnewbies" to ecartis@nl.linux.org
> Please read the FAQ at http://kernelnewbies.org/FAQ
>
>
@Bond: GTD should be GDT.Also please have a look inside x86 reference m=
anual.

thanks,
Daniel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
