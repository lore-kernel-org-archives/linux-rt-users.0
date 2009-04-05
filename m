From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: cyclictest - fix comparison about flexible word counts of
 available_tracers file.
Date: Sun, 5 Apr 2009 16:05:14 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904051559570.747@localhost.localdomain>
References: <49b7c2350904042345x574edfcbx553ba1caccb8bd06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:34591 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbZDEOFg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Apr 2009 10:05:36 -0400
In-Reply-To: <49b7c2350904042345x574edfcbx553ba1caccb8bd06@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 5 Apr 2009, GeunSik Lim wrote:
> [root@fedora9 tracing]# ./cyclictest  -n -t 3 -b 1000000 -P-D 2 --> Success
> [root@fedora9 tracing]#./cyclictest  -n -t 3 -b 1000000 -I -D 2  --> Failed
> [root@fedora9 tracing]#./cyclictest  -n -t 3 -b 1000000 -B-D 2 --> Failed
> 
> So I made  patch file to consider above case.
> If I mistake, correct me.

Good catch. Can you please clean up the patch and resend it with a
patch description and your Signed-off-by line ? 

> --------------------------------------------------
> [root@fedora9 cyclictest]# diff -urN ./cyclictest.c.ori  ./cyclictest.c
> --- ./cyclictest.c.ori	2009-04-05 23:48:03.000000000 +0900
> +++ ./cyclictest.c	2009-04-06 00:15:51.000000000 +0900
> @@ -320,7 +320,7 @@
>  	char name[100];
>  	FILE *fp;
>  	int ret;
> -	int i;
> +	//int i;

  Please remove

>  	/* Make sure tracer is available */
>  	strncpy(filename, debugfileprefix, sizeof(filename));
> @@ -330,7 +330,7 @@
>  	if (!fp)
>  		return -1;
> 
> -	for (i = 0; i < 10; i++) {
> +	while(1) {

  	while (1) {

  please

>  		ret = fscanf(fp, "%99s", name);
>  		if (!ret) {
>  			ret = -1;

Thanks,

	tglx
