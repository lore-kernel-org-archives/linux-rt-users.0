From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 6/6] Create an rt-tests.tar file using git-archive
Date: Tue, 14 Jul 2015 18:13:24 +0200
Message-ID: <20150714161324.GG21820@linutronix.de>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
 <1436531131-9186-7-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33045 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbbGNQN0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 12:13:26 -0400
Content-Disposition: inline
In-Reply-To: <1436531131-9186-7-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* John Kacur | 2015-07-10 14:25:31 [+0200]:

>diff --git a/Makefile b/Makefile
>index 1f7640b82fa6..07394e1292f7 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -165,6 +166,10 @@ release: distclean changelog
> 	rm -f ChangeLog
> 	cp rt-tests-$(VERSION).tar.gz rt-tests-$(VERSION).tar.asc releases
> 
>+.PHONY: tarball
>+tarball:
>+	git archive --worktree-attributes --prefix=rt-tests-${VERSION}/ -o rt-tests-${VERSION}.tar v${VERSION}

Okay. So this looks like the release target could go :)

> .PHONY: push
> push:	release
> 	scripts/do-git-push $(VERSION)

Sebastian
