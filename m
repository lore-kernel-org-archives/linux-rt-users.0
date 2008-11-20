From: "Alessio Igor Bogani" <abogani@texware.it>
Subject: Re: 2.6.27.5 RT patch status (26rt11)
Date: Thu, 20 Nov 2008 14:43:09 +0100
Message-ID: <63a49ef40811200543m75bb49deu4dc1c861b226c481@mail.gmail.com>
References: <20081110234740.GB18819@windriver.com>
	 <20081120132544.GG30491@ghostprotocols.net>
	 <20081120132910.GH30491@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Paul Gortmaker" <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org
To: "Arnaldo Carvalho de Melo" <acme@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:59416 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbYKTNnL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Nov 2008 08:43:11 -0500
Received: by fg-out-1718.google.com with SMTP id 19so365016fgg.17
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Nov 2008 05:43:09 -0800 (PST)
In-Reply-To: <20081120132910.GH30491@ghostprotocols.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear Sir Carvalho de Melo,

2008/11/20 Arnaldo Carvalho de Melo <acme@redhat.com>:
[...]
>> I hit one, DELL PE1900, dual dual core xeon, megasas disk controler,
[...]
>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[...]

Could you try this patch, please?

Thanks!

Ciao,
Alessio

Index: linux-source-2.6.27/kernel/fork.c
===================================================================
--- linux-source-2.6.27.orig/kernel/fork.c  2008-11-11 10:50:21.000000000 +0100
+++ linux-source-2.6.27/kernel/fork.c   2008-11-11 10:50:40.000000000 +0100
@@ -229,7 +229,7 @@
    init_task.signal->rlim[RLIMIT_SIGPENDING] =
        init_task.signal->rlim[RLIMIT_NPROC];

-   for (i = 0; i < NR_CPUS; i++)
+   for (i = 0; i < nr_cpu_ids; i++)
        INIT_LIST_HEAD(&per_cpu(delayed_drop_list, i));
 }
