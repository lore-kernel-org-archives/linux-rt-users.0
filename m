From: John Kacur <jkacur@redhat.com>
Subject: Re: More RT Test Programs
Date: Tue, 15 Dec 2009 00:55:30 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0912150053010.6441@localhost.localdomain>
References: <388070393.1730301260825543554.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com> <4B26B838.1080303@osadl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Carsten Emde <c.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4811 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758470AbZLNXzw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 18:55:52 -0500
In-Reply-To: <4B26B838.1080303@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 14 Dec 2009, Carsten Emde wrote:

> John,
> 
> > So, for now I am going to at least temporarily submit a patch that
> > removes building the modules from the main makefile.
> That's okay.
> 
> > Of course you can still cd to src/backfire and build the module there
> > without any problems.
> Yes. Shouldn't we then explain this a little bit better in sendme?
> 
> Carsten.
> 
> 
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
> 
> --- sendme-old.c        2009-12-14 22:59:45.114507575 +0100
> +++ sendme.c    2009-12-14 23:07:48.714144429 +0100
> @@ -232,7 +232,12 @@
>        path = open("/dev/backfire", O_RDWR);
>        if (path < 0) {
>                fprintf(stderr, "ERROR: Could not access backfire device, "
> -                               "try 'modprobe backfire'\n");
> +                               "try 'modprobe backfire'.\n"
> +                               "If the module backfire can't be loaded, "
> +                               "it may need to be built first.\n"
> +                               "Execute 'cd src/backfire; make' in the "
> +                               "rt-tests directory (requires rt-tests\n"
> +                               "sources and kernel-devel package).\n");
>                return 1;
>        }
>        fl.l_type = F_WRLCK;
> 

Thanks Carsten - I applied it to my git tree and pushed it.
Clark - pls pull.

