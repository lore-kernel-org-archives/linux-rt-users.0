From: Paul Gortmaker <paul.gortmaker@gmail.com>
Subject: Re: [ANNOUNCE] RT for v2.6.34.8 now available.
Date: Mon, 7 Mar 2011 09:44:25 -0500
Message-ID: <AANLkTikkGA6MUUm6yzHPcc7xktsyJzGmimQ0mbNQJ9vK@mail.gmail.com>
References: <4D71668F.9050201@windriver.com>
	<4D748070.1030502@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-kernel@vger.kernel.org, lwn@lwn.net
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39450 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab1CGOo0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2011 09:44:26 -0500
In-Reply-To: <4D748070.1030502@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 7, 2011 at 1:51 AM, Fernando Lopez-Lezcano
<nando@ccrma.stanford.edu> wrote:
> On 03/04/2011 02:24 PM, Paul Gortmaker wrote:
>>
>> As a value add to the 2.6.34 long term release, I'm happy to also
>> announce the availability of 2.6.34-RT.
>>
>> You can find it in the v2.6.34-rt branch at:
>>
>> =A0 git://git.kernel.org/pub/scm/linux/kernel/git/paulg/rt-patches.g=
it
>
> Great! Many thanks... Actually, impressive work.
>
> I'm trying to integrate/build it into my Fedora based rt packages for=
 Planet
> CCRMA. Warning: I'm doing this on top of the 2.6.34.8-68 fc13 koji bu=
ild, so
> rt is patched on top of the additional Fedora patches for that build =
(with a
> few trivial tweaks to patch cleanly). So I don't know if the followin=
g
> issues are due to that - I will investigate:

Thanks - I'm not surprised to see some fallout in new/updated drivers,
since they change so much per release and I didn't attempt to build eve=
ry
driver under the sun - my core focus was on getting it stable with the =
main
defconfigs I could easily test.   I'll have a look and integrate accord=
ingly.

P.

>
> I found a couple of extra argument cases for __netif_tx_lock:
>
> --- a/drivers/net/qlcnic/qlcnic_main.c =A02010-05-16 17:17:36.0000000=
00 -0400
> +++ b/drivers/net/qlcnic/qlcnic_main.c =A02011-03-06 20:08:16.0000000=
00 -0500
> @@ -1881,7 +1881,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0smp_mb();
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (netif_queue_stopped(netdev) && net=
if_carrier_ok(netdev))
> {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __netif_tx_lock(tx_ring=
->txq, smp_processor_id());
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __netif_tx_lock(tx_ring=
->txq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (qlcnic_tx_avail(tx=
_ring) > TX_STOP_THRESH) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0netif_=
wake_queue(netdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0adapte=
r->tx_timeo_cnt =3D 0;
> --- a/drivers/net/bnx2x_main.c =A02010-05-16 17:17:36.000000000 -0400
> +++ b/drivers/net/bnx2x_main.c =A02011-03-06 19:58:45.000000000 -0500
> @@ -976,7 +976,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * stops the queue
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __netif_tx_lock(txq, smp_processor_id()=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __netif_tx_lock(txq);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((netif_tx_queue_stopped(txq)) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(bp->state =3D=3D BNX2X_STATE_=
OPEN) &&
> ----
>
> a missing include (incomplete type errors for semaphores):
>
> --- a/drivers/net/mlx4/mlx4.h =A0 2010-05-16 17:17:36.000000000 -0400
> +++ b/drivers/net/mlx4/mlx4.h =A0 2011-03-06 20:07:05.000000000 -0500
> @@ -37,6 +37,7 @@
> =A0#ifndef MLX4_H
> =A0#define MLX4_H
>
> +#include <linux/semaphore.h>
> =A0#include <linux/mutex.h>
> =A0#include <linux/radix-tree.h>
> =A0#include <linux/timer.h>
> ----
>
> and this (found compilation fix here:
> http://groups.google.com/group/linux.kernel/browse_thread/thread/c4f0=
fd1ca9298c45/18316184209e6e84?show_docid=3D18316184209e6e84&fwc=3D1):
>
> --- a/drivers/net/wireless/ath/ar9170/usb.c =A0 =A0 2011-03-06
> 19:13:12.000000000 -0500
> +++ b/drivers/net/wireless/ath/ar9170/usb.c =A0 =A0 2011-03-06
> 20:13:06.000000000 -0500
> @@ -741,10 +741,10 @@
>
> =A0 =A0 =A0 =A0/* unbind anything failed */
> =A0 =A0 =A0 =A0if (parent)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 down(&parent->sem);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_lock(parent);
> =A0 =A0 =A0 =A0device_release_driver(&aru->udev->dev);
> =A0 =A0 =A0 =A0if (parent)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&parent->sem);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_unlock(parent);
>
> =A0 =A0 =A0 =A0usb_put_dev(aru->udev);
> =A0}
> ----
>
> I'll let you know how it goes (light testing probably tomorrow, still
> building).
>
> -- Fernando "patiently waiting for 2.6.37-rtx"
> :-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
