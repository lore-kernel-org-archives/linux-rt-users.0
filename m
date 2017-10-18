From: Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] v4.13.7-rt1
Date: Tue, 17 Oct 2017 20:47:07 -0400
Message-ID: <201710172047.07299.gheskett@shentel.net>
References: <20171017152952.6ab7qsgeqgisqci4@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda.cloud.shentel.net ([204.111.1.146]:53648 "EHLO
        barracuda.cloud.shentel.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751360AbdJRArL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Oct 2017 20:47:11 -0400
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda.cloud.shentel.net with ESMTP id cf4PBVf0rerqYAmD for <linux-rt-users@vger.kernel.org>; Tue, 17 Oct 2017 20:47:09 -0400 (EDT)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 8181621F3D
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Oct 2017 20:47:09 -0400 (EDT)
In-Reply-To: <20171017152952.6ab7qsgeqgisqci4@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 17 October 2017 11:29:52 Sebastian Andrzej Siewior wrote:

> Dear RT folks!
>
> I'm pleased to announce the v4.13.7-rt1 patch set.
>
> Changes since v4.11.12-rt16:
>
>   - Rebase to v4.13.7
>
>   - We have now only the reader bias version of RWLOCK. In v4.11 it
> was possible to choose between both implementations but since the
> reader bias version makes no problems it is now the only
> implementation.
>
>   - The lockdep self test is now disabled. While it produced some
> false positives on v4.11 it now completly locks up the system and
> needs investigation before re-enabling.
>
> Known issues
> 	None
>
> You can get this release via the git tree at:
>
>    
> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> v4.13.7-rt1
>
A bit of a git noob here. Why am I getting this on an r-pi3b?

pi@picnc:/media/slash/home/pi $ git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.13.7-rt1
-bash: git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git: No such file or directory

Thanks.

> The RT patch against v4.13.7 can be found here:
>
>    
> https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.13/older/patch-4
>.13.7-rt1.patch.xz
>
> The split quilt queue is available at:
>
>    
> https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.13/older/patches
>-4.13.7-rt1.tar.xz
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
