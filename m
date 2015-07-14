From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 5/6] Change VERSION_STRING to VERSION
Date: Tue, 14 Jul 2015 18:09:37 +0200
Message-ID: <20150714160937.GF21820@linutronix.de>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
 <1436531131-9186-6-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33027 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbbGNQJj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 12:09:39 -0400
Content-Disposition: inline
In-Reply-To: <1436531131-9186-6-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* John Kacur | 2015-07-10 14:25:30 [+0200]:

>Adding _STRING doesn't add any extra meaning, but the extra length mak=
es
>the Makefile more unreadable than is necessary, so shorten this up

It isn't a STRING to begin with. You could use __stringify() to make a
string out of it. Not sure if -D=3D\"VERSION\" works as expected. This
would also get rid of the "overflow" with 0.100 that was mentioned in
the thread=E2=80=A6

>diff --git a/Makefile b/Makefile
>index a48e7597b908..1f7640b82fa6 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -158,23 +158,23 @@ release: distclean changelog
> 	mkdir -p releases
> 	mkdir -p tmp/rt-tests
> 	cp -r Makefile COPYING ChangeLog MAINTAINERS doc README.markdown src=
 tmp/rt-tests
>-	rm -f rt-tests-$(VERSION_STRING).tar rt-tests-$(VERSION_STRING).tar.=
asc
>-	tar -C tmp -cf rt-tests-$(VERSION_STRING).tar rt-tests
>-	gpg2 --default-key clrkwllms@kernel.org --detach-sign --armor rt-tes=
ts-$(VERSION_STRING).tar
>-	gzip rt-tests-$(VERSION_STRING).tar
>+	rm -f rt-tests-$(VERSION).tar rt-tests-$(VERSION).tar.asc
>+	tar -C tmp -cf rt-tests-$(VERSION).tar rt-tests
>+	gpg2 --default-key clrkwllms@kernel.org --detach-sign --armor rt-tes=
ts-$(VERSION).tar
>+	gzip rt-tests-$(VERSION).tar
> 	rm -f ChangeLog
>-	cp rt-tests-$(VERSION_STRING).tar.gz rt-tests-$(VERSION_STRING).tar.=
asc releases
>+	cp rt-tests-$(VERSION).tar.gz rt-tests-$(VERSION).tar.asc releases

Is this target in use? I doubt you use Clark's key. You could remove th=
e
--default-key option and have default-key in ~/.gnupg/gpg.conf.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
