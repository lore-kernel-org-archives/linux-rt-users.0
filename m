Return-Path: <SRS0=PXli=CE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB4EC433DF
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Aug 2020 08:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CAA20825
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Aug 2020 08:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sSDk9u9v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PZsG1rIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHZIMQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZIMP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Aug 2020 04:12:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A776DC061574;
        Wed, 26 Aug 2020 01:12:15 -0700 (PDT)
Date:   Wed, 26 Aug 2020 10:12:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598429533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ce2i4eBLh4DsCFywcZynLyOa9lygDA+mufLBjMW1UE=;
        b=sSDk9u9vYg6GJ8sYNq63rZdXEiU3JyK4Tw/51H5Pdkoj+Yw964kkv5dQodxO1YvBcs+mLl
        UAjhC4mGH5bcvqCMhzHHGE/6zl1DnMDi92RFaXln/lLLC2gPg7A0A98qAO4HQsJ8YIt5RF
        peZQxaOMTxGX6GqG8m25o76YVb8Ylvo76Py0Ls/4SInQY3IQimsA/wGaoqIc6ouxH9Ycri
        bI9fmxeu+6kPv5nULIY3FXe2oMV9/TeCkD1LuSvjZBo+TiaRoagnjTLDIur3F099pkW6Zp
        MgQ+GvfRDsYzrQXA12SNbffYW//jas3Yj7QIJLW5fI5VsCUpkcGSQbytL2ru7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598429533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ce2i4eBLh4DsCFywcZynLyOa9lygDA+mufLBjMW1UE=;
        b=PZsG1rIMVqCJDMKQPKgcO6YK03o2d5oP4sjiIFlyAd44U2lnRKYBxfb7tV98P91DdYmNXd
        eC7zL/soBHKyLtAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
 <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-26 10:08:02 [+0200], Daniel Wagner wrote:
> Hi Sebastian,
Hi,

> On Mon, Aug 24, 2020 at 05:46:05PM +0200, Sebastian Andrzej Siewior wrote:
> > I'm pleased to announce the v5.9-rc2-rt1 patch set.
>=20
> I gave it a quick run on my test system. Can't boot the system at this
> point. Didn't look closer at it, maybe it's something obvious...

Carsten reported it the other day, but didn't Cc: the list. I've sent
him this to test:

diff --git a/drivers/gpu/drm/i915/display/intel_sprite.c b/drivers/gpu/drm/=
i915/display/intel_sprite.c
index 24baa5f2047bb..cc435d0a51215 100644
--- a/drivers/gpu/drm/i915/display/intel_sprite.c
+++ b/drivers/gpu/drm/i915/display/intel_sprite.c
@@ -118,8 +118,6 @@ void intel_pipe_update_start(const struct intel_crtc_st=
ate *new_crtc_state)
 			"PSR idle timed out 0x%x, atomic update may fail\n",
 			psr_status);
=20
-	local_lock_irq(&crtc->pipe_update_lock);
-
 	crtc->debug.min_vbl =3D min;
 	crtc->debug.max_vbl =3D max;
 	trace_intel_pipe_update_start(crtc);
@@ -143,11 +141,7 @@ void intel_pipe_update_start(const struct intel_crtc_s=
tate *new_crtc_state)
 			break;
 		}
=20
-		local_unlock_irq(&crtc->pipe_update_lock);
-
 		timeout =3D schedule_timeout(timeout);
-
-		local_lock_irq(&crtc->pipe_update_lock);
 	}
=20
 	finish_wait(wq, &wait);
@@ -180,7 +174,6 @@ void intel_pipe_update_start(const struct intel_crtc_st=
ate *new_crtc_state)
 	return;
=20
 irq_disable:
-	local_lock_irq(&crtc->pipe_update_lock);
 }
=20
 /**
@@ -218,8 +211,6 @@ void intel_pipe_update_end(struct intel_crtc_state *new=
_crtc_state)
 		new_crtc_state->uapi.event =3D NULL;
 	}
=20
-	local_unlock_irq(&crtc->pipe_update_lock);
-
 	if (intel_vgpu_active(dev_priv))
 		return;
=20

He complained about a stale label and so.=20
The RT patch replaced a local-irq-disable with a local-lock which broke.
I intend to get rid of this local-irq-disable on RT, the local-lock is
just duct-tape to make it look the same. If this works for everyone then
I will think of something=E2=80=A6

> Thanks,
> Daniel

Sebastian
