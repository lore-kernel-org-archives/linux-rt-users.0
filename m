From: Paul Gortmaker <paul.gortmaker@gmail.com>
Subject: Re: Nouveau driver and Linux 2.6.33 RT
Date: Thu, 3 Feb 2011 17:38:25 -0500
Message-ID: <AANLkTi=D60Mt2mWD7rTU+3i1sTce3Q9MPcdMJAU1eviF@mail.gmail.com>
References: <AANLkTikBXGnERNMCv5nJt01j6UpTCEwdjSz+rFZRofsN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Miklos Aubert <miklos.aubert@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62771 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab1BCWi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Feb 2011 17:38:27 -0500
Received: by qyk12 with SMTP id 12so1483075qyk.19
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Feb 2011 14:38:26 -0800 (PST)
In-Reply-To: <AANLkTikBXGnERNMCv5nJt01j6UpTCEwdjSz+rFZRofsN@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 2, 2011 at 4:12 PM, Miklos Aubert <miklos.aubert@gmail.com>=
 wrote:
> Hello fellow RT users,
>
> I've built a 2.6.33.7 kernel with the RT patch and the Nouveau driver
> enabled, but Xorg doesn't start.
>
> Using the _same_ configuration and removing the RT patch (vanilla
> kernel from kernel.org), Xorg works.
>
> Booting with drm.debug=3D1, and comparing the kernel logs, I find tha=
t
> the RT kernel seems to be having trouble here :
>
> [ =A0 31.651720] [drm:drm_ioctl], pid=3D1904, cmd=3D0x6440, nr=3D0x40=
, dev
> 0xe200, auth=3D1
> [ =A0 31.651724] [drm:drm_ioctl], no function
> [ =A0 31.651726] [drm:drm_ioctl], ret =3D ffffffea
>
> These messages come from the drm_ioctl() function in
> drivers/gpu/drm/drm_drv.c. But which ioctl are we calling here ? I
> guess one can find it from the cmd=3D0x6440 code. Not me though, I tr=
ied
> to make sense of the source code, but my C is very rusty and it's
> macros and includes all the way down...
>
> Anyway, to me this problem seems to come from the modifications that
> the RT=A0patch does on drivers/gpu/drm/nouveau/nouveau_channel.c. It
> changes the definition macro from DRM_IOCTL_DEF to DRM_IOCTL_DEF_DRV,
> but also removes some lines. Why ?

The removals you point at are due to the different baseline of 33.7 vs.=
 whatever
you are comparing it to.  They dont come from RT, as you can see below:

-------------------------
patches$grep -l nouveau *
printk-convert-console_sem-to-console_mutex.patch
patches$diffstat -p0
printk-convert-console_sem-to-console_mutex.patch|grep nouveau
 b/drivers/gpu/drm/nouveau/nouveau_drv.c  |    8 +-
patches$grep DRM_IOCTL_DEF printk-convert-console_sem-to-console_mutex.=
patch
patches$
-------------------------

You can verify the above yourself by cloning:

git://git.kernel.org/pub/scm/linux/kernel/git/paulg/rt-patches.git

and checking out origin/v2.6.33-rt (which is content identical to 33.7-=
rt30).

Paul

>
>
> =A0struct drm_ioctl_desc nouveau_ioctls[] =3D {
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_CARD_INIT, nouveau_ioctl_card_init, D=
RM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GETPARAM, nouveau_ioctl_getparam, DRM=
_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_SETPARAM, nouveau_ioctl_setparam,
> DRM_AUTH|DRM_MASTER|DRM_ROOT_ONLY),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_CHANNEL_ALLOC, nouveau_ioctl_fifo_all=
oc,
> DRM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_CHANNEL_FREE, nouveau_ioctl_fifo_free=
, DRM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GROBJ_ALLOC, nouveau_ioctl_grobj_allo=
c, DRM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_NOTIFIEROBJ_ALLOC,
> nouveau_ioctl_notifier_alloc, DRM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GPUOBJ_FREE, nouveau_ioctl_gpuobj_fre=
e, DRM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_NEW, nouveau_gem_ioctl_new, DRM_A=
UTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_PUSHBUF, nouveau_gem_ioctl_pushbu=
f, DRM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_PUSHBUF_CALL,
> nouveau_gem_ioctl_pushbuf_call, DRM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_PIN, nouveau_gem_ioctl_pin, DRM_A=
UTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_UNPIN, nouveau_gem_ioctl_unpin, D=
RM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_CPU_PREP,
> nouveau_gem_ioctl_cpu_prep, DRM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_CPU_FINI,
> nouveau_gem_ioctl_cpu_fini, DRM_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_INFO, nouveau_gem_ioctl_info, DRM=
_AUTH),
> - =A0 DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_PUSHBUF_CALL2,
> nouveau_gem_ioctl_pushbuf_call2, DRM_AUTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_GETPARAM, nouveau_ioctl_getparam, DRM=
_AUTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_SETPARAM, nouveau_ioctl_setparam,
> DRM_AUTH|DRM_MASTER|DRM_ROOT_ONLY),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_CHANNEL_ALLOC, nouveau_ioctl_fifo_all=
oc,
> DRM_AUTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_CHANNEL_FREE, nouveau_ioctl_fifo_free=
, DRM_AUTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_GROBJ_ALLOC, nouveau_ioctl_grobj_allo=
c, DRM_AUTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_NOTIFIEROBJ_ALLOC,
> nouveau_ioctl_notifier_alloc, DRM_AUTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_GPUOBJ_FREE, nouveau_ioctl_gpuobj_fre=
e, DRM_AUTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_NEW, nouveau_gem_ioctl_new, DRM_A=
UTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_PUSHBUF, nouveau_gem_ioctl_pushbu=
f, DRM_AUTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_CPU_PREP,
> nouveau_gem_ioctl_cpu_prep, DRM_AUTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_CPU_FINI,
> nouveau_gem_ioctl_cpu_fini, DRM_AUTH),
> + =A0 DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_INFO, nouveau_gem_ioctl_info, DRM=
_AUTH),
> =A0};
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
