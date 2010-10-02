From: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Subject: Re: segmentation question
Date: Sat, 2 Oct 2010 12:53:46 -0400
Message-ID: <AANLkTim8OX+TuDS+UWBZXCB+FJhBHYU3EnFeHcL4rm0O@mail.gmail.com>
References: <AANLkTinfuURBV9-4=OhgojKWpRZh8QdPSVkeay71wm=D@mail.gmail.com>
	<AANLkTikV_opDwuP=N6CzE1qQr9GXPznaJUY2R3GR7K--@mail.gmail.com>
	<AANLkTi=PbFW7wuk2U_Xs=RuzTBj17frYTyCbx_Tw6rXi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>,
	Kernel-newbies <kernelnewbies@nl.linux.org>,
	Bond <jamesbond.2k.g@gmail.com>
To: Raz <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40259 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab0JBQxr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 2 Oct 2010 12:53:47 -0400
Received: by iwn5 with SMTP id 5so5087706iwn.19
        for <linux-rt-users@vger.kernel.org>; Sat, 02 Oct 2010 09:53:46 -0700 (PDT)
In-Reply-To: <AANLkTi=PbFW7wuk2U_Xs=RuzTBj17frYTyCbx_Tw6rXi@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Also, can I modify GDT when I am managing memory allocation to tasks.
I mean a task need 120kb, but my segments are divided in to 64kb each.
So, I have to merge two segments to allocate requested memory for
task. In that case I think I need to modify GDT for a descriptor
setting limit.
Usually GDT's are initialized at boot time. But how about at the time
of memory allocation.

NOTE: I am not using any paging at all.

Here GDT means global descriptor table.

Please let me know. Thanks.
Sri.


Here are the links to how to develop kernel.
Also, read intel system programming guide, which gives very good
guidance to architecture
and OS development.

http://www.osdever.net/tutorials/view/brans-kernel-development-tutorial






On Sat, Oct 2, 2010 at 6:15 AM, Raz <raziebe@gmail.com> wrote:
> Can you share the code?
>
> On 02/10/2010 12:10, "Daniel Baluta" <daniel.baluta@gmail.com> wrote:
>
> Hi,
>
> On Sat, Oct 2, 2010 at 12:38 AM, Sri Ram Vemulpali
>
> <sri.ram.gmu06@gmail.com> wrote:
>
>> Hi All,
>>
>> =C2=A0 =C2=A0 =C2=A0I am developing segmentation for my kernel. In t=
hat process I
>> choose to divide ...
>
> You don't have to "tell" your processor to choose only 16-bit offset.
> If the offset is greater than segment limit an exception will occur.
>
>
>>
>> Any insight in to this will help me. please clarify my doubt. Waitin=
g
>> for you reply.
>
>> To unsubscribe from this list: send an email with
>> "unsubscribe kernelnewbies" to ecartis@nl.linu...
>
> @Bond: GTD should be GDT.Also please have a look inside x86 reference
> manual.
>
> thanks,
> Daniel.
>
> --
>
> To unsubscribe from this list: send an email with
> "unsubscribe kernelnewbies" to ecartis@nl.linu...



--=20
Regards,
Sri.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
