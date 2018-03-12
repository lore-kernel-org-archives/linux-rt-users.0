Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-ot0-f170.google.com ([74.125.82.170]:45392 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeCLSU6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Mar 2018 14:20:58 -0400
Received: by mail-ot0-f170.google.com with SMTP id f11so16244361otj.12
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Mar 2018 11:20:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AM5PR03MB2963ABAC625DD0DB9CF8D694D6DA0@AM5PR03MB2963.eurprd03.prod.outlook.com>
References: <CADJaPTADCHOgHJYJYkaR0pboqNZH_jH_zY0vWAzMxp1NBLTDcA@mail.gmail.com>
 <AM5PR03MB296341BA74D9A542E92E34E9D6CC0@AM5PR03MB2963.eurprd03.prod.outlook.com>
 <20180226094604.7biqg57c4xq2ugao@linutronix.de> <7e7f456f-17b9-ae40-5586-fa676db0d202@pengutronix.de>
 <CADJaPTC57W-3E8u+0xsAGFVFMm_9nge8sXf2Fdt=-qM_kOKMsw@mail.gmail.com>
 <20180227085851.2qivugzwmmcd64am@linutronix.de> <CADJaPTD_cLYxV37oBZjryWPs9X5qFVmWpphBqR6ZOUkOve+-og@mail.gmail.com>
 <AM5PR03MB2963ABAC625DD0DB9CF8D694D6DA0@AM5PR03MB2963.eurprd03.prod.outlook.com>
From: Diana Burgess <diana@peloton-tech.com>
Date: Mon, 12 Mar 2018 11:20:57 -0700
Message-ID: <CADJaPTAauXY22TA_BST16LTaCRGa9FQ8vh7=9VT44N8BmFi3Qg@mail.gmail.com>
Subject: Re: peak_pciefd 0000:06:00.0 can1: can_put_echo_skb: BUG! echo_skb is occupied!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Philipp Schrader <philipp@peloton-tech.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On Mon, Mar 5, 2018 at 1:35 AM, St=C3=A9phane Grosjean
<s.grosjean@peak-system.com> wrote:
> Hi,
>
> The "BUG! echo_skb is occupied" msg is printed when the network tx queue =
is restarted, while there is no room left in the echo_skb array. Note that =
this msg does not prevent any CAN frame to be written on the bus.
>
> There's actually one place where the network tx queue is restarted, howev=
er the echo_skb array is filled:
>
> (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/net/can/peak_canfd/peak_pciefd_main.c#n353)
>
> A driver version in which the below patch has been applied
>
>          /* handle tx link interrupt (if any) */
>          if (pciefd_irq_is_lnk(priv->irq_status)) {
>                  unsigned long flags;
>
>                  spin_lock_irqsave(&priv->tx_lock, flags);
>                  priv->tx_pages_free++;
>                  spin_unlock_irqrestore(&priv->tx_lock, flags);
> -
> -                /* wake producer up */
> -               netif_wake_queue(priv->ucan.ndev);
>          }
>
> has run during the whole weekend (~60 h). The echo_skb array size has als=
o been reduced to 8 slots (instead of 24), to increase the probability for =
the issue to occur; two "cangen -g 0 -i" were running on can0 and can1. Unf=
ortunately, during this period, the "BUG! echo is occupied" msg has been st=
ill sporadically printed (4 times, 2 times for can0, 2 times for can1).
>
> Still under investigation...
>
> Regards,
>
>
>> -----Original Message-----
>> From: Diana Burgess <diana@peloton-tech.com>
>> Sent: samedi 3 mars 2018 02:38
>> To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>; St=C3=A9phane Grosjean
>> <s.grosjean@peak-system.com>; Philipp Schrader <philipp@peloton-
>> tech.com>; linux-can@vger.kernel.org; linux-rt-users@vger.kernel.org
>> Subject: Re: peak_pciefd 0000:06:00.0 can1: can_put_echo_skb: BUG!
>> echo_skb is occupied!
>>
>> On Tue, Feb 27, 2018 at 12:58 AM, Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de> wrote:
>> > On 2018-02-26 11:55:11 [-0800], Diana Burgess wrote:
>> >> That patch is part of my branch already so it does not fix this bug.
>> >>
>> >> Also 4.15 is not part of rt-devel yet so I did not try to build and
>> >> run that version.
>> > about that. The tree you were using is not updated (is EOL) so I
>> > suggest to upgrade to 4.14-RT. This may not fix your bug but you get a
>> > kernel with stable/security updates.
>> >
>> > You mentioned that you use -RT and you see this problem only with the
>> > peak card. You never mentioned if this also happens often or rarely or
>> > if this happens once you disable RT and you keep doing what you are
>> > doing.
>> >
>> >>
>> >> Thanks,
>> >>
>> >
>> > Sebastian
>>
>> I've upgraded to 4.14-RT and tried with and without RT. Using RT I see t=
he
>> bug approximately every 45s (though it is not consistent). This time bet=
ween
>> bugs increases when not using RT, but does not go away.
>>
>> --
>> Diana Burgess
>
> --
> PEAK-System Technik GmbH
> Sitz der Gesellschaft Darmstadt - HRB 9183
> Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
> --

Stephane Grosjean sent out the following two patches which fixed the bug:
   can: peak/pcie_fd: fix echo_skb is occupied! bug
   can: peak/pcie_fd: remove useless code when interface starts

--=20
Diana Burgess
