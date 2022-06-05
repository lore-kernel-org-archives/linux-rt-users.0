Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73344C433EF
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Jun 2022 12:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbiFEMqG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Jun 2022 08:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFEMqF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Jun 2022 08:46:05 -0400
X-Greylist: delayed 1618 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Jun 2022 05:46:00 PDT
Received: from mail263c50.megamailservers.eu (mail1434c50.megamailservers.eu [91.136.14.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD16248C2
        for <linux-rt-users@vger.kernel.org>; Sun,  5 Jun 2022 05:45:59 -0700 (PDT)
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1654431531;
        bh=RoJA/NwpTFqrHW3lodjT3wSLJTiqU9bswRAgufcgZ24=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=QaC1kfnHaNoWYlLX/8zcxHlf4Onzr64+xeKTGERgF9K6yRu8g4ld/Girs+E4Y5FOv
         6TXwrvjreMAhUzBSum/ty+nIf9aQkFmhJlEcZYT2dQtmK4RnLpZ0mCgII6AYnfFuYu
         v65GmOTgvUeK2u8wWeOjaan0DOl+z3HZcaS8245g=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (dynamic-078-049-021-039.78.49.pool.telefonica.de [78.49.21.39])
        (authenticated bits=0)
        by mail263c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 255CImMk011824
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Jun 2022 12:18:50 +0000
Date:   Sun, 5 Jun 2022 14:18:49 +0200
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     Daniel Wagner <wagi@monom.org>, linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] 4.19.245-rt109
Message-ID: <20220605141849.200cf9e0@archlinux>
In-Reply-To: <165346390046.11398.18138245986252936857@beryllium.lan>
References: <165346390046.11398.18138245986252936857@beryllium.lan>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A742F2A.629C9F2A.0071,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
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

On Fri, 27 May 2022 08:24:39 +0200, Daniel Wagner wrote:
>Signing key fingerprint:
>
>  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C
>
>All keys used for the above files and repositories can be found on the
>following git repository:
>
>   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
>
>Enjoy!

Hi Daniel,

again it's no joy to import your key ;).

$ git clone git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
2>/dev/null && gpg --import pgpkeys/keys/587C5ECA5D0A306C.asc gpg: key
2>587C5ECA5D0A306C: 17 signatures not checked due to missing keys
gpg: key 587C5ECA5D0A306C: "Daniel Wagner <wagi@monom.org>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1


#### So I imported 500+ keys...


$ gpg --import pgpkeys/keys/*asc
[snip]
gpg: Total number processed: 525
gpg:               imported: 515
gpg:              unchanged: 6
gpg:            new subkeys: 2
gpg:         new signatures: 35
gpg: no ultimately trusted keys found
$ gpg --import pgpkeys/keys/587C5ECA5D0A306C.asc
gpg: key 587C5ECA5D0A306C: "Daniel Wagner <wagi@monom.org>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1


#### ...and validation still fails.


$ makepkg -s 
==> Making package: linux-rt-cornflower 4.19.245_rt109-0.300 (Sun 05 Jun 2022 14:08:01 CEST)
[...]
==> Verifying source file signatures with gpg...
    linux-4.19.245.tar ... Passed
    patch-4.19.245-rt109.patch ... FAILED (invalid public key 5BF67BC5082672CABB45ACAE587C5ECA5D0A306C)
==> ERROR: One or more PGP signatures could not be verified!

Regards,
Ralf
