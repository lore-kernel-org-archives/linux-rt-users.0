Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB30C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Mar 2022 05:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiCRFNA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Mar 2022 01:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiCRFM7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Mar 2022 01:12:59 -0400
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 22:11:38 PDT
Received: from mail193c50.megamailservers.eu (mail200c50.megamailservers.eu [91.136.10.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343F2180222
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2022 22:11:37 -0700 (PDT)
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1647579713;
        bh=L+KB4yCAmppFuG125xrbXXKT0/FRm42CZSBr7OhTDa4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aMAUDlMVsaxUATDMuLar4OGRuygmYDG4wQSZOlJLw6M/P5mCHphcMo5nHC1h0W+NB
         3Iz7BmzmX7O6k8MoBg/CG6ElJTEh3zPesm5t3KWOVNlyMG4uXVmzva2uMDKqrBROyp
         vn+Ng42B4YzvA1nGU2WcNlboLuoEfDskk/5YxeH4=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (dynamic-002-243-188-167.2.243.pool.telefonica.de [2.243.188.167])
        (authenticated bits=0)
        by mail193c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 22I51pwF015520
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Mar 2022 05:01:52 +0000
Date:   Fri, 18 Mar 2022 06:01:51 +0100
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: Re: [ANNOUNCE] 4.19.233-rt105
Message-ID: <20220318060151.411f6789@archlinux>
In-Reply-To: <164698646082.13723.1987519373498826881@beryllium.lan>
References: <164698646082.13723.1987519373498826881@beryllium.lan>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CTCH-RefID: str=0001.0A742F27.62341241.001A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
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

On Fri, 11 Mar 2022 09:19:04 +0100, Daniel Wagner wrote:
>Signing key fingerprint:
>
>  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

Hi,

where is actually the required key (E072D068B1F5703E) uploaded, to
verify the patch?

[rocketmouse@archlinux linux-rt]$ gpg --keyserver hkp://keyserver.ubuntu.co=
m --recv-keys 5BF67BC5082672CABB45ACAE587C5ECA5D0A306C
gpg: key 587C5ECA5D0A306C: "Daniel Wagner <dwagner@suse.de>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1
[rocketmouse@archlinux linux-rt]$ gzip -cd patch-4.19.233-rt105.patch.gz | =
gpg2 --verify patch-4.19.233-rt105.patch.sign -
gpg: Signature made Fri 11 Mar 2022 09:10:11 CET
gpg:                using EDDSA key 1B45744BE36280CA7D6BD460E072D068B1F5703E
gpg: Can't check signature: No public key
[rocketmouse@archlinux linux-rt]$ gpg --keyserver hkp://pgp.uni-mainz.de --=
recv-keys 1B45744BE36280CA7D6BD460E072D068B1F5703E
gpg: keyserver receive failed: No data
[rocketmouse@archlinux linux-rt]$ gpg --keyserver hkp://keyserver.ubuntu.co=
m --recv-keys 1B45744BE36280CA7D6BD460E072D068B1F5703E
gpg: keyserver receive failed: No data
[rocketmouse@archlinux linux-rt]$ ls -hl /bin/gpg2
lrwxrwxrwx root root 3 B Sat Nov 13 20:28:21 2021 =EF=92=81 /bin/gpg2 =E2=
=87=92 gpg

Regards,
Ralf
