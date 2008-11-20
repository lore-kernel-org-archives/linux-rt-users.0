From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: 2.6.27.5 RT patch status (26rt11)
Date: Thu, 20 Nov 2008 11:46:12 -0200
Message-ID: <20081120134612.GJ30491@ghostprotocols.net>
References: <20081110234740.GB18819@windriver.com> <20081120132544.GG30491@ghostprotocols.net> <20081120132910.GH30491@ghostprotocols.net> <63a49ef40811200543m75bb49deu4dc1c861b226c481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:45846 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbYKTNqT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Nov 2008 08:46:19 -0500
Content-Disposition: inline
In-Reply-To: <63a49ef40811200543m75bb49deu4dc1c861b226c481@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Em Thu, Nov 20, 2008 at 02:43:09PM +0100, Alessio Igor Bogani escreveu:
> Dear Sir Carvalho de Melo,
> 
> 2008/11/20 Arnaldo Carvalho de Melo <acme@redhat.com>:
> [...]
> >> I hit one, DELL PE1900, dual dual core xeon, megasas disk controler,
> [...]
> >> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [...]
> 
> Could you try this patch, please?
> 
> Thanks!
> 
> Ciao,
> Alessio
> 
> Index: linux-source-2.6.27/kernel/fork.c
> ===================================================================
> --- linux-source-2.6.27.orig/kernel/fork.c  2008-11-11 10:50:21.000000000 +0100
> +++ linux-source-2.6.27/kernel/fork.c   2008-11-11 10:50:40.000000000 +0100
> @@ -229,7 +229,7 @@
>     init_task.signal->rlim[RLIMIT_SIGPENDING] =
>         init_task.signal->rlim[RLIMIT_NPROC];
> 
> -   for (i = 0; i < NR_CPUS; i++)
> +   for (i = 0; i < nr_cpu_ids; i++)
>         INIT_LIST_HEAD(&per_cpu(delayed_drop_list, i));
>  }

Thanks, looks like this should fix this, I'll test and report back.

- Arnaldo
