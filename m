From: "xavier droubay" <xavier.droubay@gmail.com>
Subject: Re: 2.6.26.3 with rt3 patch: BUG: sleeping function called kernel/rtmutex.c:743
Date: Tue, 9 Sep 2008 20:29:49 +0200
Message-ID: <2c6d8d720809091129n595a4cr3cfe522d4b6953b4@mail.gmail.com>
References: <2c6d8d720809071806i54e58093vf87bec5175d9b074@mail.gmail.com>
	 <48C4C253.7060401@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org,
	"Carsten Emde" <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:47899 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbYIIS3v (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Sep 2008 14:29:51 -0400
Received: by py-out-1112.google.com with SMTP id p76so1319725pyb.10
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Sep 2008 11:29:50 -0700 (PDT)
In-Reply-To: <48C4C253.7060401@osadl.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks Carsten, for your informations,


> All 2.6.26 related rt-patches are experimental. In fact, it would be
> better to call them 2.6.26.3-rtrc3 to indicate that this is, at best, a
> release candidate - but no release.

As I am these days interested in rt patches I can provide you more
info on my attempts to bring a functional  rt 2.6.26 kernel. I usually
log my compilation results and try to find usefull info (just recompiled
kernel with full ACPI support with the rt7 patch, although I guess I will
obtain the same results). I am not an expert but I have some
background knowledge of linux system as a user.

If you give me info or documentation to read for tests or debugging
purpose, I am ready to help you at the moment, if I able to.

>
> Our "Latest Stable" is 2.6.24.7-rt17
> (http://www.osadl.org/Latest-Stable.latest-stable-realtime-linux.0.html).
> Can't you use this one? If this kernel has the problem you are
> experiencing, we are certainly interested to fix it.
>

As first of all I need a stable kernel for a dual core on the box an
impatient friend,
I'll use 2.6.24.7-rt17 as your advise suggests, and tell you in case I
get trouble with it.


Regards, Xavier Droubay.
