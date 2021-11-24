Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4680C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 21:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbhKXVFV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 16:05:21 -0500
Received: from mwsmtp02oc.mail2world.com ([74.202.142.133]:55625 "EHLO
        mwsmtp02oc.m2wprod.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1351725AbhKXVFN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 16:05:13 -0500
X-Greylist: delayed 1021 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 16:05:13 EST
Received: from mail pickup service by mwsmtp02oc.m2wprod.com with Microsoft SMTPSVC;
         Wed, 24 Nov 2021 12:47:00 -0800
Received: from mail pickup service by mwsmtp02oc.mail2world.com with Microsoft SMTPSVC;
         Wed, 24 Nov 2021 12:46:58 -0800
auth-sender: gheskett@shentel.net
Received: from 204.111.64.149 unverified ([204.111.64.149]) by mwsmtp02oc.mail2world.com with Mail2World SMTP Server; 
        Wed, 24 Nov 2021 12:46:58 -0800
From:   Gene Heskett <gheskett@shentel.net>
Organization: none,nada,zip
To:     linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] 5.4.161-rt66
Date:   Wed, 24 Nov 2021 15:44:58 -0500
User-Agent: KMail/1.9.10
References: <5653da59c25a12ec2bb1cac0957571daa0d86e76.camel@kernel.org>
In-Reply-To: <5653da59c25a12ec2bb1cac0957571daa0d86e76.camel@kernel.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202111241544.58834.gheskett@shentel.net>
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A702F24.619EA44C.0006,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 24 Nov 2021 20:46:58.0482 (UTC) FILETIME=[6C941920:01D7E174]
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tuesday 23 November 2021 11:12:42 Tom Zanussi wrote:

> Hello RT Folks!
>
> I'm pleased to announce the 5.4.161-rt66 stable release.
>
> This release is just an update to the new stable 5.4.161
> version and no RT specific changes have been made.
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
Took about an hour to git clone this
copied a 4.19 preempt-rt .config into its tree, did a make oldconfig 
taking 99% of the defaults getting rid of some obviously not rpi stuffs.

make exits in a few seconds, reporting:
In file included from include/linux/compiler.h:48,
                 from include/linux/stddef.h:4,
                 from include/linux/posix_types.h:4,
                 from include/linux/types.h:17,
                 from include/linux/page-flags.h:8,
                 from kernel/bounds.c:9:
include/linux/compiler-gcc.h:94:1: fatal error: linux/compiler-gcc8.h: No 
such file or directory
 #include gcc_header(__GNUC__)
 ^~~~
compilation terminated.

did an updatedb, but on a complete, running nicely rpi4b, no such file 
anyplace. gcc3.h, gcc4.h yes, totally uptodate raspbian buster system, 
but running this kernel image:

pi@rpi4:/media/pi/workspace/new-5.4-rt/linux-stable-rt $ uname -a
Linux rpi4.coyote.den 4.19.71-rt24-v7l+ #1 SMP PREEMPT RT Thu Feb 6 
07:09:18 EST 2020 armv7l GNU/Linux

fix?

Thank you.

Cheers, Gene Heskett.
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>
