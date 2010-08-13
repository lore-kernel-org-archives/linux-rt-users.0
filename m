From: John Culvertson <jculvertson@gmail.com>
Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
Date: Fri, 13 Aug 2010 14:07:08 -0400
Message-ID: <AANLkTimU0pf-9xRzJ8p4-OY=itmfjS3GJX4CKBZ9XorG@mail.gmail.com>
References: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com>
	<AANLkTi=tPSeXTZkjPPm_MGmmOx2fZhryOkajgssv0EsX@mail.gmail.com>
	<AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com>
	<AANLkTimnHPhLSxgiX3rrFso-1NKsvp++tHxwGCvqO-Cq@mail.gmail.com>
	<D61182AC8012EA4EBC531B3AF23BE1099C86D3@tranzeo-mail2.12stewart.tranzeo.com>
	<AANLkTikty=V_==0udO9F2MxpVxwuLzyOQZt0ha5=VC3y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f66.google.com ([209.85.210.66]:65069 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab0HMTO4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Aug 2010 15:14:56 -0400
Received: by pzk3 with SMTP id 3so357268pzk.1
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Aug 2010 12:14:56 -0700 (PDT)
In-Reply-To: <AANLkTikty=V_==0udO9F2MxpVxwuLzyOQZt0ha5=VC3y@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks for the suggestions. =A0I have tried the unpatched 2.6.33.7
kernel, and the problem does not occur. =A0The hardware is a single
board industrial computer with the network controllers onboard, so I
cannot easily try different NICs. =A0I have not seen the problem occur
with only one port in use, but I have not tested that long enough to
be positive.

One thing that may be a little odd about this computer is that both
Ethernet controllers (Intel 82559) share the same PCI interrupt.
Interrupt sharing should be OK, but since adjacent PCI slots in normal
PCs generally use different interrupts, it may not occur often in
other systems.

On Fri, Aug 13, 2010 at 1:56 PM, Darcy Watkins <DWatkins@tranzeo.com> w=
rote:
> Hi John,
>
> I use Fedora 13 which has 2.6.33.6 as the kernel (without RT).
>
> My machine has three net i/f in it. =A0Two PCI net cards with Realtek
> chipset and Intel PRO built into the mainboard's chipset.
>
> When I installed Fedora using the netboot USB flash drive, it insiste=
d
> on using one of the Realtek interfaces for Internet connection so tha=
t
> is my eth0. =A0All fine.
>
> More recently, I activated the other two net i/f for private LAN to
> target HW test network. =A0I set one to 10.0.0.1 and the other to
> 192.168.101.4 and connected them to the target network. =A0Note that =
they
> were both connected to the same network switch.
>
> Shortly after that, the system froze. =A0After reboot it would run fo=
r a
> while and then freeze. =A0I unplugged the net i/f based on the Intel =
PRO
> and all has been fine since.
>
> I mention all this because you once mentioned you were using two Inte=
l
> net i/f. =A0It may not even be RT related.
>
> I suggest you try (not in any particular order, but each on its own).=
=2E.
>
> =A0 - running with only one net i/f connected
> =A0 - building a side-by-side vanilla kernel 2.6.33.7 (without RT pat=
ch)
> and running your two net i/f without RT
> =A0 - using different net i/f cards (say based on Realtek or somethin=
g
> other than Intel) try running it with RT
>
> If you see your system behavior change related to any of these, it
> possibly may not be RT patch related (or it could be tied to a specif=
ic
> driver).
>
> Regards,
>
> Darcy
>
> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org
> [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of John
> Culvertson
> Sent: Friday, August 13, 2010 10:38 AM
> To: linux-rt-users@vger.kernel.org
> Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network
>
> Since it was my understanding that x86 was the most mature and stable
> architecture for preempt-rt, I was surprised when I immediately
> encountered problems. =A0Is this typical when trying the patches on a
> new platform? =A0Like I mentioned before, I am a newbie with preempt-=
rt.
>
> On Wed, Aug 11, 2010 at 12:53 PM, John Culvertson
> <jculvertson@gmail.com> wrote:
>> I updated to 2.6.33.7-rt29, and I am seeing similar symptoms.
>>
>> [ 2120.781166] BUG: unable to handle kernel paging request at c11cd4=
97
>> [ 2120.784018] IP: [<c11d5ce2>] tcp_set_skb_tso_segs+0x33/0x85
>> [ 2120.784018] *pde =3D 1d7f6063 *pte =3D 011cd161
>> [ 2120.784018] Oops: 0003 [#1] PREEMPT
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
