From: jordan <triplesquarednine@gmail.com>
Subject: Re: nvidia bug or RT bug?
Date: Tue, 5 Jun 2012 20:25:53 -0400
Message-ID: <CAOcfFMySsO-TQ43FzPcbCiXSStGD5x+rM=7PuJqQT6+_L3ng9Q@mail.gmail.com>
References: <CAOcfFMwkXC1Ozs3+QhKUU18JY4KDzNaxAuLq34r+PQOCipSFSg@mail.gmail.com>
	<loom.20120606T011822-880@post.gmane.org>
	<loom.20120606T015743-749@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Glenn Elliott <gelliott@cs.unc.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44156 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab2FFAZy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jun 2012 20:25:54 -0400
Received: by ghrr11 with SMTP id r11so4866995ghr.19
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jun 2012 17:25:53 -0700 (PDT)
In-Reply-To: <loom.20120606T015743-749@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Here is a patch carried forward for 302.06.03 (the beta driver I
> downloaded with CUDA 5.0 preview a few weeks ago). =A0They were
> the same for the 270 driver. =A0This has worked for me; maybe it will
> work for you.

I've actually got 302.11 running, nicely. I haven't had the crash i
originally posted about it a while (that doesn't mean it was fixed
necessarily).

here is a link (pastebin) to the patch that i am using;

http://pastebin.com/CXWtt3E1

do you see any problems, or something that may be missing? (aside from
the MSI stuff?) I ask because i suppose it is possible that nvidia has
changed, added something and the patch that i use is for the 290.
series and i just adapted the pkguibld (build-script) to use the
latest version. So if you see any issues let me know, and i could
forward that information to the packager who is maintaining this
patch.

> I am a little uncertain about my removal of "NV_INIT_MUTEX(mutex)
> semaphore_init(mutex)". =A0I can't remember what my rational was.

I have no idea. ;)

cheerz

Jordan
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
