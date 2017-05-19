From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] usb: Use _nort in usb_hcd_pci_remove
Date: Fri, 19 May 2017 10:53:58 -0500
Message-ID: <20170519105243.03700e87@tagon>
References: <20170420180027.19316-1-nate.dailey@stratus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_//Wf=dmqdZyyJlP+Y/yEst2g"; protocol="application/pgp-signature"
Cc: <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Nate Dailey <nate.dailey@stratus.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755230AbdESPyH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2017 11:54:07 -0400
In-Reply-To: <20170420180027.19316-1-nate.dailey@stratus.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_//Wf=dmqdZyyJlP+Y/yEst2g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Apr 2017 14:00:27 -0400
Nate Dailey <nate.dailey@stratus.com> wrote:

> A trip through usb_hcd_pci_remove produces:
>=20
>  BUG: sleeping function called from invalid context at kernel/locking/rtm=
utex.c:993
>  in_atomic(): 0, irqs_disabled(): 1, pid: 4752, name: bash
>  INFO: lockdep is turned off.
>  irq event stamp: 0
>  hardirqs last  enabled at (0): [<          (null)>]           (null)
>  hardirqs last disabled at (0): [<ffffffff8108da9d>] copy_process.part.36=
+0x64d/0x2380
>  softirqs last  enabled at (0): [<ffffffff8108da9d>] copy_process.part.36=
+0x64d/0x2380
>  softirqs last disabled at (0): [<          (null)>]           (null)
>  CPU: 1 PID: 4752 Comm: bash Tainted: G        W I     4.9.0debug-rt16+ #2
>  Hardware name: Stratus ftServer 2700/G7LAY, BIOS BIOS Version 6.3:58 09/=
18/2014
>  ffffc90006e5fbd0 ffffffff813d243a ffff88016ac0b240 0000000000001290
>  ffffc90006e5fbf8 ffffffff810c6907 ffff8801682f45d0 ffff8801682f1000
>  ffff8801682f45d0 ffffc90006e5fc18 ffffffff817dee44 ffff88016b2aee18
>  Call Trace:
>  [<ffffffff813d243a>] dump_stack+0x99/0xcf
>  [<ffffffff810c6907>] ___might_sleep+0x137/0x210
>  [<ffffffff817dee44>] rt_spin_lock+0x24/0x60
>  [<ffffffff815b526f>] ehci_irq+0x2f/0x400
>  [<ffffffff814226b9>] ? pci_bus_read_config_word+0x99/0xb0
>  [<ffffffff81592d66>] usb_hcd_irq+0x26/0x40
>  [<ffffffff815a7a90>] usb_hcd_pci_remove+0x50/0x170
>  [<ffffffff815b933a>] ehci_pci_remove+0x1a/0x20
>  [<ffffffff8142fc39>] pci_device_remove+0x39/0xc0
>  [<ffffffff8152c4da>] __device_release_driver+0x9a/0x150
>  [<ffffffff8152c5b3>] device_release_driver+0x23/0x30
>  [<ffffffff81427f6c>] pci_stop_bus_device+0x8c/0xa0
>  [<ffffffff8142808a>] pci_stop_and_remove_bus_device_locked+0x1a/0x30
>  [<ffffffff8143182c>] remove_store+0x7c/0x90
>  [<ffffffff81526508>] dev_attr_store+0x18/0x30
>  [<ffffffff81313444>] sysfs_kf_write+0x44/0x60
>  [<ffffffff81312d7c>] kernfs_fop_write+0x13c/0x1d0
>  [<ffffffff81279bb7>] __vfs_write+0x37/0x160
>  [<ffffffff81118c82>] ? rcu_sync_lockdep_assert+0x12/0x60
>  [<ffffffff8127e3c6>] ? __sb_start_write+0x176/0x260
>  [<ffffffff8127a3f4>] ? vfs_write+0x184/0x1b0
>  [<ffffffff8127a325>] vfs_write+0xb5/0x1b0
>  [<ffffffff810025e0>] ? syscall_trace_enter+0x1d0/0x380
>  [<ffffffff8127b7e8>] SyS_write+0x58/0xc0
>  [<ffffffff81002d0a>] do_syscall_64+0x7a/0x230
>  [<ffffffff817df6c9>] entry_SYSCALL64_slow_path+0x25/0x25
>=20
> Repro via something like:
>=20
> > echo 1 > /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:01.0=
/0000:3d:00.0/0000:3e:01.0/0000:66:00.0/remove =20
>=20
> Switching usb_hcd_pci_remove to use _nort variants prevents the BUG.
>=20
> Signed-off-by: Nate Dailey <nate.dailey@stratus.com>
> ---
>  drivers/usb/core/hcd-pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index 7859d738df41..e9e7307028bc 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -341,9 +341,9 @@ void usb_hcd_pci_remove(struct pci_dev *dev)
>  	 * to test whether the controller hardware has been removed (e.g.,
>  	 * cardbus physical eject).
>  	 */
> -	local_irq_disable();
> +	local_irq_disable_nort();
>  	usb_hcd_irq(0, hcd);
> -	local_irq_enable();
> +	local_irq_enable_nort();
> =20
>  	/* Note: dev_set_drvdata must be called while holding the rwsem */
>  	if (dev->class =3D=3D CL_EHCI) {
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Should have CC'd lkml for a kernel patch (even RT related). Sorry I didn't =
catch that earlier.

Acked-by: Clark Williams <williams@redhat.com>

--=20
The United States Coast Guard
Ruining Natural Selection since 1790

--Sig_//Wf=dmqdZyyJlP+Y/yEst2g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZHxUWAAoJEBO1XdB8U7hR7RkP/Ayockzg6/RVXqLQVNLOM6gl
OJCJKAygYjPZFg+ls99T97Wx6kA61JwYAsdeQ6f92qS9zFpk+vCtvbsmauSrfqOi
Q1ktaCzXoYpvv2iip87k8/xb+bFFeKATo0B5a4EH5wwGeQoyvHRLWvh68c8n/oZA
exqvgMv9PCXTBGVa5zv9lP4ceIUibnhFTiO2MxTISEwm+YipEfIrkiLKxA2beVLW
wSHyElKKWlZT8cAWkB6JmbnuKJ4H+lfbKo+03Cg6YDnfWaVuAR50plOTAX8lYnXv
wD6mTmUCT2NXshtTF7Xw7WK9J9iXy0K63BbZfYGmROhtYHMOcqhIPx7BvWXx+2Jb
XZPcajiddCgi53yPk/x66fzcyyemAreFxEKZPbDFL/yQfjvUFH5Jfx48H4Qe8In6
tta+W6pr2iCVs+Z5zPHOVjSQMKKF1+cYxBs3xPe1H/6Kc5Uph6pJHk3V358kKDNQ
8hn1U5h9ixlbDnelPUG2BVWvsVnS1g7spW37k5QIkVAK5013fpNyDNdshz29qYSz
Zh8EZHzQB4Jn4BmQaN4uHeBrrlIHwWEhVggsrufvRcsPTOaPeiJ0TA8gUc84hsJ4
S6s6H3GWefoxvYGhgXERwRhSF1nv1BjxTaCi2P+YTu56HQI7dhYfdjzhXMprsyC/
8yaZibVpyUdBbkiWBac6
=jpmJ
-----END PGP SIGNATURE-----

--Sig_//Wf=dmqdZyyJlP+Y/yEst2g--
