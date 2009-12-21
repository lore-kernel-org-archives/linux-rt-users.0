From: John Kacur <jkacur@gmail.com>
Subject: Re: More RT Test Programs
Date: Mon, 21 Dec 2009 01:08:02 +0100
Message-ID: <520f0cf10912201608h24a12d31pb02ea0733dea1f5d@mail.gmail.com>
References: <388070393.1730301260825543554.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	 <4B26B838.1080303@osadl.org>
	 <alpine.LFD.2.00.0912150053010.6441@localhost.localdomain>
	 <4B2E8C51.3040302@osadl.org>
	 <520f0cf10912201451q55c823cbia07c23f4a3bbe98c@mail.gmail.com>
	 <4B2EB806.301@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:52098 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbZLUAIF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Dec 2009 19:08:05 -0500
Received: by ewy1 with SMTP id 1so5804119ewy.28
        for <linux-rt-users@vger.kernel.org>; Sun, 20 Dec 2009 16:08:03 -0800 (PST)
In-Reply-To: <4B2EB806.301@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

(Carsten - resend to cc all)

On Mon, Dec 21, 2009 at 12:49 AM, Carsten Emde <Carsten.Emde@osadl.org>=
 wrote:
> John,
>
>> [..] I'll be posting some more tomorrow.
> Okay, great.
>
> I have found an issue with all source files of the new tests. At some
> stage between the original files and Clark's tree, the line delimiter=
s
> changed from NL to CR/NL. Would be great, if you could move this back=
 to NL.

Weird - I'll remove them.
It's not coming from you is it? The patch that you attached here has
^M at the end
of each line. I can run that through a script to remove it - but you
should look into
where that is coming from on your end.

>
> A second issue is related to the removal of the getcpu() definition.
> There is a leftover in svsematest.c which should also be removed for
> consistency. However, this and the other tests no longer compile in E=
L5
> without this definition - should we better revert this and provide a
> working recognition through "grep sched_getcpu
> /usr/include/bits/sched.h"? Or is EL5 irrelevant in this context? I
> still have an EL5 test machine where all RT kernels are tested.


Yup - I've been struggling with a resolution for this issue, I have som=
ething
to post tomorrow after my testing is complete. EL5 is not irrelevant to=
 us.
Do you test 32-bit as well as 64-bit?


>
> Another issue is in the file backfire.c After you removed the line
>>> - =A0 =A0sed s/__VERSION_STRING__/$(VERSION_STRING)/ [..]
> from the Makefile, the driver is producing the rather ugly syslog mes=
sage:
> =A0backfire driver v__VERSION_STRING__
> instead of
> =A0backfire driver v0.57
> or similar.
>
> We better completely remove the version display.

Thanks for the patch, I will apply it.

>
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
