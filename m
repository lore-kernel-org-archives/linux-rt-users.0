From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH rt-tests RFC] install: Fix failed to create symbolic link
 hwlatdetect file exists
Date: Mon, 26 Mar 2012 15:09:10 +0200
Message-ID: <CAFLxGvyZbNRAJdiFmLHBP6Zrju_KDiSJxOPfn2Q9HaPc5bUA7w@mail.gmail.com>
References: <1332465655-7005-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60192 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757294Ab2CZNJL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Mar 2012 09:09:11 -0400
Received: by ghrr11 with SMTP id r11so3750078ghr.19
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Mar 2012 06:09:10 -0700 (PDT)
In-Reply-To: <1332465655-7005-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Mar 23, 2012 at 3:20 AM, John Kacur <jkacur@redhat.com> wrote:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0install -D -m 755 src/hwlatdetect/hwla=
tdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm -f "$(DESTDIR)$(bindir)/hwlatdetect"=
 ; \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ln -s $(PYLIB)/hwlatdetect.py "$(DESTD=
IR)$(bindir)/hwlatdetect" ; \

Why an additional command?
Just change "ln -s" to "ln -sf"...

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
