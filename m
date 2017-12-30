From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: RT patchset naming convention
Date: Sat, 30 Dec 2017 06:27:18 +0100
Message-ID: <20171230062718.1454b6e8@archlinux.localdomain>
References: <CAF_dkJDQy-ONu59RG4HbiuYPEm+DA1zqME8pQp7VdUspcsptVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail56c50.megamailservers.eu ([91.136.10.66]:49242 "EHLO
        mail56c50.megamailservers.eu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750886AbdL3F1S (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 30 Dec 2017 00:27:18 -0500
Received: from archlinux.localdomain (x4e3215f7.dyn.telefonica.de [78.50.21.247])
        (authenticated bits=0)
        by mail56c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id vBU5RFmo010073
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Sat, 30 Dec 2017 05:27:16 +0000
In-Reply-To: <CAF_dkJDQy-ONu59RG4HbiuYPEm+DA1zqME8pQp7VdUspcsptVA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This one didn't came through:

Date: Sat, 30 Dec 2017 06:07:28 +0100
From: Ralf
To: linux-rt-users
Subject: Re: RT patchset naming convention


On Fri, 29 Dec 2017 19:34:43 -0500, Patrick Doyle wrote:
>Is there documentation as to the naming convention?
>patches-4.9.61-rt61.tar.gz  
         ^^^^^^ ^^^^rt patch version
         ^^^^^^kernel version

https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.gz
+
https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.61.gz
or
https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.61.tar.gz

Rt patches that fit to kernel 4.9.61 are all patches
                              4.9.61-rt*

See also https://cdn.kernel.org/category/releases.html .

>Sadly, I don't see any patches for any 4.9.5? releases.  So is there
>any advice as to which patch set I should apply to my kernel?  

Is there a good reason that has to be exactly 4.9.5?

Why don't you follow the 4.9 LTS as close a s possible by upgrading to
a kernel version close to an available rt patch.

4.9.73 is from 2017-12-29, see https://cdn.kernel.org/ ,
IOW I would go with kernel 4.9.68 and patch-4.9.68-rt60

If you really want 4.9.5 you could try to do it as Fernando from CCRMA
does:

https://lists.linuxaudio.org/pipermail/linux-audio-user/2017-December/109022.html

That way a patch might apply automatically with an offset or you
perhaps need to fix it manually.
