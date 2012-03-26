From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests RFC] install: Fix failed to create symbolic link
 hwlatdetect file exists
Date: Mon, 26 Mar 2012 15:35:33 +0200
Message-ID: <CAONaPpGO7WJqNU9WF1WMu6QpTorJ2yvBO5aaZdvHwWzhz4MH_g@mail.gmail.com>
References: <1332465655-7005-1-git-send-email-jkacur@redhat.com>
	<CAFLxGvyZbNRAJdiFmLHBP6Zrju_KDiSJxOPfn2Q9HaPc5bUA7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48128 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214Ab2CZNfd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Mar 2012 09:35:33 -0400
Received: by vbbff1 with SMTP id ff1so2602565vbb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Mar 2012 06:35:33 -0700 (PDT)
In-Reply-To: <CAFLxGvyZbNRAJdiFmLHBP6Zrju_KDiSJxOPfn2Q9HaPc5bUA7w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 26, 2012 at 3:09 PM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> On Fri, Mar 23, 2012 at 3:20 AM, John Kacur <jkacur@redhat.com> wrote=
:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0install -D -m 755 src/hwlatdetect/hwl=
atdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm -f "$(DESTDIR)$(bindir)/hwlatdetect=
" ; \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ln -s $(PYLIB)/hwlatdetect.py "$(DEST=
DIR)$(bindir)/hwlatdetect" ; \
>
> Why an additional command?
> Just change "ln -s" to "ln -sf"...
>
> --

Yup, that's better, but Andrew beat you to it.

Thanks!
John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
