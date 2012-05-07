From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-tests: incorrect first latency value for --verbose
 option
Date: Mon, 7 May 2012 23:41:50 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1205072322250.3886@tycho>
References: <4FA1CB20.5000209@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	williams@redhat.com, jkacur@redhat.com
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37521 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757530Ab2EGVmJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2012 17:42:09 -0400
Received: by wibhj6 with SMTP id hj6so26876wib.1
        for <linux-rt-users@vger.kernel.org>; Mon, 07 May 2012 14:42:07 -0700 (PDT)
In-Reply-To: <4FA1CB20.5000209@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 2 May 2012, Frank Rowand wrote:

> 
> When the --verbose option is selected, the first value for each thread is
> incorrectly reported as zero.
> 
> This is because when collecting the first value, the index into stat->values is
> incremented from zero to one before storing the value.  But when printing the
> values, the first value printed is stat->values[0], which has been initialized
> to zero.

Hi Frank

Ok, no more posting from me after winning a bottle of whiskey at the Irish 
Pub on quiz night. :)

I've been looking at this one, and I'm not sure about it.
According to the help output, 

"-v       --verbose         output values on stdout for statistics
                           format: n:c:v n=tasknum c=count v=value in us"

./cyclictest --verbose -p99 -t | awk '$2~/^0/{ print }' 

       0:       0:       0
       1:       0:       0
       2:       0:       0
       3:       0:       0
       4:       0:       0
       5:       0:       0
       6:       0:       0
       7:       0:       0

So, it looks like the values are 0 at count 0, doesn't that make sense?

Thanks

John Kacur
