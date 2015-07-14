From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 5/6] Change VERSION_STRING to VERSION
Date: Tue, 14 Jul 2015 23:45:54 +0200 (CEST)
Message-ID: <alpine.LFD.2.11.1507142344400.14459@riemann>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com> <1436531131-9186-6-git-send-email-jkacur@redhat.com> <20150714160937.GF21820@linutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1198925378-1436910356=:14459"
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f196.google.com ([209.85.212.196]:36769 "EHLO
	mail-wi0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbbGNVpz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 17:45:55 -0400
Received: by wilh8 with SMTP id h8so2949932wil.3
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2015 14:45:54 -0700 (PDT)
In-Reply-To: <20150714160937.GF21820@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1198925378-1436910356=:14459
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 14 Jul 2015, Sebastian Andrzej Siewior wrote:

> * John Kacur | 2015-07-10 14:25:30 [+0200]:
> 
> >Adding _STRING doesn't add any extra meaning, but the extra length makes
> >the Makefile more unreadable than is necessary, so shorten this up
> 
> It isn't a STRING to begin with. You could use __stringify() to make a
> string out of it. Not sure if -D=\"VERSION\" works as expected. This

That does look a little bogus doesn't it? will need to take a closer look.

> would also get rid of the "overflow" with 0.100 that was mentioned in
> the thread…
> 
> >diff --git a/Makefile b/Makefile
> >index a48e7597b908..1f7640b82fa6 100644
> >--- a/Makefile
> >+++ b/Makefile
> >@@ -158,23 +158,23 @@ release: distclean changelog
> > 	mkdir -p releases
> > 	mkdir -p tmp/rt-tests
> > 	cp -r Makefile COPYING ChangeLog MAINTAINERS doc README.markdown src tmp/rt-tests
> >-	rm -f rt-tests-$(VERSION_STRING).tar rt-tests-$(VERSION_STRING).tar.asc
> >-	tar -C tmp -cf rt-tests-$(VERSION_STRING).tar rt-tests
> >-	gpg2 --default-key clrkwllms@kernel.org --detach-sign --armor rt-tests-$(VERSION_STRING).tar
> >-	gzip rt-tests-$(VERSION_STRING).tar
> >+	rm -f rt-tests-$(VERSION).tar rt-tests-$(VERSION).tar.asc
> >+	tar -C tmp -cf rt-tests-$(VERSION).tar rt-tests
> >+	gpg2 --default-key clrkwllms@kernel.org --detach-sign --armor rt-tests-$(VERSION).tar
> >+	gzip rt-tests-$(VERSION).tar
> > 	rm -f ChangeLog
> >-	cp rt-tests-$(VERSION_STRING).tar.gz rt-tests-$(VERSION_STRING).tar.asc releases
> >+	cp rt-tests-$(VERSION).tar.gz rt-tests-$(VERSION).tar.asc releases
> 
> Is this target in use? I doubt you use Clark's key. You could remove the
> --default-key option and have default-key in ~/.gnupg/gpg.conf.
> 

Oh, I like that idea, will have a closer look.

Thanks

John
--0-1198925378-1436910356=:14459--
