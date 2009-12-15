From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 4/7] Add the following new tests - ptsematest -
 sigwaittest - svsematest - sendme
Date: Tue, 15 Dec 2009 09:46:15 -0500 (EST)
Message-ID: <404827952.1772021260888375479.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
References: <4B26E524.7010602@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Carsten Emde <c.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983AbZLOOqb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Dec 2009 09:46:31 -0500
In-Reply-To: <4B26E524.7010602@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


----- "Carsten Emde" <c.emde@osadl.org> wrote:

> John,
> 
> thanks a lot for taking care of the new tests.
> 
> By some reason, the spec file was not included in the patch. This
> patch is needed to prevent the rpm build from finding installed
> but unpackaged files.
> 
> 
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Thanks Carsten - applied.
Clark, you can pull it from branch rt-tests-dev
in git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
