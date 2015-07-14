From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4/6] Add .tar files to .gitignore
Date: Tue, 14 Jul 2015 17:58:30 +0200
Message-ID: <20150714155830.GD21820@linutronix.de>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
 <1436531131-9186-5-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:32966 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbbGNP6c (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 11:58:32 -0400
Content-Disposition: inline
In-Reply-To: <1436531131-9186-5-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* John Kacur | 2015-07-10 14:25:29 [+0200]:

>Ignore .tar files too
>
>Signed-off-by: John Kacur <jkacur@redhat.com>
>---
> .gitignore | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/.gitignore b/.gitignore
>index 1924e73bef67..ceee8bfb6e9a 100644
>--- a/.gitignore
>+++ b/.gitignore
>@@ -2,6 +2,7 @@
> .*
> *.o
> *.tar.gz
>+*.tar
> *.d
> *.patch
> *.a

Wouldn't it make sense to remove *.tar* and *patch from that list?
After all if "git status" shows you that those exists then step two
should be remove them, right? Why would you want to them around?

Sebastian
