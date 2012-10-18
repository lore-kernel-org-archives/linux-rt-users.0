From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests] gitignore: add librttest.a to git ignore
Date: Thu, 18 Oct 2012 12:32:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1210181229470.5341@tycho>
References: <20121018162359.GA27911@beefymiracle.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <josh.cartwright@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54300 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992Ab2JRQbA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2012 12:31:00 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so4274440bkc.19
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Oct 2012 09:30:59 -0700 (PDT)
In-Reply-To: <20121018162359.GA27911@beefymiracle.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 18 Oct 2012, Josh Cartwright wrote:

> Commit fb7ef61416b6b191a5186a715e51792847de883c introduced librttest.a
> as a library, but did not add it to .gitignore.  Add it now.
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 047925c..f7ba1d0 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -27,6 +27,7 @@ SRPMS
>  /pip_stress
>  /hackbench
>  /pmqtest
> +librttest.a
>  
>  rt-tests.spec
>  tags
> -- 
> 1.7.12.3
> --

Oh, thanks, but I already have the following queued up for the next 
release

commit d63f567c646e07da87d9ce3cce5e5add74c97e16
Author: John Kacur <jkacur@redhat.com>
Date:   Wed May 9 17:32:11 2012 +0200

    rt-tests / gitignore: Exclude patches and .a libs too.
    
    Minor fix to make working with git nicer.
    Now that we're building a lib, we need to exclude it from git status output.
    Do the same for patches we generate or apply.
    
    Signed-off-by: John Kacur <jkacur@redhat.com>

diff --git a/.gitignore b/.gitignore
index 047925c..1924e73 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,8 @@
 *.o
 *.tar.gz
 *.d
+*.patch
+*.a
 tmp
 patches
 ChangeLog
