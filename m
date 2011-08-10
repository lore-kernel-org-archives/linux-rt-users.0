From: jordan <triplesquarednine@gmail.com>
Subject: Re: 3.0.1-rt8 + Nvidia
Date: Wed, 10 Aug 2011 00:23:33 -0400
Message-ID: <CAOcfFMzB0Wz_h8y+L_YKC3vVFz98VtRjFb87T3GV0V02tHy2yA@mail.gmail.com>
References: <CAOcfFMyObtC2qeqRBxo-cDGaDLHrPdHXmfQc=fujY64dRVBHPw@mail.gmail.com>
	<CAGQ70etT_LO4GV9wvcPyMJfeYiV-m-_y7dAbG-qfgceTcbPQFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Oon-Ee Ng <ngoonee.talk@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:57827 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab1HJEXe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Aug 2011 00:23:34 -0400
Received: by iye16 with SMTP id 16so401350iye.1
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Aug 2011 21:23:34 -0700 (PDT)
In-Reply-To: <CAGQ70etT_LO4GV9wvcPyMJfeYiV-m-_y7dAbG-qfgceTcbPQFQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey ngoonee,

ya, we've chatted in the Arch forums, before. and i also saw your pkgbuild.

> This is covered on another thread on this list. You need to 'patch'
> the kernel, not the driver, some symbols are exported as GPL which
> prevents the driver from being used.

must have missed it, i will have a look back.

> This is a licensing issue though, so I've held off implementing that
> patch in my own kernel PKGBUILD in Arch (linux-rt-ice). I think it is
> illegal to distribute such a patch, though using it on your own
> machine may be fine (those who are more knowledgable should correct me
> on this).

lame, that it isn't distributable. Well, assuming i can have a look at
the patch, then i'll just patch it on my end. thanks for the info,

jordan
