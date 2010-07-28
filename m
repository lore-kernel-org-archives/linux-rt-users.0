From: John Kacur <jkacur@redhat.com>
Subject: Re: [patch] drivers/dca: convert dca_lock to a raw spinlock V2
Date: Wed, 28 Jul 2010 23:29:06 +0200
Message-ID: <AANLkTi=tp3NvXnEpko-9OHWePOMunCDUVFH7Nx_9yruG@mail.gmail.com>
References: <1278491341.7926.4.camel@marge.simson.net>
	<1279880285.2791.42.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63007 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415Ab0G1V3I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Jul 2010 17:29:08 -0400
Received: by fxm14 with SMTP id 14so1499832fxm.19
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jul 2010 14:29:06 -0700 (PDT)
In-Reply-To: <1279880285.2791.42.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jul 23, 2010 at 12:18 PM, Mike Galbraith <efault@gmx.de> wrote:
>
> Thanks for the hint+ Thomas. =A0V2 moves allocation outside the lock.
>
> drivers/dca: convert dca_lock to a raw spinlock
>
> [ =A0 25.607517] igb 0000:01:00.0: DCA enabled
> [ =A0 25.607524] BUG: sleeping function called from invalid context a=
t kernel/rtmutex.c:684
> [ =A0 25.607528] pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 0, pid: 1=
805, name: modprobe
> [ =A0 25.607532] Pid: 1805, comm: modprobe Tainted: G =A0 M =A0 =A0W =
N =A02.6.33.5-rt23-rt_debug #2
> [ =A0 25.607536] Call Trace:
> [ =A0 25.607557] =A0[<ffffffff820078a1>] try_stack_unwind+0x151/0x1a0
> [ =A0 25.607566] =A0[<ffffffff820062c2>] dump_trace+0x92/0x370
> [ =A0 25.607573] =A0[<ffffffff8200731c>] show_trace_log_lvl+0x5c/0x80
> [ =A0 25.607578] =A0[<ffffffff82007355>] show_trace+0x15/0x20
> [ =A0 25.607587] =A0[<ffffffff823f4588>] dump_stack+0x77/0x8f
> [ =A0 25.607595] =A0[<ffffffff82043f2a>] __might_sleep+0x11a/0x130
> [ =A0 25.607602] =A0[<ffffffff823f7b93>] rt_spin_lock+0x83/0x90
> [ =A0 25.607611] =A0[<ffffffffa0209138>] dca_common_get_tag+0x28/0x80=
 [dca]
> [ =A0 25.607622] =A0[<ffffffffa02091c8>] dca3_get_tag+0x18/0x20 [dca]
> [ =A0 25.607634] =A0[<ffffffffa0244e71>] igb_update_dca+0xb1/0x1d0 [i=
gb]
> [ =A0 25.607649] =A0[<ffffffffa0244ff5>] igb_setup_dca+0x65/0x80 [igb=
]
> [ =A0 25.607663] =A0[<ffffffffa02535a6>] igb_probe+0x946/0xe4d [igb]
> [ =A0 25.607678] =A0[<ffffffff82247517>] local_pci_probe+0x17/0x20
> [ =A0 25.607686] =A0[<ffffffff82248661>] pci_device_probe+0x121/0x130
> [ =A0 25.607699] =A0[<ffffffff822e4832>] driver_probe_device+0xd2/0x2=
e0
> [ =A0 25.607707] =A0[<ffffffff822e4adb>] __driver_attach+0x9b/0xa0
> [ =A0 25.607714] =A0[<ffffffff822e3d1b>] bus_for_each_dev+0x6b/0xa0
> [ =A0 25.607720] =A0[<ffffffff822e4591>] driver_attach+0x21/0x30
> [ =A0 25.607727] =A0[<ffffffff822e3425>] bus_add_driver+0x1e5/0x350
> [ =A0 25.607734] =A0[<ffffffff822e4e41>] driver_register+0x81/0x160
> [ =A0 25.607742] =A0[<ffffffff8224890f>] __pci_register_driver+0x6f/0=
xf0
> [ =A0 25.607752] =A0[<ffffffffa011505b>] igb_init_module+0x5b/0x5d [i=
gb]
> [ =A0 25.607769] =A0[<ffffffff820001dd>] do_one_initcall+0x3d/0x1a0
> [ =A0 25.607778] =A0[<ffffffff820961f6>] sys_init_module+0xe6/0x270
> [ =A0 25.607786] =A0[<ffffffff82003232>] system_call_fastpath+0x16/0x=
1b
> [ =A0 25.607794] =A0[<00007f84d6783f4a>] 0x7f84d6783f4a
>
> Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
> LKML-Reference: <new-submission>
>
> ---
> =A0drivers/dca/dca-core.c | =A0 62 +++++++++++++++++++++++++++-------=
---------------
> =A01 file changed, 35 insertions(+), 27 deletions(-)
>
> Index: linux-2.6/drivers/dca/dca-core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/dca/dca-core.c
> +++ linux-2.6/drivers/dca/dca-core.c
> @@ -35,7 +35,7 @@ MODULE_VERSION(DCA_VERSION);
> =A0MODULE_LICENSE("GPL");
> =A0MODULE_AUTHOR("Intel Corporation");
>
> -static DEFINE_SPINLOCK(dca_lock);
> +static DEFINE_RAW_SPINLOCK(dca_lock);
>
> =A0static LIST_HEAD(dca_domains);
>
> @@ -88,13 +88,6 @@ static struct dca_domain *dca_get_domain
>
> =A0 =A0 =A0 =A0rc =3D dca_pci_rc_from_dev(dev);
> =A0 =A0 =A0 =A0domain =3D dca_find_domain(rc);
> -
> - =A0 =A0 =A0 if (!domain) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain =3D dca_allocate_domain(rc);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (domain)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&domain->node,=
 &dca_domains);
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0return domain;
> =A0}
>
> @@ -140,19 +133,19 @@ int dca_add_requester(struct device *dev
> =A0 =A0 =A0 =A0if (!dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EFAULT;
>
> - =A0 =A0 =A0 spin_lock_irqsave(&dca_lock, flags);
> + =A0 =A0 =A0 raw_spin_lock_irqsave(&dca_lock, flags);
>
> =A0 =A0 =A0 =A0/* check if the requester has not been added already *=
/
> =A0 =A0 =A0 =A0dca =3D dca_find_provider_by_dev(dev);
> =A0 =A0 =A0 =A0if (dca) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, f=
lags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EEXIST;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0pci_rc =3D dca_pci_rc_from_dev(dev);
> =A0 =A0 =A0 =A0domain =3D dca_find_domain(pci_rc);
> =A0 =A0 =A0 =A0if (!domain) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, f=
lags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
>
> @@ -162,17 +155,17 @@ int dca_add_requester(struct device *dev
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags);
> + =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, flags);
>
> =A0 =A0 =A0 =A0if (slot < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return slot;
>
> =A0 =A0 =A0 =A0err =3D dca_sysfs_add_req(dca, dev, slot);
> =A0 =A0 =A0 =A0if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&dca_lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_spin_lock_irqsave(&dca_lock, flags)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dca =3D=3D dca_find_provider_by_de=
v(dev))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dca->ops->remove_reque=
ster(dca, dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, f=
lags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0 =A0}
>
> @@ -193,14 +186,14 @@ int dca_remove_requester(struct device *
> =A0 =A0 =A0 =A0if (!dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EFAULT;
>
> - =A0 =A0 =A0 spin_lock_irqsave(&dca_lock, flags);
> + =A0 =A0 =A0 raw_spin_lock_irqsave(&dca_lock, flags);
> =A0 =A0 =A0 =A0dca =3D dca_find_provider_by_dev(dev);
> =A0 =A0 =A0 =A0if (!dca) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, f=
lags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0slot =3D dca->ops->remove_requester(dca, dev);
> - =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags);
> + =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, flags);
>
> =A0 =A0 =A0 =A0if (slot < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return slot;
> @@ -222,16 +215,16 @@ u8 dca_common_get_tag(struct device *dev
> =A0 =A0 =A0 =A0u8 tag;
> =A0 =A0 =A0 =A0unsigned long flags;
>
> - =A0 =A0 =A0 spin_lock_irqsave(&dca_lock, flags);
> + =A0 =A0 =A0 raw_spin_lock_irqsave(&dca_lock, flags);
>
> =A0 =A0 =A0 =A0dca =3D dca_find_provider_by_dev(dev);
> =A0 =A0 =A0 =A0if (!dca) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, f=
lags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0tag =3D dca->ops->get_tag(dca, dev, cpu);
>
> - =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags);
> + =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, flags);
> =A0 =A0 =A0 =A0return tag;
> =A0}
>
> @@ -304,23 +297,38 @@ int register_dca_provider(struct dca_pro
> =A0{
> =A0 =A0 =A0 =A0int err;
> =A0 =A0 =A0 =A0unsigned long flags;
> - =A0 =A0 =A0 struct dca_domain *domain;
> + =A0 =A0 =A0 struct dca_domain *domain, *newdomain =3D NULL;
> + =A0 =A0 =A0 =A0struct pci_bus *rc;
>
> =A0 =A0 =A0 =A0err =3D dca_sysfs_add_provider(dca, dev);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> - =A0 =A0 =A0 spin_lock_irqsave(&dca_lock, flags);
> + =A0 =A0 =A0 raw_spin_lock_irqsave(&dca_lock, flags);
> + =A0 =A0 =A0 rc =3D dca_pci_rc_from_dev(dev);
> =A0 =A0 =A0 =A0domain =3D dca_get_domain(dev);
> =A0 =A0 =A0 =A0if (!domain) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, f=
lags);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 newdomain =3D dca_allocate_domain(rc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!newdomain)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_spin_lock_irqsave(&dca_lock, flags)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Recheck, we might have raced after d=
ropping the lock */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain =3D dca_get_domain(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!domain) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain =3D newdomain;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 newdomain =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&domain->node,=
 &dca_domains);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0list_add(&dca->node, &domain->dca_providers);
> - =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags);
> + =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, flags);
>
> =A0 =A0 =A0 =A0blocking_notifier_call_chain(&dca_provider_chain,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 DCA_PROVIDER_ADD, NULL);
> + =A0 =A0 =A0 kfree(newdomain);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> =A0EXPORT_SYMBOL_GPL(register_dca_provider);
> @@ -338,7 +346,7 @@ void unregister_dca_provider(struct dca_
> =A0 =A0 =A0 =A0blocking_notifier_call_chain(&dca_provider_chain,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 DCA_PROVIDER_REMOVE, NULL);
>
> - =A0 =A0 =A0 spin_lock_irqsave(&dca_lock, flags);
> + =A0 =A0 =A0 raw_spin_lock_irqsave(&dca_lock, flags);
>
> =A0 =A0 =A0 =A0list_del(&dca->node);
>
> @@ -347,7 +355,7 @@ void unregister_dca_provider(struct dca_
> =A0 =A0 =A0 =A0if (list_empty(&domain->dca_providers))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dca_free_domain(domain);
>
> - =A0 =A0 =A0 spin_unlock_irqrestore(&dca_lock, flags);
> + =A0 =A0 =A0 raw_spin_unlock_irqrestore(&dca_lock, flags);
>
> =A0 =A0 =A0 =A0dca_sysfs_remove_provider(dca);
> =A0}
>

Hi Mike

Please have a look at tip/rt/2.6.33
Afaict, Thomas already applied your V1 of the patch, plus his fix for
the compile problem.

Since the above looks slightly cleaner, maybe you just need to spin a
clean-up patch
of what is in tip/rt/2.6.33

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
