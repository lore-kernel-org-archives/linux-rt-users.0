Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E69CCCA48C
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Jun 2022 00:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiFHAmt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389022AbiFGWwp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Jun 2022 18:52:45 -0400
Received: from mail102c50.megamailservers.eu (mail1471c50.megamailservers.eu [91.136.14.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B9569703
        for <linux-rt-users@vger.kernel.org>; Tue,  7 Jun 2022 12:47:23 -0700 (PDT)
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1654631239;
        bh=wSwo8hUZe3wRB1zJsq7a4H5phErUMPdanAJ6+/eAl5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FOy/lWk7wep3DCfUt+v2KXJnbEwx87sbDPQBT0+7/h5Az5ggJb88NdNo203XgLYqC
         58Hnk2YtDmoI/ojtu3zXDAVGML7MdckMBn5oHzl+Mtign1SLl6Z4StA3XcKTvXqVTW
         uNEwdKjiLHtIIKLWCryBR4QDDoeZimd+JtTJcM3o=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (dynamic-093-133-128-052.93.133.pool.telefonica.de [93.133.128.52])
        (authenticated bits=0)
        by mail102c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 257JlHal029713
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Jun 2022 19:47:19 +0000
Date:   Tue, 7 Jun 2022 21:47:25 +0200
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users@vger.kernel.org
Cc:     "Willett, Tony" <st20214513@outlook.cardiffmet.ac.uk>
Subject: Re: Problems installing a real time kernel.
Message-ID: <20220607214725.639e0fc2@archlinux>
In-Reply-To: <CWXP265MB501198E1F104B6044E93E188A5A59@CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB501198E1F104B6044E93E188A5A59@CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A782F16.629FAB46.006E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
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

On Tue, 7 Jun 2022 13:24:06 +0000, Willett, Tony wrote:
>mailto:lab@panda:~/linux-5.13$ make -j8 deb-pkg

Hi,

a long time ago I was used to build Debian rt patched kernels. When I
migrated to Ubuntu I continued building kernels the Debian way.
Referring to a script I wrote in 2013 to build an Ubuntu linux-rt
package the Debian way:

export CONCURRENCY_LEVEL=8
make-kpkg clean
make-kpkg --rootcmd fakeroot --initrd kernel-image kernel-headers

I exported CONCURRENCY_LEVEL=2. Since you are using make with
the -j8 option, it probably should be CONCURRENCY_LEVEL=8 for you.
However, I don't know what changed within the years. I build at least
one kernel after that seemingly not using the script, but don't have
notes at hand. I remember that before or after that time something
related to fakeroot changed, but IIRC I always used make-kpkg to build
Debian and Ubuntu kernel packages. Probably with something else, but
the --rootcmd fakeroot option.

The package containing the command make-kpkg was removed in 2020, see
https://tracker.debian.org/pkg/kernel-package . But some Debian
rekleases might still provide it. Ubuntu 20.04LTS and earlier still
provide it, see
https://packages.ubuntu.com/search?suite=focal&searchon=names&keywords=kernel-package
, but later Ubuntu releases don't.

If your Debian release's repos should provide it, consider to test
using make-kpkg, if not consider to ask on a Debian user mailing list
how to build a Debian kernel package nowadays.

Alternatively you could build and install a kernel without building a
package at all.

Nowadays I build kernel packages for Arch Linux only. Arch does use a
completely different package management.

Regards,
Ralf
