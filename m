From: "Nelson Castillo" <nelsoneci@gmail.com>
Subject: Re: sched_yield() needed for pthread_cond_signal(..) to work?
Date: Mon, 18 Feb 2008 15:24:14 -0500
Message-ID: <2accc2ff0802181224r41c79cecpdbe0c939df23ef13@mail.gmail.com>
References: <2accc2ff0802181016q26eb8b8cm88f45a0162ae21a0@mail.gmail.com>
	 <20080218182504.GC31432@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	"=?ISO-8859-1?Q?Andr=E9s_Calder=F3n?=" <andres.calderon@emqbit.com>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:62599 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYBRUYQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Feb 2008 15:24:16 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1702254wra.23
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Feb 2008 12:24:15 -0800 (PST)
In-Reply-To: <20080218182504.GC31432@unix.sh>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Feb 18, 2008 1:25 PM, Luis Claudio R. Goncalves <lclaudio@uudg.org> wrote:
> Hi!

Hi Luis, thanks for the reply.

> RT + sched_yield() are not really good friends... sched_yield() messes the
> work of the scheduler. Along with it, sched_tield() behaves in a different
> way under CFS. To get the old behavior you have to:
>
>         echo 1 > /proc/sys/kernel/sched_compat_yield

I see. I guess this is the case with NPTL also.

I will temporally use yield and "echo 1 > /proc/sys/kernel/sched_compat_yield",
but I really want to get this right.

I wonder if what I did with threads is correct but since it will be a little
offtopic in this list I asked in the proper group:

http://groups.google.com/group/comp.programming.threads/browse_thread/thread/110e57bb3290832c

I'll let you know if I find out I'm doing something wrong. Anyway, any help
will be appreciated.

Regards,
Nelson.-

-- 
http://arhuaco.org
