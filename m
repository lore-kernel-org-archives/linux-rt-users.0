From: John Kacur <jkacur@redhat.com>
Subject: Re: cyclictest overflow instance tracking -- irc continued
Date: Tue, 16 Oct 2012 12:56:11 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210161251190.3137@tycho>
References: <507CAF63.7080703@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>, bhavesh@vmware.com,
	linux-rt-users@vger.kernel.org
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44791 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab2JPKyb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Oct 2012 06:54:31 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2907274bkc.19
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Oct 2012 03:54:30 -0700 (PDT)
In-Reply-To: <507CAF63.7080703@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 15 Oct 2012, Frank Rowand wrote:

Thanks for your further review Frank. Bhavesh - I think the right thing to 
do here, is to ask you to respin your patch. Can you make sure you are 
applying and testing against the latest. (0.84). Also, please put any 
white space clean-ups in a separate patch to make it easier to read the 
important patch. Oh, and send these in a new thread. If people could 
preface their mail with [PATCH RT-TESTS] that would also help.

Thank You.

John Kacur

 > 
> 16:13	jkacur	frowand_bot: would you like a Reviewed-by: credit for the cyclictest histogram overflow instance tracking patch?
> 16:13	jkacur	can I just add that or is the reviewer supposed to request it?
> 17:02	frowand	jkacur: sure, you can add my reviewed-by (at least for the first version, i didn't really look at the second version in detail)
> 
> For the first version, it was a drive-by review, just obvious stuff.
> 
> Now that I look at the second version a little closer (but still not in detail), it
> looks like he did some white space clean up, which should probably be a separate patch.
> 
> It also looks like he created his patch against an old version of cyclictest,
> because he has:
> 
> @@ -154,6 +155,7 @@ struct thread_stat {
>  	long redmax;
>  	long cycleofmax;
>  	long hist_overflow;
> +        long num_outliers;
>  };
> 
> 
> but struct thread_stat currently has another field:
> 
>         long redmax;
>         long cycleofmax;
>         long hist_overflow;
>         unsigned long now_after_next;
> };
> 
> and also the line numbers in the patch are off.
> 
> > from #linux-rt:
> > 
> > 17:07	jkacur	frowand: hmm, the patch doesn't appear to be working for me
> > 17:07	jkacur	I'll look at it more tomorrow
> > 17:08	jkacur	Thread 0: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 00007 00008 # 02841 others
> > 17:08	jkacur	is an example of broken output
> 
> 18446744073709551615 is 0xffffffffffffffff (or -1LL)
> 
> It looks like in timerthread(), the line:
> 
> +					stat->outliers[stat->num_outliers++] = stat->cycles - 1;
> 
> is picking up stat->cycles == zero.  Looking at the current version of cyclictest, for the
> first event cycles should already be one at this point.  But given that the line numbers in
> the patch are not consistent with the current cyclictest, I don't know where that chunk
> actually got inserted.
> 
> 
> -Frank
> 
> 
