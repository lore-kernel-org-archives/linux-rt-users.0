Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99AC63777
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B53E207F7
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 20:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXCr+4/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgK3UPE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbgK3UPE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 15:15:04 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3AEC0613D2;
        Mon, 30 Nov 2020 12:14:24 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y18so12102878qki.11;
        Mon, 30 Nov 2020 12:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:subject:message-id:mime-version
         :content-disposition;
        bh=r10ZI/QmPOgFD2tboGgSrSMWUns0LgEeoijRW8kvhCY=;
        b=GXCr+4/m3b2AIDFPRhdOGfGBFvEiE7zWBu3RLBWirFZy1fcwlRQCK5awt1x5tZ4fOG
         qEs9HSZmyO/9b89xl/LEXGBRITc0tfLHrl5hjhSjxQAN94+FOthzKta9JQUtK/4swoYO
         SRVxvC7AOAQ7fTUzXcbEUp0QfYxJUHlis9edJyKXGPNp8Hl5xyzyqbCKWRVcDkYiZDvi
         ID7eUDIISQxarNWtHfgfxqTnLv0knYFdIrGrJpGYGjZLtAaAfCGAgAITxHbQUT68ewN1
         Qs33voA81fWwP7r//p/WssgLSMRNwK5fmOOBt81HFIEXl6jAv0VQsYRF3771SyuuG91d
         osMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:subject:message-id
         :mime-version:content-disposition;
        bh=r10ZI/QmPOgFD2tboGgSrSMWUns0LgEeoijRW8kvhCY=;
        b=CBrD9w6eEoozFCHkp9TEhk+ffCWdxr80BH40wd/XoOwfI75slJycgdfc4YAN24R6W6
         hgbEZDpFLy/MPSMARe5FvgH+bf5LedPQjQJ3M4+Rh0J0cVybmguX1fqzRFiWyDu9QluB
         p6r+l6d9y0QLNoes7PWq3hl4IlkO5Iv7wCITQgm91Wt/eauhJ47N9hxlRVv2tpuPc77k
         1iXsdw+hLnT2OCwBFDYvKnzfwSN5uzLcrBQ0QMEAWWwDlRFYpEQeyH2Ser26CnjkHxWU
         Pvs3CLbjb2O1gf0F8g53Dy9iseYfW4R7YgPlK952ZEE/QYp9+X2nvKmTjpGX9PV45Dmh
         I6MQ==
X-Gm-Message-State: AOAM531+dYLvNZpdekWWw9lhXx9sPD7iOh5dp+3z8OcMIWNeSQ2jN7/Q
        f/+9g/O4zG5LYUDTDnxxLXxyUZs/odfpxA==
X-Google-Smtp-Source: ABdhPJy3MTYW6Q5hdvuWAPQTFXZzgaUGfwgR5/ojjetkL8g14i238QBunceJIv2nQtJiwqhoXqwtiA==
X-Received: by 2002:a37:5ac3:: with SMTP id o186mr26129199qkb.389.1606767263500;
        Mon, 30 Nov 2020 12:14:23 -0800 (PST)
Received: from lclaudio.dyndns.org ([191.177.185.4])
        by smtp.gmail.com with ESMTPSA id h13sm18593642qtc.4.2020.11.30.12.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 12:14:22 -0800 (PST)
Sender: "Luis Claudio R. Goncalves" <lclaudio00@gmail.com>
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 573F13C004C; Mon, 30 Nov 2020 17:14:20 -0300 (-03)
Date:   Mon, 30 Nov 2020 17:14:20 -0300
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
Subject: [ANNOUNCE] 4.9.246-rt161
Message-ID: <20201130201420.GF26159@uudg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello RT-list!

I'm pleased to announce the 4.9.246-rt161 stable release.

Note that this is a merge of the upstream stable releases only and no change
has been made to RT code, as the v4.9 branch is in maintenance mode.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: d15cec657345cf3f0fc3d09b0348ba092027bab0
  Tag: v4.9.246-rt161

Or to build 4.9.246-rt161 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.246.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.246-rt161.patch.xz

Enjoy!
Luis


--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAl/FUpkACgkQ85SkI/jm
fCYW+A//b4AmbWCZ+HvYXcv6TgioDo2skOguFs0c/4mIonPDDvmmLn8uKYis820d
2wKczzUEb0ly9oYOlqSoNoBRVyqX+wncN31YmkvVOk+U0Eimk0DuC1YtLJXtoe30
60hH3O4+wiX96qb6q+CPYtfwNt/nH9v/0qUnajM5DQp2tP7jUY3uQsC8EBDetCan
DtY8mbZSU86CFWq5BV9uF7pNQC6bRjWc4N1i9h1WgJ5z4+kXSA9rCFp21f3yZfrW
TUl0BMUgT76tshwVkxWAK8jGql+CfgZXIJCZCzInPf41FVuKHNa6HT7+rGFCH0B/
LfGoOE4hOFrNtGsjgP1D4W0dFA240ek7qz+Bd21O0IQg7C5C522l6W3gEOPHWeo6
HbfU6E5/Fmfk82NcYMi7yynUMpM/r0Oc/AAsfY4hGB9WpMpd32ErTDhv9AkgxLVl
zLipXHwT1yIS9MWZc3WzqiwLOA71mAXnwox2keLno9PCWMrVa8358lXx6Tgy/X0I
sKP6He8bfSb4xQKX1myxwOrcuK+nHChAsGnMB8iXWPlOUyzsYeGdKpIPm7QeQhM9
5bCgBe1cf9gKarCcp2968CbdENGcP1+6AQ4tISk0LJS79fzBd2HlVyskBtwRxhYr
mlL+PGw/HMnv6nWdqPLW6IMZJOkMYjE6eZjPLwrQ+DE8o62jRgk=
=lQ8j
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
