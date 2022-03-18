Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AB0C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Mar 2022 09:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiCRJ2t (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiCRJ2r (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Mar 2022 05:28:47 -0400
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Mar 2022 02:27:25 PDT
Received: from mail266c50.megamailservers.eu (mail1452c50.megamailservers.eu [91.136.14.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A82DCBC9
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Mar 2022 02:27:25 -0700 (PDT)
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1647595639;
        bh=EyoCncSqQPsb7CL4ZTlLnGCVIt+V+e9tDWGr+CBvS2M=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=ZQrL1UHyUdZvdi1an3XcTxY+Tmw8felir8Tz7FjE1F0tLiHSgU5byYDyX0TfypYxd
         a8yZCvLm6Qywv4aRh9ATvHn2B5aWFyoBtmd95ipeYRve/tKRX3iNQDoagKE5F4Lkoa
         0G7u7pAPDI2prMT0xcqu4+QOow1bnrPWco0IOgr4=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (dynamic-002-243-188-167.2.243.pool.telefonica.de [2.243.188.167])
        (authenticated bits=0)
        by mail266c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 22I9RHjB025500
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Mar 2022 09:27:18 +0000
Date:   Fri, 18 Mar 2022 10:27:18 +0100
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [ANNOUNCE] 4.19.233-rt105
Message-ID: <20220318102718.1347247d@archlinux>
In-Reply-To: <20220318102051.483333f2@archlinux>
References: <164698646082.13723.1987519373498826881@beryllium.lan>
        <20220318060151.411f6789@archlinux>
        <20220318084800.6f5xs4rnp5kw6lxo@carbon.lan>
        <20220318102051.483333f2@archlinux>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A742F1B.62345077.002A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
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

On Fri, 18 Mar 2022 10:20:51 +0100, Ralf Mardorf wrote:
>On Fri, 18 Mar 2022 09:48:00 +0100, Daniel Wagner wrote:
>>On Fri, Mar 18, 2022 at 06:01:51AM +0100, Ralf Mardorf wrote:  
>>> On Fri, 11 Mar 2022 09:19:04 +0100, Daniel Wagner wrote:    
>>> >Signing key fingerprint:
>>> >
>>> >  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C    
>>> 
>>> Hi,
>>> 
>>> where is actually the required key (E072D068B1F5703E) uploaded, to
>>> verify the patch?    
>>
>>Sorry, forgot to add this to the announce template. The key is
>>available on the korg keyring:
>>
>>   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
>>
>>FWIW, I have a TODO for this:
>>
>>  https://github.com/igaw/stable-rt-tools/issues/11  
>
>Hi,
>
>I can't find the key
>
>1B45744BE36280CA7D6BD460E072D068B1F5703E
>short                   E072D068B1F5703E
>
>at
>https://kernel.googlesource.com/pub/scm/docs/kernel/pgpkeys/+/refs/heads/master
>
>*?*
>Ralf

Actually I don't want to upload something, I want to download the
needed key to verify the rt-patch. It's not available by any public
key server I used when trying to get the public key.
