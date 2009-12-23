From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/5] rt-tests: Add a new test pip - priority inheritance
 with processes
Date: Thu, 24 Dec 2009 00:25:55 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0912240022191.15185@localhost.localdomain>
References: <1261584180-13922-1-git-send-email-jkacur@redhat.com> <1261584180-13922-2-git-send-email-jkacur@redhat.com> <1261584180-13922-3-git-send-email-jkacur@redhat.com> <4B329F37.8040508@osadl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12509 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755260AbZLWX0P (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2009 18:26:15 -0500
In-Reply-To: <4B329F37.8040508@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 23 Dec 2009, Carsten Emde wrote:

> John,
> 
> When creating an RPM package with the newly provided test pip, the message
> error: Installed (but unpackaged) file(s) found:
>    /usr/bin/pip
> appeared, and rpmbuild refused to finish building the package.
> 
> 	Carsten.
> 
> -=--------------------------------------------------------------------=-
> 
> Prevent rpmbuild from finding installed but unpackaged files.
> 
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
> 
> diff --git a/rt-tests.spec-in b/rt-tests.spec-in
> index 5ca08ee..a55a9ba 100644
> --- a/rt-tests.spec-in
> +++ b/rt-tests.spec-in
> @@ -35,6 +35,7 @@ rm -rf $RPM_BUILD_ROOT
>  /usr/bin/signaltest
>  /usr/bin/hwlatdetect
>  /usr/bin/rt-migrate-test
> +/usr/bin/pip
>  /usr/bin/ptsematest
>  /usr/bin/sendme
>  /usr/bin/sigwaittest
> 

Thanks Carsten.

Your patch applied cleanly without problems.

I pushed it to my tree.
git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
branch: rt-tests-dev-new
(2fc5d42)

Clark, you can pull from above.

Thanks

