Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE81C433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 11 Sep 2021 18:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40D0611AD
	for <linux-rt-users@archiver.kernel.org>; Sat, 11 Sep 2021 18:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhIKSj4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 14:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233411AbhIKSj4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 11 Sep 2021 14:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631385523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=naPfW9D7sOQ+tlBxCtCw2BjX9ch4IOhbQQrh/TDUAYw=;
        b=TUNGv7p/vamzNUAqD+WFrRt1fDSCYKXM82WtD+IdzGgLUk+ereNkkgxdozDXSgqFNxxfMc
        TZ5XzmNcmrpmpVDE+yUDclvALxKnj0hstQnu9CDQMjuL4O2YW+jmxCDXUr/WKCVEeITai+
        VN/HXWUXAO74ljQpLuS07FNQQ8Rh7WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-EpSKLqmqN0OCj76jSlPcRA-1; Sat, 11 Sep 2021 14:38:39 -0400
X-MC-Unique: EpSKLqmqN0OCj76jSlPcRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4921A8145E5;
        Sat, 11 Sep 2021 18:38:38 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.32.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C78010013C1;
        Sat, 11 Sep 2021 18:38:37 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id BC4093C0205; Sat, 11 Sep 2021 15:38:35 -0300 (-03)
Date:   Sat, 11 Sep 2021 15:38:35 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
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
Subject: [ANNOUNCE] 4.14.246-rt122
Message-ID: <YTz3q4lJBNvlElks@uudg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="loAnJJOzTgswuIq4"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--loAnJJOzTgswuIq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello RT-list!

I'm pleased to announce the 4.14.246-rt122 stable release.

This release is just an update to the new stable 4.14.246 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 8e08e266e7c78bf94eadbb72e2683deb4a651904

Or to build 4.14.246-rt122 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.246.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.246-rt122.patch.xz


Enjoy!
Luis


--loAnJJOzTgswuIq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAmE896sACgkQ85SkI/jm
fCbHXw//YvifQLWLIxKKR+ZcNROIAr3YMVwcdKAMEwxkUlOtYm80tVm7MuVMldQu
bxApPzexr97n/VVp+4z6tRy9lO46yiUIECFelhiqqcn+TExZUilSAbLooDEt7l0f
UN7NZxmSJmamRHDoY8CPScARPDKvRBHilC8Eplr4M7uO3jG1obAX6rfMJ2Vo1tMV
wHjcsKiOumlbynX3CDix1SYEz+KMV9RmWOHUAyCtmnPkYLIpTWlLl295Ms77Ftgn
8x9zGYubeUTH8b6QWmKTI+WckAvuwcsxyuDhhAbIiAQEEpi/3p6Dm0LU4TJ6xxaL
ohyIOY7s0A8JeUabtzSIoPQvomrJivabj4c+pMFfR1yXcfEPVElEChcZktx7ugfC
Aaa5tnECXqZj8/LEVQ0HkjL8Jg6rKe5TYCOjbaDX2SGlrh/PlsxsyBkCVj/nE7Pb
wLrw2MYn10vmGvVi9hM5Q54ebD8FePmPfWtc5xopqn5Awn/9mjT10m0K75dBOSsf
fcvH3N6Df3fSfT+TlV+Lgpzo3cpUdBPC2Yj/4ik0FcgqKpZmCaN4M+TsfC+ivHbm
ixgM//mB2yqyN325qK8V8T5cDNgJWh04PPuoD8RQHILeSNnPwrAYbXN4kZ2CbFfl
sRGO9BefRswsR0T+F5FltPJe9Hgxy90mjtN6Y/Wih5WO4UlBY4k=
=rb4j
-----END PGP SIGNATURE-----

--loAnJJOzTgswuIq4--

