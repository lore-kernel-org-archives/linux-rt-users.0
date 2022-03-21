Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE12C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Mar 2022 10:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbiCUKOs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 21 Mar 2022 06:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiCUKOs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Mar 2022 06:14:48 -0400
Received: from mail263c50.megamailservers.eu (mail1437c50.megamailservers.eu [91.136.14.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3575B15A09
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Mar 2022 03:13:17 -0700 (PDT)
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1647857588;
        bh=+ZcdHd/KZav5HTZJAkHRz0IJsnd4GRkrBe9i6OxpKVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VnetBcp/KIU3SWCCtnEF8MoX/PI+95jnhBupOPDvT02Yb115DsGBxFqsdcMO1Mqd8
         vQeE1y/2glPXmrBrv/x8Cz3L9818qUk/RrvJVoDnQSwAYaUMv4E2ml6VYF/09gXUzt
         6YsRrxZOvHIJ61jNsW5rhEbV74Xe6sSsaimABaSQ=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (dynamic-093-135-178-127.93.135.pool.telefonica.de [93.135.178.127])
        (authenticated bits=0)
        by mail263c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 22LAD6wY022187
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Mar 2022 10:13:08 +0000
Date:   Mon, 21 Mar 2022 11:13:07 +0100
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: Re: [ANNOUNCE] 4.19.233-rt105
Message-ID: <20220321111307.20e45966@archlinux>
In-Reply-To: <20220321083611.ikxq26ax55nqavei@beryllium.lan>
References: <164698646082.13723.1987519373498826881@beryllium.lan>
        <20220318060151.411f6789@archlinux>
        <20220318084800.6f5xs4rnp5kw6lxo@carbon.lan>
        <20220318102051.483333f2@archlinux>
        <20220318102718.1347247d@archlinux>
        <20220318094535.azlclmxubdbmusss@carbon.lan>
        <20220318180057.7a223148@archlinux>
        <20220318184249.39b17ee0@archlinux>
        <20220321083611.ikxq26ax55nqavei@beryllium.lan>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A742F23.62384FB4.0051,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
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

On Mon, 21 Mar 2022 09:36:11 +0100, Daniel Wagner wrote:
>Did you import 587C5ECA5D0A306C.asc from korg?

Hi,

no, I imported it from a keyserver.

>I have very strong feelings when it comes to gpg and no they are not
>the good ones.

;)

I suspected a subkey, but OTOH it's odd that a check points to a
missing subkey, without mentioning the key that needs to be imported.
It's also odd that the needed key is available by a keyserver, but
without the subkey included.

Thank you, I imported from git and all is good now [1].

Regards,
Ralf

[1]
[rocketmouse@archlinux ~]$ gpg --import /tmp/pgpkeys/keys/587C5ECA5D0A306C.asc 
gpg: key 587C5ECA5D0A306C: 17 signatures not checked due to missing keys
gpg: key 587C5ECA5D0A306C: "Daniel Wagner <wagi@monom.org>" 24 new signatures
gpg: key 587C5ECA5D0A306C: "Daniel Wagner <wagi@monom.org>" 2 new subkeys
gpg: Total number processed: 1
gpg:            new subkeys: 2
gpg:         new signatures: 24
[snip]
[rocketmouse@archlinux linux-rt]$ makepkg -s 
==> Making package: linux-rt 4.19.235_rt106-0.1000 (Mon 21 Mar 2022 10:58:09 CET)
[snip]
==> Verifying source file signatures with gpg...
    linux-4.19.235.tar ... Passed
    patch-4.19.235-rt106.patch ... Passed
[snip]
