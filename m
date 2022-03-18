Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24615C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Mar 2022 17:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbiCRRoS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiCRRoR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Mar 2022 13:44:17 -0400
Received: from mail118c50.megamailservers.eu (mail1480c50.megamailservers.eu [91.136.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6050231933
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Mar 2022 10:42:56 -0700 (PDT)
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1647625369;
        bh=ye3UrX/2Uc7VpMJq6Cya92Cum9/BZ75RSP84yUeWT+I=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=iJacFSZ91k+wrRi2FbnO6phJA3hk5r9MHo5d/OUbM2iYQx7yArxRr/Lxe12QfOlXO
         6pSNA0HoXT8F3lGeXa60d0K/xEuMLRjxqk9FQNkti6bPO2xPyr0R1pVG0Hj5ozlnbu
         391zelGjbYsUNYMoKJUx+KC/xG9HkmJIdcK4iFBc=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (dynamic-002-243-188-167.2.243.pool.telefonica.de [2.243.188.167])
        (authenticated bits=0)
        by mail118c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 22IHglZj024921
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Mar 2022 17:42:48 +0000
Date:   Fri, 18 Mar 2022 18:42:49 +0100
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     Daniel Wagner <wagi@monom.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] 4.19.233-rt105
Message-ID: <20220318184249.39b17ee0@archlinux>
In-Reply-To: <20220318180057.7a223148@archlinux>
References: <164698646082.13723.1987519373498826881@beryllium.lan>
        <20220318060151.411f6789@archlinux>
        <20220318084800.6f5xs4rnp5kw6lxo@carbon.lan>
        <20220318102051.483333f2@archlinux>
        <20220318102718.1347247d@archlinux>
        <20220318094535.azlclmxubdbmusss@carbon.lan>
        <20220318180057.7a223148@archlinux>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CTCH-RefID: str=0001.0A742F27.6234C499.0018,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-Origin-Country: DE
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 18 Mar 2022 18:00:57 +0100, Ralf Mardorf wrote:
>On Fri, 18 Mar 2022 10:45:35 +0100, Daniel Wagner wrote:
>>$ gpg pgpkeys/keys/587C5ECA5D0A306C.asc =20
>that's the wrong key:
>
>
>[rocketmouse@archlinux linux-rt]$ gzip -cd
>patch-4.19.233-rt105.patch.gz | gpg2 --verify
>patch-4.19.233-rt105.patch.sign - gpg: Signature made Fri 11 Mar 2022
>09:10:11 CET gpg:                using EDDSA key
>1B45744BE36280CA7D6BD460E072D068B1F5703E
>                        ^^^^^^^^^^^^^^^^
>                        587C5ECA5D0A306C.asc
>
>
>Importing your key from a keyserver (e.g. from
>hkp://keyserver.ubuntu.com) isn't an issue at all.
>
>The rt-patch was either signed with another key (E072D068B1F5703E
>instead of 587C5ECA5D0A306C) or the uploaded patch is malicious.
>
>The patch was downloaded from
>https://www.kernel.org/pub/linux/kernel/projects/rt/ :
>
>
>[rocketmouse@archlinux ~]$ head -24 /usr/src/linux-rt-rm/PKGBUILD
>[snip]
>_pkgver=3D4.19.233
>_rtpatchver=3D105
>pkgver=3D"${_pkgver}_rt${_rtpatchver}"
>[snip]
>source=3D(
>  "https://www.kernel.org/pub/linux/kernel/v${_pkgver%%.*}.x/linux-${_pkgv=
er}.tar.gz"
>  "https://www.kernel.org/pub/linux/kernel/v${_pkgver%%.*}.x/linux-${_pkgv=
er}.tar.sign"
>  "https://www.kernel.org/pub/linux/kernel/projects/rt/${_pkgver%.*}/older=
/patch-${_pkgver}-rt${_rtpatchver}.patch.gz"
>  "https://www.kernel.org/pub/linux/kernel/projects/rt/${_pkgver%.*}/older=
/patch-${_pkgver}-rt${_rtpatchver}.patch.sign"

PS: [de]/[en]

[de]
Ich habe das Patch weder =C3=BCber git bekommen, noch habe ich die xz Datei=
en
heruntergeladen. Ich habe die gz Dateien heruntergeladen.
Die gz Patch-Datei wurde mit einem anderen Schl=C3=BCssel signiert. Dieser
Schl=C3=BCssel scheint nicht verf=C3=BCgbar zu sein.

[en]
I didn't get the patch from git, neither did I download the xz
related files. I downloaded the gz related files.
The gz patch file is signed with another key. This key seems to be
unavailable.
