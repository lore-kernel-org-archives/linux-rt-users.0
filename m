From: Miklos Aubert <miklos.aubert@gmail.com>
Subject: Nouveau driver and Linux 2.6.33 RT
Date: Wed, 2 Feb 2011 22:12:25 +0100
Message-ID: <AANLkTikBXGnERNMCv5nJt01j6UpTCEwdjSz+rFZRofsN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59300 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab1BBVM1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Feb 2011 16:12:27 -0500
Received: by wwa36 with SMTP id 36so457231wwa.1
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Feb 2011 13:12:26 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello fellow RT users,

I've built a 2.6.33.7 kernel with the RT patch and the Nouveau driver
enabled, but Xorg doesn't start.

Using the _same_ configuration and removing the RT patch (vanilla
kernel from kernel.org), Xorg works.

Booting with drm.debug=3D1, and comparing the kernel logs, I find that
the RT kernel seems to be having trouble here :

[   31.651720] [drm:drm_ioctl], pid=3D1904, cmd=3D0x6440, nr=3D0x40, de=
v
0xe200, auth=3D1
[   31.651724] [drm:drm_ioctl], no function
[   31.651726] [drm:drm_ioctl], ret =3D ffffffea

These messages come from the drm_ioctl() function in
drivers/gpu/drm/drm_drv.c. But which ioctl are we calling here ? I
guess one can find it from the cmd=3D0x6440 code. Not me though, I trie=
d
to make sense of the source code, but my C is very rusty and it's
macros and includes all the way down...

Anyway, to me this problem seems to come from the modifications that
the RT=A0patch does on drivers/gpu/drm/nouveau/nouveau_channel.c. It
changes the definition macro from DRM_IOCTL_DEF to DRM_IOCTL_DEF_DRV,
but also removes some lines. Why ?


 struct drm_ioctl_desc nouveau_ioctls[] =3D {
-   DRM_IOCTL_DEF(DRM_NOUVEAU_CARD_INIT, nouveau_ioctl_card_init, DRM_A=
UTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GETPARAM, nouveau_ioctl_getparam, DRM_AUT=
H),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_SETPARAM, nouveau_ioctl_setparam,
DRM_AUTH|DRM_MASTER|DRM_ROOT_ONLY),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_CHANNEL_ALLOC, nouveau_ioctl_fifo_alloc,
DRM_AUTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_CHANNEL_FREE, nouveau_ioctl_fifo_free, DR=
M_AUTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GROBJ_ALLOC, nouveau_ioctl_grobj_alloc, D=
RM_AUTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_NOTIFIEROBJ_ALLOC,
nouveau_ioctl_notifier_alloc, DRM_AUTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GPUOBJ_FREE, nouveau_ioctl_gpuobj_free, D=
RM_AUTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_NEW, nouveau_gem_ioctl_new, DRM_AUTH)=
,
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_PUSHBUF, nouveau_gem_ioctl_pushbuf, D=
RM_AUTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_PUSHBUF_CALL,
nouveau_gem_ioctl_pushbuf_call, DRM_AUTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_PIN, nouveau_gem_ioctl_pin, DRM_AUTH)=
,
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_UNPIN, nouveau_gem_ioctl_unpin, DRM_A=
UTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_CPU_PREP,
nouveau_gem_ioctl_cpu_prep, DRM_AUTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_CPU_FINI,
nouveau_gem_ioctl_cpu_fini, DRM_AUTH),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_INFO, nouveau_gem_ioctl_info, DRM_AUT=
H),
-   DRM_IOCTL_DEF(DRM_NOUVEAU_GEM_PUSHBUF_CALL2,
nouveau_gem_ioctl_pushbuf_call2, DRM_AUTH),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_GETPARAM, nouveau_ioctl_getparam, DRM_AUT=
H),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_SETPARAM, nouveau_ioctl_setparam,
DRM_AUTH|DRM_MASTER|DRM_ROOT_ONLY),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_CHANNEL_ALLOC, nouveau_ioctl_fifo_alloc,
DRM_AUTH),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_CHANNEL_FREE, nouveau_ioctl_fifo_free, DR=
M_AUTH),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_GROBJ_ALLOC, nouveau_ioctl_grobj_alloc, D=
RM_AUTH),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_NOTIFIEROBJ_ALLOC,
nouveau_ioctl_notifier_alloc, DRM_AUTH),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_GPUOBJ_FREE, nouveau_ioctl_gpuobj_free, D=
RM_AUTH),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_NEW, nouveau_gem_ioctl_new, DRM_AUTH)=
,
+   DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_PUSHBUF, nouveau_gem_ioctl_pushbuf, D=
RM_AUTH),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_CPU_PREP,
nouveau_gem_ioctl_cpu_prep, DRM_AUTH),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_CPU_FINI,
nouveau_gem_ioctl_cpu_fini, DRM_AUTH),
+   DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_INFO, nouveau_gem_ioctl_info, DRM_AUT=
H),
 };
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
