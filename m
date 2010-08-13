From: "Darcy Watkins" <DWatkins@tranzeo.com>
Subject: RE: 2.6.33.6-rt28 kernel oops while stressing network
Date: Fri, 13 Aug 2010 10:56:30 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE1099C86D3@tranzeo-mail2.12stewart.tranzeo.com>
References: <AANLkTi=NBDyUAL=JpUV4h1-syFS3n=Z9aNxAM+eNoHW6@mail.gmail.com><AANLkTi=tPSeXTZkjPPm_MGmmOx2fZhryOkajgssv0EsX@mail.gmail.com><AANLkTinOmnq0hxL9TaZAuu0x5LORAOKuGYFUam9fMzzo@mail.gmail.com> <AANLkTimnHPhLSxgiX3rrFso-1NKsvp++tHxwGCvqO-Cq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "John Culvertson" <jculvertson@gmail.com>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.tranzeo-emc.com ([64.114.87.10]:2938 "EHLO
	mail2.tranzeo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761928Ab0HMR4h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Aug 2010 13:56:37 -0400
Content-class: urn:content-classes:message
In-Reply-To: <AANLkTimnHPhLSxgiX3rrFso-1NKsvp++tHxwGCvqO-Cq@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi John,

I use Fedora 13 which has 2.6.33.6 as the kernel (without RT).

My machine has three net i/f in it.  Two PCI net cards with Realtek
chipset and Intel PRO built into the mainboard's chipset.

When I installed Fedora using the netboot USB flash drive, it insisted
on using one of the Realtek interfaces for Internet connection so that
is my eth0.  All fine.

More recently, I activated the other two net i/f for private LAN to
target HW test network.  I set one to 10.0.0.1 and the other to
192.168.101.4 and connected them to the target network.  Note that they
were both connected to the same network switch.

Shortly after that, the system froze.  After reboot it would run for a
while and then freeze.  I unplugged the net i/f based on the Intel PRO
and all has been fine since.

I mention all this because you once mentioned you were using two Intel
net i/f.  It may not even be RT related.

I suggest you try (not in any particular order, but each on its own)...

   - running with only one net i/f connected
   - building a side-by-side vanilla kernel 2.6.33.7 (without RT patch)
and running your two net i/f without RT
   - using different net i/f cards (say based on Realtek or something
other than Intel) try running it with RT

If you see your system behavior change related to any of these, it
possibly may not be RT patch related (or it could be tied to a specific
driver).

Regards,

Darcy

-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org
[mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of John
Culvertson
Sent: Friday, August 13, 2010 10:38 AM
To: linux-rt-users@vger.kernel.org
Subject: Re: 2.6.33.6-rt28 kernel oops while stressing network

Since it was my understanding that x86 was the most mature and stable
architecture for preempt-rt, I was surprised when I immediately
encountered problems.  Is this typical when trying the patches on a
new platform?  Like I mentioned before, I am a newbie with preempt-rt.

On Wed, Aug 11, 2010 at 12:53 PM, John Culvertson
<jculvertson@gmail.com> wrote:
> I updated to 2.6.33.7-rt29, and I am seeing similar symptoms.
>
> [ 2120.781166] BUG: unable to handle kernel paging request at c11cd497
> [ 2120.784018] IP: [<c11d5ce2>] tcp_set_skb_tso_segs+0x33/0x85
> [ 2120.784018] *pde = 1d7f6063 *pte = 011cd161
> [ 2120.784018] Oops: 0003 [#1] PREEMPT
--
To unsubscribe from this list: send the line "unsubscribe
linux-rt-users" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
