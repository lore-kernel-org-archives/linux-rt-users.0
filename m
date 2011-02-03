From: Miklos Aubert <miklos.aubert@gmail.com>
Subject: Re: Nouveau driver and Linux 2.6.33 RT
Date: Thu, 3 Feb 2011 21:18:20 +0100
Message-ID: <AANLkTim7hemFjxtpbdgZLPeJ_V_Y9h6wWwkk_E0PQ_Kb@mail.gmail.com>
References: <AANLkTikBXGnERNMCv5nJt01j6UpTCEwdjSz+rFZRofsN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62114 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab1BCUSW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Feb 2011 15:18:22 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so1539486wyb.19
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Feb 2011 12:18:21 -0800 (PST)
In-Reply-To: <AANLkTikBXGnERNMCv5nJt01j6UpTCEwdjSz+rFZRofsN@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2 February 2011 22:12, Miklos Aubert <miklos.aubert@gmail.com> wrote=
:
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

I finally got it to work! By trial and error, I found out that this
ioctl call is actually "NOUVEAU_CARD_INIT", which is defined in the
vanilla 2.6.33 kernel, but removed by the RT patch.

Not really understanding what I was doing, I tried putting this ioctl
back and came up with the patch included at the bottom of this mail.
Amazingly, it works!

I think the only reason I need this ioctl is because I'm running
Debian sid, and the current Xorg Nouveau driver wants it. When I try
linking libdrm_nouveau.so.1 to a version found in the libdrm_nouveau1a
package, the ioctl is not used, according to the dmesg. So the problem
should disappear in the next couple of updates. By then I hope a new
RT patch will be out with a newer kernel and Nouveau 0.0.16 :)


--- a/drivers/gpu/drm/nouveau/nouveau_channel.c	2011-02-03
20:17:10.000000000 +0100
+++ b/drivers/gpu/drm/nouveau/nouveau_channel.c	2011-02-03
17:07:47.000000000 +0100
@@ -408,6 +408,7 @@
  ***********************************/

 struct drm_ioctl_desc nouveau_ioctls[] =3D {
+	DRM_IOCTL_DEF_DRV(NOUVEAU_CARD_INIT, nouveau_ioctl_card_init, DRM_AUT=
H),
 	DRM_IOCTL_DEF_DRV(NOUVEAU_GETPARAM, nouveau_ioctl_getparam, DRM_AUTH)=
,
 	DRM_IOCTL_DEF_DRV(NOUVEAU_SETPARAM, nouveau_ioctl_setparam,
DRM_AUTH|DRM_MASTER|DRM_ROOT_ONLY),
 	DRM_IOCTL_DEF_DRV(NOUVEAU_CHANNEL_ALLOC, nouveau_ioctl_fifo_alloc, DR=
M_AUTH),
--- a/include/drm/nouveau_drm.h	2011-02-03 20:17:49.000000000 +0100
+++ b/include/drm/nouveau_drm.h	2011-02-03 17:20:52.000000000 +0100
@@ -200,6 +200,10 @@
 struct drm_nouveau_sarea {
 };

+struct drm_nouveau_card_init {
+	uint32_t handle;
+};
+
 #define DRM_NOUVEAU_CARD_INIT          0x00
 #define DRM_NOUVEAU_GETPARAM           0x01
 #define DRM_NOUVEAU_SETPARAM           0x02
@@ -218,6 +222,7 @@
 #define DRM_NOUVEAU_GEM_INFO           0x47
 #define DRM_NOUVEAU_GEM_PUSHBUF_CALL2  0x48

+#define DRM_IOCTL_NOUVEAU_CARD_INIT
DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_CARD_INIT, struct
drm_nouveau_card_init)
 #define DRM_IOCTL_NOUVEAU_GETPARAM
DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GETPARAM, struct
drm_nouveau_getparam)
 #define DRM_IOCTL_NOUVEAU_SETPARAM
DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SETPARAM, struct
drm_nouveau_setparam)
 #define DRM_IOCTL_NOUVEAU_CHANNEL_ALLOC
DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_ALLOC, struct
drm_nouveau_channel_alloc)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
