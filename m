From: Julia Cartwright <julia@ni.com>
Subject: Re: trying to build rt kernel, fails quickly
Date: Fri, 17 Nov 2017 10:31:55 -0600
Message-ID: <20171117163155.GL872@jcartwri.amer.corp.natinst.com>
References: <201711160828.32811.gheskett@shentel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>
To: Gene Heskett <gheskett@shentel.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:44926 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751116AbdKQQb7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Nov 2017 11:31:59 -0500
Content-Disposition: inline
In-Reply-To: <201711160828.32811.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Nov 16, 2017 at 08:28:32AM -0500, Gene Heskett wrote:
> Greetings all;
> 
> I've had this downloaded for 2 or 3 weeks so its old.
> 
> Tried to build it on a rock64 just now, and got this:
> 
> rock64@rock64:/media/slash/home/rock64/4.11.12.rt15/linux-4.11$ time make
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf  --silentoldconfig Kconfig
>   CHK     include/config/kernel.release
>   UPD     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
> "4.11.12-rt16--- localversion-rt +++ localversion-rt @@ -1 +1 @@ --rt15 
> +-rt16" exceeds 64 characters

My suspicion is that your localversion-rt file in your working tree has
a bizarre value, it should just contain "-rt16\n", instead it contains
garbage which lookes like a patch/merge conflict.

Can you check it's contents?

I've checked the tags pushed to git, and they look just fine, so perhaps
this is a leftover merge problem on your end?

   Julia
