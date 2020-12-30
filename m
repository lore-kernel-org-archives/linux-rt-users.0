Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3645FC433E6
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Dec 2020 01:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FC021D1B
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Dec 2020 01:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgL3B02 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Dec 2020 20:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3B01 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Dec 2020 20:26:27 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421BC061799;
        Tue, 29 Dec 2020 17:25:47 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id a6so10161893qtw.6;
        Tue, 29 Dec 2020 17:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:subject:message-id:mime-version
         :content-disposition;
        bh=W4Z9kr1S6yPcKYgVhoRkx7aG9Ak1t9tPQPlgoEqeuQk=;
        b=XsRl2nLiwF6laSjZjfeqvxsLUaWPdFO20OXIYsCA2AQqRwWFhtgPM0rWammfz9tqRc
         IGW3o/WoNh7P/ZAce4iP0ck9zOBx8fvHuIRbAxTj4JhOg5/zVcGUn1vz14lPm3s9zE0I
         s0soM1OGY6FeITO/+lSZv586Z1dnor5PfU5XyStB4N2qNXs7wCK8NX2MDb69n+2Vo8vv
         FPxjK4Mb9Gfqtr024uWy9B0/dPHqsWSiuJKhVTHBOYuh9+NKXJKCvmr5fgJvb1Pfbepw
         +Jge3YGgyPqiVBg+u7AxBdLRP2VkopgkJFKFD/qI1XSWpNbW27mkw4S1ZQ4Ca13v7fc2
         hozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:subject:message-id
         :mime-version:content-disposition;
        bh=W4Z9kr1S6yPcKYgVhoRkx7aG9Ak1t9tPQPlgoEqeuQk=;
        b=Oz5BN1hsYmjgnd95V8ZIbcmiTalVMq3w0mvbEa/rzUUSBAPezuJnsOvt6cZ0khm/CX
         2t+NgzmfGdbRMb4cnNPilKonJdIqh6Sf5VEgw7+lG8sUXFwj28Q9W4SzuLunVfiSB7Db
         bo7U8P3b2hbWIPPGxGj+IB1ZW0ngqF4pPwpfhrTzLjCsWQzloAuFnISKYW7diiEjJVsQ
         x4kITGgACmvEP21VtMlKCQCWS2tBGtFuq4lJYP4mmPATJa+on+3oSnv/8+z5KugvfsBj
         UKnnA93u0pBwFjtmZPG69HqFMN1iSboxajk3iwHAL5i8S91E1ockROS//Xr84O+lMaL5
         Gq+A==
X-Gm-Message-State: AOAM5331NSl5B5t8TQYEpIsxBuHZ9MkC70eFhVCfTXlsukmVE4k09JaB
        v8jPaEWQM9C0pd2w4gHpxeJgUBA5rFQ=
X-Google-Smtp-Source: ABdhPJxW+fnslZYvEcHFf6Qx5AU+azQ7sm4bepHnohviEB2pSRnP9u/ekAoSIFb0+cgFKYY1Z7s0hg==
X-Received: by 2002:ac8:4f45:: with SMTP id i5mr15684563qtw.349.1609291546666;
        Tue, 29 Dec 2020 17:25:46 -0800 (PST)
Received: from lclaudio.dyndns.org ([191.177.185.4])
        by smtp.gmail.com with ESMTPSA id d3sm12651836qka.36.2020.12.29.17.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 17:25:45 -0800 (PST)
Sender: "Luis Claudio R. Goncalves" <lclaudio00@gmail.com>
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 0737F3C0039; Tue, 29 Dec 2020 22:25:43 -0300 (-03)
Date:   Tue, 29 Dec 2020 22:25:42 -0300
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.9.249-rt164
Message-ID: <20201230012542.GA1873797@uudg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello RT-list!

I'm pleased to announce the 4.9.249-rt164 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: cd8267a1050e4380c4325a5384de42f4412bfc2b

Or to build 4.9.249-rt164 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.249.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.249-rt164.patch.xz


Enjoy!
Luis


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAl/r1xQACgkQ85SkI/jm
fCbwiw/+Nrxfj5xTXFCNGOfvSuf8dWr8rZfszASsFZAWKLWdXUF9humI2ev3vkgL
KDlAWiTTjQcW1BzSpEROth4I4/v7UcmU+DmZ05Xp8V9u8e/QbRiHTSde1J2adD14
jPE6PZHKsOi2o+iCJJV0vgIF97bMxkIHvGFYOPodluPUVB7+VzM+mDDv9oNr7aSi
UmB+mgMNnsciUw6CDiqe0WHt6XgkxJ8PIzNlpz9RlK3Gu/E/+XwGsPm2fseruPmf
XsmbxFjlbKPychXbGwIVSIox1LbdOV03j3BezOOo0n2/I/36fg98cfxiX4bgWCk1
ukV7TdtQf3sjynWsTqy8kJaaS1CCWlYJgxTLf4Iku1yzAqpvSYhy9B2iLdeWgi6F
OqzYwjsA4fwy1wJgLy1xhgSVUoKzEWKVMtKtRrMq7ZZoMt45fK/kp3rSE3/AHMeo
mjsINyyyVL5evlLvjjF1FOB0UzeGUvRzBVe+DzktkrPXwuzM6D7jJS30rPQwjfVh
JQ61esJsO/P5IAbc7XFZGQpEytCj0/l6Z6jAwI67A4kl01K399C7yLLKaHxpgmHK
p2L8pirLoAMXu2OTpmvEGkayg55rlWe6ubAMcctXdaKfa3BfambaaD9HBCE0Y+Xb
DyBJAjkey6UmfxaugXwu/oV2nwxK7xt5UfXQgBGLiTQdv3REUXA=
=2FoE
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
